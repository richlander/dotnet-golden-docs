# Properties and Backing Fields

## Overview

Properties provide a flexible mechanism to read, write, or compute values while appearing as public data members. They use special methods called accessors (`get` and `set`) that enable validation, computation, and controlled access to data. Properties eliminate the need for explicit getter and setter methods while maintaining encapsulation.

The compiler can generate backing fields automatically for properties, which can be accessed with a compiler-synthesized backing field using the `field` keyword, which custom logic is needed. Properties support various access patterns including read-only, write-only, init-only, and required initialization.

## Quick Reference

**Auto-implemented properties** - Simple data storage without validation:
```csharp
public string Name { get; set; }
```

**Field-backed properties** - Need validation or transformation:
```csharp
public int Age
{
    get => field;
    set => field = value < 0 ? 0 : value;
}
```

**Init-only properties** - Immutable after construction:
```csharp
public string Id { get; init; } = Guid.NewGuid().ToString();
```

**Required properties** - Must be initialized by callers:
```csharp
public required string Name { get; set; }
```

**Computed properties** - Derived from other data:
```csharp
public string FullName => $"{FirstName} {LastName}";
```

**With records** - Mix primary constructor with additional properties:
```csharp
public record Product(string Name, decimal Price)
{
    public int Quantity { get; set; }
    public DateTime Created { get; init; } = DateTime.UtcNow;
}
```

## Auto-Implemented Properties

Auto-implemented properties let the compiler generate a private backing field and simple accessor implementations. This reduces boilerplate for properties that don't need custom logic.

```csharp
public class Product
{
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public int Quantity { get; set; }
}
```

The compiler creates a hidden backing field for each property. You cannot reference this field directly in your code unless you use the `field` keyword (see Field-Backed Properties section).

**Initialization:** Set initial values using property initializers:

```csharp
public class Configuration
{
    public string ConnectionString { get; set; } = "DefaultConnection";
    public int Timeout { get; set; } = 30;
    public bool EnableLogging { get; set; } = true;
}
```

**With records:** Records can mix primary constructor parameters with additional properties:

```csharp
public record Product(string Name, decimal Price)
{
    public int Quantity { get; set; }
    public DateTime Created { get; init; } = DateTime.UtcNow;
}

var product = new Product("Laptop", 999.99m)
{
    Quantity = 5
};
```

**Attributes on backing fields:** Apply attributes to the compiler-generated backing field using the `field:` target:

```csharp
public class DataModel
{
    [field: NonSerialized]
    public string TempData { get; set; }
}
```

## Field-Backed Properties

The `field` keyword accesses the compiler-synthesized backing field in a property accessor. This enables custom logic without explicitly declaring a separate backing field.

```csharp
public class Employee
{
    public string Name
    {
        get => field;
        set => field = string.IsNullOrWhiteSpace(value)
            ? throw new ArgumentException("Name cannot be empty")
            : value;
    }
    
    public int Age
    {
        get => field;
        set => field = value < 0 ? 0 : value > 150 ? 150 : value;
    }
}
```

**Common validation patterns:**

```csharp
public class Account
{
    public decimal Balance
    {
        get => field;
        set => field = value >= 0 
            ? value 
            : throw new ArgumentException("Balance cannot be negative");
    }
    
    public string Email
    {
        get => field;
        set
        {
            if (!value.Contains("@"))
                throw new ArgumentException("Invalid email format");
            field = value.ToLowerInvariant();
        }
    }
}
```

The `field` keyword can only be used in property accessors. You can use it in either the `get` or `set` accessor, or both. This provides a smooth upgrade path from auto-implemented properties when you need to add validation or transformation logic.

## Init-Only Properties

Init-only properties use the `init` accessor to allow property assignment only during object construction. After construction completes, the property becomes read-only.

```csharp
public class Person
{
    public string FirstName { get; init; } = string.Empty;
    public string LastName { get; init; } = string.Empty;
    public DateTime BirthDate { get; init; }
}

// Usage
var person = new Person
{
    FirstName = "John",
    LastName = "Doe",
    BirthDate = new DateTime(1990, 1, 1)
};

// person.FirstName = "Jane"; // Error: init accessor can only be called during initialization
```

**With records:** Record primary constructor parameters are init-only by default:

```csharp
public record Customer(string Name, string Email)
{
    public string? Phone { get; init; } // Additional init-only property
}

var customer = new Customer("John Doe", "john@example.com")
{
    Phone = "555-1234"
};

// customer.Name = "Jane"; // Error: init-only property
```

Init-only properties work with object initializers and constructors:

