# Type Extensions
## Gotchas & Limitations
### Ref Extension Limitations

Ref extensions only work with value types and struct-constrained generics.

```csharp
public static class RefExtensions
{
    // VALID: struct type
    extension (ref Point point)
    {
        public void Reset() => point = default;
    }
    
    // INVALID: reference type
    extension (ref string text) // Compile error
    {
        public void Clear() => text = string.Empty;
    }
    
    // VALID: struct constraint
    extension<T> (ref T value) where T : struct
    {
        public void Reset() => value = default;
    }
}
```

### Extension Operator Constraints

Extension operators must follow standard operator rules.

```csharp
public static class OperatorExtensions
{
    extension (Point)
    {
        // VALID: Standard binary operator
        public static Point operator +(Point left, Point right) =>
            new Point(left.X + right.X, left.Y + right.Y);
        
        // INVALID: Must be public static
        public Point operator -(Point left, Point right) => // Error
            new Point(left.X - right.X, left.Y - right.Y);
        
        // INVALID: Wrong return type for compound assignment
        public static int operator +=(Point left, Point right) => // Error
            left.X + right.X;
    }
}
```

### Binary Compatibility

Extension members compile to static methods, maintaining binary compatibility.

```csharp
// Extension definition
public static class Extensions
{
    extension (string text)
    {
        public int WordCount() => text.Split().Length;
    }
}

// Compiles to (simplified)
public static class Extensions
{
    public static int WordCount(string text) => text.Split().Length;
}

// Both syntaxes work
string text = "Hello World";
int count1 = text.WordCount();           // Extension syntax
int count2 = Extensions.WordCount(text); // Static method syntax
```
