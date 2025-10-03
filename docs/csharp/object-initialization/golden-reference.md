# Object Initialization

## Overview

Object initialization solves the problem of creating an object and setting its properties in a single expression. Rather than creating an object and then setting properties in separate statements, you can declare the object and configure it all at once.

Object initialization encompasses several patterns: object initializer syntax for setting properties, collection initialization for collection properties, constructor parameters for required values, and special features like init-only properties and required members for ensuring object validity.

```csharp
// Constructor with parameters for required values
Person person1 = new Person("John", 30);

// Object initializer for property configuration
Person person2 = new Person { Name = "John", Age = 30 };

// Target-typed syntax eliminates redundancy
Person person3 = new() { Name = "John", Age = 30 };
```

## Basic Object Initializer Syntax

### Simple Property Initialization

Object initializers set properties after the constructor runs:

```csharp
public class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
    public string Email { get; set; }
}

// Object initializer syntax
Person person = new Person
{
    Name = "Alice Johnson",
    Age = 28,
    Email = "alice@example.com"
};

// Target-typed new
Person modernPerson = new()
{
    Name = "Bob Smith",
    Age = 35,
    Email = "bob@example.com"
};
```

### Combining Constructors and Initializers

Constructors handle required parameters, initializers handle optional configuration:

```csharp
public class Person
{
    public Person(string name)
    {
        Name = name;
    }

    public string Name { get; }
    public int Age { get; set; }
    public string City { get; set; }
}

// Constructor provides required name, initializer sets optional properties
Person person = new Person("Charlie")
{
    Age = 42,
    City = "Seattle"
};
```

### Nested Object Initialization

Objects can initialize their nested object properties:

```csharp
public class Address
{
    public string Street { get; set; }
    public string City { get; set; }
    public string ZipCode { get; set; }
}

public class Person
{
    public string Name { get; set; }
    public Address HomeAddress { get; set; }
    public Address WorkAddress { get; set; }
}

// Nested initialization
Person person = new Person
{
    Name = "David Wilson",
    HomeAddress = new Address
    {
        Street = "123 Main St",
        City = "Portland",
        ZipCode = "97201"
    },
    WorkAddress = new()
    {
        Street = "456 Corporate Blvd",
        City = "Portland",
        ZipCode = "97205"
    }
};
```

## Collection Properties

### Using Collection Expressions

Collection expressions provide the clearest syntax for initializing collection properties:

```csharp
public class Team
{
    public string Name { get; set; }
    public List<string> Members { get; set; } = new();
    public string[] Tags { get; set; }
}

// Collection expressions for collection properties
Team team = new Team
{
    Name = "Development Team",
    Members = ["Alice", "Bob", "Charlie"],
    Tags = ["backend", "frontend", "devops"]
};
```

### Dictionary Properties

Dictionaries use initializer syntax since collection expressions don't support them:

```csharp
public class Configuration
{
    public string AppName { get; set; }
    public Dictionary<string, string> Settings { get; set; } = new();
    public Dictionary<string, int> Limits { get; set; } = new();
}

// Dictionary initialization within object
Configuration config = new()
{
    AppName = "MyApplication",
    Settings = new()
    {
        ["Environment"] = "Production",
        ["LogLevel"] = "Information",
        ["Theme"] = "Dark"
    },
    Limits = new()
    {
        { "MaxUsers", 1000 },
        { "TimeoutSeconds", 30 }
    }
};
```

### Complex Nested Collections

Combine collection expressions with other initialization patterns:

```csharp
public class Project
{
    public string Name { get; set; }
    public List<Team> Teams { get; set; } = new();
    public Dictionary<string, List<string>> Resources { get; set; } = new();
}

// Complex nested initialization
Project project = new()
{
    Name = "Enterprise Application",
    Teams =
    [
        new()
        {
            Name = "Backend Team",
            Members = ["Alice", "Bob"]
        },
        new()
        {
            Name = "Frontend Team",
            Members = ["Charlie", "Diana"]
        }
    ],
    Resources = new()
    {
        ["Documentation"] = ["API Spec", "User Guide"],
        ["Tools"] = ["Visual Studio", "Postman"]
    }
};
```

## Init-Only Properties

Init-only properties can only be set during object initialization, creating immutable objects:

```csharp
public class ImmutablePerson
{
    public string Name { get; init; }
    public int Age { get; init; }
    public DateTime CreatedAt { get; init; } = DateTime.UtcNow;
}

// Can only set during initialization
ImmutablePerson person = new()
{
    Name = "Emma",
    Age = 29
    // CreatedAt uses default value
};

// person.Name = "New Name"; // Compile error - cannot modify after construction
```

### Init Properties with Collections

Init properties work with collection properties:

