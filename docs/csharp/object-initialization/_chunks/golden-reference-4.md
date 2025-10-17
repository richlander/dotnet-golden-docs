# Object Initialization
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
