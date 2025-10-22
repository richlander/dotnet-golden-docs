# Type Extensions

## Overview

Type extensions in C# enable developers to augment existing types with additional members — methods, properties, and operators — without modifying the original type's source code or creating derived types. C# 14 introduces a new `extension` block syntax that unifies and expands upon the traditional extension method pattern. The new extension syntax supports both instance and static members, including properties and operators, providing a more natural and comprehensive way to extend types throughout the .NET ecosystem.

Extension members are particularly valuable when working with types you don't control, such as framework types, third-party libraries, or sealed classes. They enable you to create domain-specific APIs, implement the Adapter pattern, and add LINQ-like query capabilities to custom collections. The compiler transforms extension members into static methods, ensuring no runtime overhead while maintaining the illusion of native type members.

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

### Traditional Extension Methods

The original extension method syntax remains fully supported and compatible.

```csharp
public static class EnumerableExtensions
{
    // Traditional syntax with 'this' modifier
    public static bool IsEmpty<T>(this IEnumerable<T> source)
    {
        return !source.Any();
    }
    
    public static void ForEach<T>(this IEnumerable<T> source, Action<T> action)
    {
        foreach (var item in source)
            action(item);
    }
}

// Usage identical to modern syntax
var numbers = new List<int> { 1, 2, 3 };
if (!numbers.IsEmpty())
    numbers.ForEach(n => Console.WriteLine(n));
```

### Ref Extension Methods

Modify struct instances directly without creating copies.

```csharp
public static class StructExtensions
{
    // Traditional ref syntax
    public static void Scale(this ref Point point, int factor)
    {
        point.X *= factor;
        point.Y *= factor;
    }
    
    // Modern extension block syntax for ref
    extension (ref Point point)
    {
        public void Reset()
        {
            point = new Point(0, 0);
        }
        
        public void Normalize()
        {
            int max = Math.Max(Math.Abs(point.X), Math.Abs(point.Y));
            if (max > 0)
            {
                point.X /= max;
                point.Y /= max;
            }
        }
    }
}

// Direct modification without reassignment
Point p = new Point(10, 20);
p.Scale(2);      // Traditional: p is now (20, 40)
p.Normalize();   // Modern: p is now (1, 2)
p.Reset();       // Modern: p is now (0, 0)
```

### Generic Extensions

Extension members support generic type parameters for maximum flexibility.

```csharp
public static class CollectionExtensions
{
    extension<T> (IEnumerable<T> source)
    {
        public bool IsNullOrEmpty() => source == null || !source.Any();
        
        public IEnumerable<T> WhereNot(Func<T, bool> predicate) => 
            source.Where(item => !predicate(item));
        
        public Dictionary<TKey, T> ToDictionary<TKey>(Func<T, TKey> keySelector) 
            where TKey : notnull =>
            source.ToDictionary(keySelector);
    }
}

// Works with any IEnumerable<T>
var numbers = new[] { 1, 2, 3, 4, 5 };
var evens = numbers.WhereNot(n => n % 2 == 1);
var dict = evens.ToDictionary(n => n);
```

## Migration from Traditional to Modern Syntax

The traditional and modern syntaxes are fully compatible and can coexist.

```csharp
public static class MixedExtensions
{
    // Traditional method
    public static bool IsValidEmail(this string email)
    {
        return email.Contains('@') && email.Contains('.');
    }
    
    // Modern extension block
    extension (string text)
    {
        public bool IsValidUrl() => 
            Uri.TryCreate(text, UriKind.Absolute, out _);
        
        public string Capitalize() =>
            string.IsNullOrEmpty(text) ? text : 
            char.ToUpper(text[0]) + text[1..];
    }
}
```

### Migration Benefits

When migrating to the modern syntax, you gain:

1. **Unified declaration**: Group related extensions in one block
2. **Static members**: Add type-level properties and methods
3. **Operators**: Enable natural mathematical operations
4. **Properties**: Computed values without method call syntax
5. **Consistency**: Same syntax for all extension types