```csharp
public class ReadOnlyTeam
{
    public string Name { get; init; }
    public List<string> Members { get; init; } = new();
    public IReadOnlyList<string> ReadOnlyMembers => Members.AsReadOnly();
}

// Initialize collections during object creation
ReadOnlyTeam team = new()
{
    Name = "Alpha Team",
    Members = ["John", "Jane", "Jim"]
};
```

### Records with Init Properties

Records automatically provide init properties for primary constructor parameters:

```csharp
// Record with automatic init properties
public record PersonRecord(string Name, int Age)
{
    public List<string> Skills { get; init; } = new();
}

// Clean record initialization
PersonRecord person = new("Alice", 30)
{
    Skills = ["C#", "JavaScript", "SQL"]
};

// With expression for copying with changes
PersonRecord olderPerson = person with { Age = 31 };
```

## Required Members

Required members must be initialized, enforcing complete object construction:

```csharp
public class RequiredFieldsPerson
{
    public required string Name { get; init; }
    public required string Email { get; init; }
    public int Age { get; init; }
    public string? Phone { get; init; }
}

// Must initialize required properties
RequiredFieldsPerson person = new()
{
    Name = "Required Name",        // Must provide
    Email = "required@email.com",  // Must provide
    Age = 25,                      // Optional
    // Phone can be omitted (nullable)
};
```

### Required with Constructors

The `SetsRequiredMembers` attribute indicates a constructor satisfies required members:

```csharp
public class Product
{
    public Product() { }

    [SetsRequiredMembers]
    public Product(string name, decimal price)
    {
        Name = name;
        Price = price;
    }

    public required string Name { get; init; }
    public required decimal Price { get; init; }
    public string? Description { get; init; }
}

// Two ways to satisfy required members
Product product1 = new()
{
    Name = "Widget",
    Price = 19.99m
};

Product product2 = new("Another Widget", 29.99m)
{
    Description = "Optional description"
};
```

## Anonymous Types

Anonymous types create objects without explicitly defining a type:

```csharp
// Anonymous type creation
var person = new { Name = "John", Age = 30, City = "Seattle" };
var product = new { Id = 1, Name = "Widget", Price = 19.99 };

// Properties are read-only
Console.WriteLine($"{person.Name} is {person.Age} years old");
// person.Age = 31; // Compile error - read-only
```

### Anonymous Types with Collections

Anonymous types can contain collection properties:

```csharp
var team = new
{
    Name = "Development Team",
    Members = new[] { "Alice", "Bob", "Charlie" },
    Lead = new { Name = "Diana", Experience = 5 }
};

// Or with collection expressions
var modernTeam = new
{
    Name = "Development Team",
    Members = new[] { "Alice", "Bob", "Charlie" }, // Anonymous types don't support collection expression syntax directly
    Lead = new { Name = "Diana", Experience = 5 }
};
```

### Anonymous Types in LINQ

LINQ queries commonly use anonymous types for projections:

```csharp
List<Person> people =
[
    new() { Name = "Alice", Age = 30, City = "Seattle" },
    new() { Name = "Bob", Age = 25, City = "Portland" }
];

// Project to anonymous type
var summary = people.Select(p => new
{
    p.Name,
    AgeGroup = p.Age < 30 ? "Young" : "Adult",
    Location = p.City
}).ToList();
```

## Why Object Initialization Matters

### Immutable Object Construction

Object initialization enables creation of immutable objects with clean syntax:

```csharp
// Immutable record with init properties
public record Person(string Name, int Age)
{
    public List<string> Hobbies { get; init; } = new();
}

// Clean initialization
Person person = new("John", 30)
{
    Hobbies = ["Reading", "Gaming"]
};
```

### Reduced Constructor Proliferation

Object initializers eliminate the need for multiple constructor overloads:

```csharp
// Without initializers - many constructors needed
public class PersonOld
{
    public PersonOld(string name) { }
    public PersonOld(string name, int age) { }
    public PersonOld(string name, int age, string city) { }
    // ... many more combinations
}

// With initializers - single constructor, flexible initialization
public class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
    public string City { get; set; }
}
```

### Self-Documenting Code

Object initialization makes code intentions clear:

```csharp
var configuration = new AppConfiguration
{
    DatabaseConnectionString = "Server=localhost;Database=MyApp",
    MaxRetryAttempts = 3,
    TimeoutMinutes = 30,
    EnableLogging = true
};
```

## Advanced Initialization Patterns

### Conditional Initialization

Use conditional expressions within initializers:

```csharp
bool isProduction = true;

var config = new Configuration
{
    Environment = isProduction ? "Production" : "Development",
    LogLevel = isProduction ? "Warning" : "Debug",
    Settings = isProduction
        ? new() { ["Cache"] = "Redis" }
        : new() { ["Cache"] = "Memory" }
};
```

### Factory Methods with Initialization

Factory methods can return objects ready for further initialization:

