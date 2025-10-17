# Properties and Backing Fields
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