```csharp
public class Configuration
{
    public string Environment { get; init; } = "Development";
    public int Port { get; init; } = 5000;
    
    public Configuration() { }
    
    public Configuration(string environment)
    {
        Environment = environment; // Valid in constructor
    }
}
```

## Required Properties

The `required` modifier (C# 11) forces callers to initialize a property using an object initializer or a constructor marked with `SetsRequiredMembers`.

```csharp
public class Customer
{
    public required string Name { get; set; }
    public required string Email { get; set; }
    public string? Phone { get; set; } // Optional
}

// Must initialize required properties
var customer = new Customer
{
    Name = "John Doe",
    Email = "john@example.com"
}; // Phone is optional

// var invalid = new Customer(); // Error: required members not initialized
```

**With records:** Combine required properties with primary constructor parameters:

```csharp
public record Order(string OrderId, DateTime OrderDate)
{
    public required string CustomerId { get; init; }
    public decimal Total { get; set; }
}

var order = new Order("ORD-001", DateTime.UtcNow)
{
    CustomerId = "CUST-123",
    Total = 99.99m
};
```

**Constructors and required members:** Mark constructors that initialize all required members with `SetsRequiredMembers`:

```csharp
public class Customer
{
    public required string Name { get; set; }
    public required string Email { get; set; }
    
    [SetsRequiredMembers]
    public Customer(string name, string email)
    {
        Name = name;
        Email = email;
    }
}

// Both valid:
var c1 = new Customer("John", "john@example.com");
var c2 = new Customer { Name = "Jane", Email = "jane@example.com" };
```

**Required vs nullable:** `required` and nullable are independent. A `required` property can be nullable, and a nullable property can be required:

```csharp
public class Document
{
    public required string? Title { get; set; } // Required but can be null
    public string? Description { get; set; } // Optional and nullable
}

var doc = new Document { Title = null }; // Valid: Title is set to null
```

## Read-Only Properties

Properties can be read-only in different ways depending on requirements.

**Get-only auto-property:** Can only be set in constructors:

```csharp
public class ImmutablePerson
{
    public string Name { get; }
    public DateTime Created { get; } = DateTime.UtcNow;
    
    public ImmutablePerson(string name)
    {
        Name = name;
    }
}
```

**Expression-bodied read-only property:** Computed each time it's accessed:

```csharp
public class Person
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    
    public string FullName => $"{FirstName} {LastName}";
}
```

**Private setter:** Allows modification within the class:

```csharp
public class Counter
{
    public int Count { get; private set; }
    
    public void Increment() => Count++;
    public void Reset() => Count = 0;
}
```

## Computed Properties

Computed properties calculate values from other data rather than storing values directly.

```csharp
public class Rectangle
{
    public double Width { get; set; }
    public double Height { get; set; }
    
    public double Area => Width * Height;
    public double Perimeter => 2 * (Width + Height);
    public bool IsSquare => Width == Height;
}
```

**Cached computed properties:** Calculate once and cache the result:

```csharp
public class Person
{
    private string? _fullName;
    
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    
    public string FullName
    {
        get
        {
            if (_fullName == null)
                _fullName = $"{FirstName} {LastName}";
            return _fullName;
        }
    }
    
    public void InvalidateCache()
    {
        _fullName = null;
    }
}
```

## Access Modifiers

Properties support different access levels for `get` and `set` accessors.

```csharp
public class BankAccount
{
    // Public read, private write
    public decimal Balance { get; private set; }
    
    // Public read, protected write
    public DateTime LastModified { get; protected set; }
    
    // Internal read, private write
    internal string AccountId { get; private set; } = Guid.NewGuid().ToString();
    
    public void Deposit(decimal amount)
    {
        Balance += amount;
        LastModified = DateTime.UtcNow;
    }
}
```

The accessor with the more restrictive modifier must be more restrictive than the property's overall accessibility. You cannot have a `private` property with a `public` accessor.

## Considerations

- **Auto-property backing field:** Cannot access the compiler-generated backing field directly except through the `field` keyword.
- **Init accessor restriction:** More restrictive than `private set`. Can only be called during object initialization or in constructors.
- **Required and nullable:** `required` enforces initialization, not non-null. A `required string?` property must be initialized but can be set to `null`.
- **Field keyword preview:** The `field` keyword is a preview feature in C# 13 and may have syntax changes.
- **Expression-bodied properties:** Cannot have a setter. They're inherently read-only.
- **Accessor access modifiers:** Individual accessor modifiers must be more restrictive than the property's overall accessibility.
- **Partial properties:** Cannot use auto-property syntax for the implementing declaration. Use explicit accessors or the `field` keyword.

## See Also

- Partial Classes (partial properties)
- Records and Primary Constructors (primary constructor parameters as properties)
- Object Initialization (object initializers with properties)
