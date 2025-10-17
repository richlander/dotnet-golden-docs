# Properties and Backing Fields
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
