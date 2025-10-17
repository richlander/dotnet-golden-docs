# Properties and Backing Fields
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