```csharp
// Before: Multiple traditional methods
public static class OldExtensions
{
    public static bool IsEmpty<T>(this ICollection<T> collection) => 
        collection.Count == 0;
    
    public static bool IsNotEmpty<T>(this ICollection<T> collection) => 
        collection.Count > 0;
    
    public static void AddRange<T>(this ICollection<T> collection, 
        IEnumerable<T> items)
    {
        foreach (var item in items) collection.Add(item);
    }
}

// After: Unified extension block
public static class NewExtensions
{
    extension<T> (ICollection<T> collection)
    {
        public bool IsEmpty => collection.Count == 0;
        public bool IsNotEmpty => collection.Count > 0;
        
        public void AddRange(IEnumerable<T> items)
        {
            foreach (var item in items) collection.Add(item);
        }
    }
}
```

## Real-World Patterns

### Domain-Specific Extensions

Create fluent APIs for your domain.

```csharp
public static class DateTimeExtensions
{
    extension (DateTime date)
    {
        public bool IsWeekend => 
            date.DayOfWeek == DayOfWeek.Saturday || 
            date.DayOfWeek == DayOfWeek.Sunday;
        
        public bool IsBusinessDay => !IsWeekend;
        
        public DateTime NextBusinessDay()
        {
            var next = date.AddDays(1);
            while (!next.IsBusinessDay)
                next = next.AddDays(1);
            return next;
        }
        
        public DateTime StartOfWeek() =>
            date.AddDays(-(int)date.DayOfWeek);
        
        public DateTime EndOfMonth() =>
            new DateTime(date.Year, date.Month, 
                DateTime.DaysInMonth(date.Year, date.Month));
    }
}

// Natural domain language
DateTime today = DateTime.Today;
if (today.IsBusinessDay)
{
    DateTime deadline = today.NextBusinessDay().EndOfMonth();
}
```

### LINQ-Style Query Extensions

Extend collections with custom query operators.

```csharp
public static class QueryExtensions
{
    extension<T> (IEnumerable<T> source)
    {
        public IEnumerable<T> DistinctBy<TKey>(Func<T, TKey> keySelector)
        {
            var seen = new HashSet<TKey>();
            foreach (var item in source)
            {
                if (seen.Add(keySelector(item)))
                    yield return item;
            }
        }
        
        public IEnumerable<IEnumerable<T>> Batch(int size)
        {
            var batch = new List<T>(size);
            foreach (var item in source)
            {
                batch.Add(item);
                if (batch.Count == size)
                {
                    yield return batch;
                    batch = new List<T>(size);
                }
            }
            if (batch.Count > 0)
                yield return batch;
        }
        
        public T? MaxBy<TKey>(Func<T, TKey> keySelector) 
            where TKey : IComparable<TKey>
        {
            return source.OrderByDescending(keySelector).FirstOrDefault();
        }
    }
}

// Chainable query operations
var people = GetPeople();
var batches = people
    .DistinctBy(p => p.Email)
    .Batch(100)
    .ToList();
```

### Adapter Pattern Implementation

Adapt existing types to required interfaces.

```csharp
public static class StreamExtensions
{
    extension (Stream stream)
    {
        public async Task<string> ReadAllTextAsync()
        {
            using var reader = new StreamReader(stream);
            return await reader.ReadToEndAsync();
        }
        
        public async Task WriteAllTextAsync(string content)
        {
            using var writer = new StreamWriter(stream);
            await writer.WriteAsync(content);
            await writer.FlushAsync();
        }
        
        public void CopyToFile(string path)
        {
            using var file = File.Create(path);
            stream.CopyTo(file);
        }
    }
}
```

## Gotchas & Limitations

### Extension Method Resolution

Extensions don't override instance methods.

```csharp
public class MyClass
{
    public void DoSomething() => Console.WriteLine("Instance method");
}

public static class Extensions
{
    extension (MyClass obj)
    {
        // This will NEVER be called if instance method exists
        public void DoSomething() => Console.WriteLine("Extension");
    }
}

var obj = new MyClass();
obj.DoSomething(); // Always calls instance method: "Instance method"
```

### Scope and Visibility

Extensions require explicit namespace imports.

