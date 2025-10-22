# Type Extensions
## Essential Features & Examples

### Extension Syntax (C# 14)

Extension blocks provide a unified syntax for declaring multiple extension members for a type.

```csharp
public static class StringExtensions
{
    extension (string text)
    {
        // Instance property
        public bool IsNullOrEmpty => string.IsNullOrEmpty(text);
        
        // Instance method
        public int WordCount() => text.Split(' ', StringSplitOptions.RemoveEmptyEntries).Length;
        
        // Method with parameters
        public string Truncate(int maxLength) => 
            text.Length <= maxLength ? text : text[..maxLength] + "...";
    }
}

// Usage feels natural
string message = "Hello World";
Console.WriteLine(message.IsNullOrEmpty);  // False
Console.WriteLine(message.WordCount());     // 2
Console.WriteLine(message.Truncate(5));     // "Hello..."
```

### Static Extension Members

C# 14 enables extending types themselves, not just instances.

```csharp
public static class PointExtensions
{
    extension (Point)
    {
        // Static property on the type itself
        public static Point Origin => new Point(0, 0);
        public static Point UnitX => new Point(1, 0);
        public static Point UnitY => new Point(0, 1);
    }
}

// Use like native static members
Point center = Point.Origin;
Point right = Point.UnitX;
```

### Extension Operators

Extension blocks support operator overloading for existing types.

```csharp
public static class PointOperators
{
    extension (Point)
    {
        // Arithmetic operators
        public static Point operator +(Point left, Point right) =>
            new Point(left.X + right.X, left.Y + right.Y);
        
        public static Point operator -(Point left, Point right) =>
            new Point(left.X - right.X, left.Y - right.Y);
        
        public static Point operator *(Point point, int scalar) =>
            new Point(point.X * scalar, point.Y * scalar);
        
        // Tuple-based operations
        public static Point operator +(Point point, (int dx, int dy) delta) =>
            new Point(point.X + delta.dx, point.Y + delta.dy);
    }
}

// Natural mathematical syntax
Point p1 = new Point(10, 20);
Point p2 = new Point(5, 3);
Point result = p1 + p2;              // (15, 23)
Point scaled = p1 * 2;                // (20, 40)
Point shifted = p1 + (5, -10);        // (15, 10)
```
