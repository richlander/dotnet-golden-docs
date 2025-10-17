# Object Initialization
## Good Object Initialization Patterns
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

## Good Object Initialization Patterns

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