```csharp
public class PersonFactory
{
    public static Person CreateEmployee(string name, string department)
    {
        return new Person
        {
            Name = name,
            Department = department,
            CreatedAt = DateTime.UtcNow,
            Status = "Active",
            Permissions = ["Read", "Write"]
        };
    }
}

// Use factory with additional initialization
Person employee = PersonFactory.CreateEmployee("John", "Engineering")
{
    Email = "john@company.com",
    Manager = new() { Name = "Jane Smith" }
};
```

### Builder Pattern Integration

Builders can be combined with object initialization:

```csharp
public class PersonBuilder
{
    private Person _person = new();

    public PersonBuilder WithName(string name)
    {
        _person.Name = name;
        return this;
    }

    public PersonBuilder WithAge(int age)
    {
        _person.Age = age;
        return this;
    }

    public Person Build() => _person;
}

// Combine builder with object initialization
Person person = new PersonBuilder()
    .WithName("Alice")
    .WithAge(30)
    .Build() with
    {
        Email = "alice@example.com",
        Skills = ["C#", "Azure"]
    };
```

## Performance Considerations

### Property Access

Object initialization calls property setters after the constructor:

```csharp
// Object initialization calls property setters
Person person = new()  // Constructor called first
{
    Name = "John",     // Name setter called
    Age = 30          // Age setter called
};

// Equivalent to:
Person person2 = new Person();
person2.Name = "John";
person2.Age = 30;
```

### Collection Capacity

Pre-size collection properties when the size is known:

```csharp
// Efficient: Initialize collections with capacity when known
var largeDataSet = new DataContainer
{
    Items = new List<DataItem>(10000),  // Pre-sized
    Index = new Dictionary<string, int>(10000),  // Pre-sized
    Metadata = new()
    {
        Created = DateTime.UtcNow,
        Version = "1.0"
    }
};
```

## Integration with Modern C# Features

### Pattern Matching

Initialize and immediately pattern match:

```csharp
// Initialize and immediately pattern match
var result = new ProcessingResult { Status = "Success", Data = [1, 2, 3] }
switch
{
    { Status: "Success", Data: { Length: > 0 } } => "Processing completed successfully",
    { Status: "Error" } => "Processing failed",
    _ => "Unknown status"
};
```

### Deconstruction

Objects with deconstruction methods can be initialized and deconstructed:

```csharp
public class Point
{
    public double X { get; init; }
    public double Y { get; init; }

    public void Deconstruct(out double x, out double y) => (x, y) = (X, Y);
}

// Initialize and deconstruct
var point = new Point { X = 3.0, Y = 4.0 };
var (x, y) = point;
```

## Best Practices

1. **Use init properties for immutability**: Prefer `init` over `set` for immutable objects
2. **Mark required members**: Use `required` for essential properties
3. **Combine constructors and initializers**: Use constructors for required parameters, initializers for optional configuration
4. **Pre-size collections**: Initialize collection properties with appropriate capacity when known
5. **Use collection expressions**: Prefer collection expressions for collection properties when values are known
6. **Consider records for data objects**: Use records with init properties for simple data containers
7. **Use anonymous types for temporary data**: Leverage anonymous types for short-lived projections

## Common Patterns and Pitfalls

### Good Patterns

```csharp
// Good: Clear intent, immutable after construction
public class User
{
    public required string Username { get; init; }
    public required string Email { get; init; }
    public List<string> Roles { get; init; } = new();
    public DateTime CreatedAt { get; init; } = DateTime.UtcNow;
}

var user = new User
{
    Username = "john_doe",
    Email = "john@example.com",
    Roles = ["User", "Contributor"]
};
```

### Pitfalls to Avoid

```csharp
// Avoid: Mutable objects with no validation
public class BadUser
{
    public string Username { get; set; }  // Could be null or empty
    public string Email { get; set; }     // No validation
    public List<string> Roles { get; set; } // Could be null
}

// Avoid: Overly complex initialization
var complexObject = new ComplexObject
{
    Property1 = new AnotherObject
    {
        NestedProperty = new ThirdObject
        {
            DeeplyNested = new FourthObject
            {
                // Too deep - consider factory methods or builder pattern
                Value = "This is getting hard to read"
            }
        }
    }
};
```

### Validation During Initialization

Property setters can validate during initialization:

```csharp
public class ValidatedUser
{
    private string _email;

    public required string Username { get; init; }

    public required string Email
    {
        get => _email;
        init => _email = IsValidEmail(value) ? value : throw new ArgumentException("Invalid email");
    }

    private static bool IsValidEmail(string email) => email?.Contains("@") == true;
}

// Validation occurs during initialization
try
{
    var user = new ValidatedUser
    {
        Username = "john",
        Email = "invalid-email"  // Will throw exception
    };
}
catch (ArgumentException ex)
{
    Console.WriteLine($"Initialization failed: {ex.Message}");
}
```