```csharp
namespace MyApp.Extensions
{
    public static class StringExtensions
    {
        extension (string text)
        {
            public bool IsNumeric() => int.TryParse(text, out _);
        }
    }
}

namespace MyApp
{
    // Error: IsNumeric not available without 'using'
    void Test()
    {
        "123".IsNumeric(); // Compile error
    }
}

namespace MyApp.WithImport
{
    using MyApp.Extensions;
    
    void Test()
    {
        "123".IsNumeric(); // Works
    }
}
```

### Generic Type Inference

All type parameters must be inferrable from the receiver and member parameters.

```csharp
public static class InvalidExtensions
{
    // ERROR: T1 not inferrable
    extension<T1> (string text)
    {
        public void Method() { } // T1 never used
    }
    
    // VALID: T used in receiver type
    extension<T> (IEnumerable<T> source)
    {
        public void Process() { } // T inferrable from receiver
    }
    
    // VALID: TResult inferrable from parameter
    extension<T> (IEnumerable<T> source)
    {
        public IEnumerable<TResult> Convert<TResult>(Func<T, TResult> selector)
        {
            return source.Select(selector);
        }
    }
}
```

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

## Best Practices

### When to Use Extension Members

✅ **Use extension members when:**
- Extending types you don't control (framework types, third-party libraries)
- Creating domain-specific utility methods
- Implementing LINQ-style query operators
- Building fluent APIs
- Adding cross-cutting concerns (logging, validation)

❌ **Avoid extension members when:**
- You control the source type (add methods directly)
- Functionality requires access to private members
- The extension is tightly coupled to internal implementation details
- Creating a derived type is more appropriate

### Prefer Modern Syntax for New Code

Use extension blocks for new code to benefit from unified syntax and additional capabilities.

```csharp
// Preferred: Modern extension block
public static class PreferredExtensions
{
    extension (DateTime date)
    {
        public bool IsToday => date.Date == DateTime.Today;
        public string ToShortString() => date.ToString("yyyy-MM-dd");
    }
}

// Acceptable: Traditional syntax (for consistency with existing code)
public static class TraditionalExtensions
{
    public static bool IsToday(this DateTime date) => 
        date.Date == DateTime.Today;
}
```

### Group Related Extensions

Organize extensions by domain or type family.

```csharp
public static class CollectionExtensions
{
    extension<T> (IEnumerable<T> source) { /* ... */ }
    extension<T> (ICollection<T> collection) { /* ... */ }
    extension<T> (IList<T> list) { /* ... */ }
}

public static class StringExtensions
{
    extension (string text) { /* ... */ }
}

public static class DateTimeExtensions
{
    extension (DateTime date) { /* ... */ }
    extension (DateTimeOffset date) { /* ... */ }
}
```

### Document Extension Behavior

Clearly document what extensions do and any side effects.

```csharp
public static class FileExtensions
{
    extension (FileInfo file)
    {
        /// <summary>
        /// Reads entire file content as text.
        /// </summary>
        /// <remarks>
        /// Loads entire file into memory. Not suitable for large files.
        /// File must exist or IOException is thrown.
        /// </remarks>
        public string ReadAllText() => File.ReadAllText(file.FullName);
    }
}
```

## See Also

### Related Language Features

- **Extension Methods (C# 3.0)**: Original extension method pattern with `this` modifier
- **Extension Properties**: Property members in extension blocks
- **Extension Operators**: Operator overloading via extensions
- **LINQ**: Standard query operators implemented as extension methods
- **Static Classes**: Container for extension declarations

### Framework Integration

- **System.Linq**: LINQ query operators (extension methods)
- **System.Collections.Generic**: Collection extension methods
- **IEnumerable\<T\>**: Primary target for query extensions
- **Span\<T\> and Memory\<T\>**: Performance-oriented extension targets

### Design Patterns

- **Adapter Pattern**: Adapting types to new interfaces
- **Decorator Pattern**: Adding behavior without inheritance
- **Fluent Interfaces**: Method chaining for readable APIs
- **Builder Pattern**: Incremental object construction

### Performance Considerations

- **Zero-cost abstraction**: Extensions compile to static methods
- **Inline optimization**: JIT can inline extension methods
- **Struct extensions**: Use `ref` to avoid copying
- **Iterator methods**: `yield return` for deferred execution
