# C# 14
## Property Validation Patterns with Field Keyword
### Null-Conditional Assignment

Streamlined null-safe assignment operations.

```csharp
// Traditional pattern
if (person.Address != null)
{
    person.Address.City = "New York";
}

// New null-conditional assignment
person.Address?.City = "New York";

// Works with indexers too
dictionary?[key] = value;
array?[index] = item;

// Useful for optional initialization
config?.Settings["theme"] = "dark";
```

### User-Defined Compound Assignment Operators

Custom types can define compound assignment operators directly.

```csharp
public struct Vector2
{
    public float X, Y;

    // Define compound assignment operators
    public static Vector2 operator +=(Vector2 left, Vector2 right)
        => new(left.X + right.X, left.Y + right.Y);

    public static Vector2 operator *=(Vector2 left, float scalar)
        => new(left.X * scalar, left.Y * scalar);
}

// Natural usage
Vector2 velocity = new(10, 5);
velocity += new Vector2(2, 3); // Uses custom +=
velocity *= 1.5f;              // Uses custom *=
```

### Optional and Named Arguments in Expression Trees

LINQ expression trees now support optional parameters and named arguments.

```csharp
// Method with optional parameters
public static void LogMessage(string message, LogLevel level = LogLevel.Info,
                            string category = "General")
{
    Console.WriteLine($"[{level}] {category}: {message}");
}

// Expression tree with optional and named arguments
Expression<Action> expr = () => LogMessage("Hello", category: "App");

// Previously would fail, now works correctly
var compiled = expr.Compile();
compiled(); // "[Info] App: Hello"
```

## Property Validation Patterns with Field Keyword

The `field` keyword enables common validation patterns without boilerplate.

```csharp
public class ValidationExample
{
    public string Email
    {
        get => field;
        set => field = IsValidEmail(value) ? value :
                       throw new ArgumentException("Invalid email format");
    }

    public decimal Price
    {
        get => field;
        set => field = Math.Max(0, Math.Round(value, 2));
    }
}
```
