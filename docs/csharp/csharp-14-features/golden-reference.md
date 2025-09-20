# C# 14 Language Features - Golden Reference

## Overview

C# 14 introduces significant language enhancements that improve developer productivity, type safety, and performance. These features span property syntax improvements, memory management optimizations, enhanced lambda expressions, partial member support, and new extension capabilities. Key themes include reducing boilerplate code, enabling zero-allocation patterns, and extending the type system in safe ways.

## Essential Features & Examples

### `field` Keyword in Properties (Preview)

Access the compiler-generated backing field in auto-implemented properties with custom logic.

```csharp
public class Person
{
    public string Name
    {
        get => field;
        set => field = value?.Trim() ?? throw new ArgumentNullException();
    }

    public int Age
    {
        get => field;
        set => field = value < 0 ? 0 : value;
    }
}

// Simplifies validation without manual backing fields
var person = new Person { Name = "  John  ", Age = -5 };
Console.WriteLine($"{person.Name}, {person.Age}"); // "John, 0"
```

### First-Class Span Types

Enhanced Span support with natural syntax and zero-allocation patterns.

```csharp
// Implicit conversions and natural syntax
Span<int> span = [1, 2, 3, 4, 5];
ReadOnlySpan<char> text = "Hello World";

// Zero-allocation string operations
ReadOnlySpan<char> GetFileExtension(ReadOnlySpan<char> filename)
{
    int lastDot = filename.LastIndexOf('.');
    return lastDot >= 0 ? filename[(lastDot + 1)..] : [];
}

var extension = GetFileExtension("document.pdf");
Console.WriteLine(extension.ToString()); // "pdf"
```

### Unbound Generic Types in `nameof`

Reference generic type definitions without specifying type arguments.

```csharp
// Previously required specific type arguments
string oldWay = nameof(Dictionary<string, int>); // "Dictionary"

// Now supports unbound generics
string newWay = nameof(Dictionary<,>); // "Dictionary"

// Useful for reflection and code generation
Type genericType = typeof(List<>);
string typeName = nameof(List<>);
MethodInfo addMethod = genericType.GetMethod(nameof(List<>.Add));
```

### Simple Lambda Parameters with Modifiers

Enhanced lambda syntax with parameter modifiers for better type safety.

```csharp
// ref parameters for efficient value type operations
var transform = (ref Point p) => p = new Point(p.X * 2, p.Y * 2);

// out parameters for initialization patterns
var tryParse = (string input, out int result) => int.TryParse(input, out result);

// in parameters for read-only large structs
var calculate = (in Matrix matrix) => matrix.Determinant();

// params for variable arguments
var sum = (params int[] numbers) => numbers.Sum();
```

### Partial Events and Constructors

Enable partial declarations for events and constructors in code generation scenarios.

```csharp
// Generated file 1
public partial class MyClass
{
    public partial MyClass(string name);
    public partial event EventHandler<DataEventArgs> DataChanged;
}

// User file
public partial class MyClass
{
    private string _name;

    public partial MyClass(string name)
    {
        _name = name ?? throw new ArgumentNullException(nameof(name));
    }

    public partial event EventHandler<DataEventArgs> DataChanged
    {
        add => _dataChanged += value;
        remove => _dataChanged -= value;
    }

    private event EventHandler<DataEventArgs> _dataChanged;
}
```

### Extensions

New extension syntax for augmenting types with additional members safely.

```csharp
// Extensions provide type-safe augmentation
public extension PersonExtensions for Person
{
    public string FullName => $"{FirstName} {LastName}";
    public bool IsAdult => Age >= 18;
    public void CelebrateBirthday() => Age++;
}

// Usage feels natural
var person = new Person { FirstName = "John", LastName = "Doe", Age = 17 };
Console.WriteLine(person.FullName); // "John Doe"
Console.WriteLine(person.IsAdult);  // False
person.CelebrateBirthday();
Console.WriteLine(person.IsAdult);  // True
```

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

## Common Patterns & Integration

### Property Validation Patterns

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

### Zero-Allocation String Processing

First-class Span support enables efficient string operations.

```csharp
public static class StringUtils
{
    public static bool TryParseInt32(ReadOnlySpan<char> span, out int result)
    {
        span = span.Trim();
        return int.TryParse(span, out result);
    }

    public static ReadOnlySpan<char> GetFileName(ReadOnlySpan<char> path)
    {
        int lastSlash = Math.Max(path.LastIndexOf('/'), path.LastIndexOf('\\'));
        return lastSlash >= 0 ? path[(lastSlash + 1)..] : path;
    }
}
```

### Type-Safe Extension Patterns

Extensions provide safer alternatives to traditional extension methods.

```csharp
public extension CollectionExtensions for ICollection<T>
{
    public bool IsEmpty => Count == 0;
    public bool IsNotEmpty => Count > 0;
    public void AddRange(IEnumerable<T> items)
    {
        foreach (var item in items) Add(item);
    }
}
```

## Gotchas & Limitations

### `field` Keyword Restrictions

- Only available in property accessors
- Currently preview feature, syntax may change
- Cannot be used in expression-bodied properties

### Span Lifetime Management

- First-class Span still subject to ref safety rules
- Stack-only restrictions apply
- Careful with async boundaries

### Extension Safety

- Extensions don't support inheritance
- Name resolution follows specific rules
- Type safety enforced at compile time

### Null-Conditional Assignment Scope

- Limited to assignment contexts
- Doesn't work with method calls or complex expressions
- May not short-circuit in all expected scenarios

## See Also

### Related Language Features

- **C# 13 Features**: params collections, ref/unsafe in async, overload resolution priority
- **Pattern Matching**: Enhanced patterns and switch expressions
- **Records**: Immutable data structures with value semantics
- **Nullable Reference Types**: Compile-time null safety

### Performance Features

- **Span and Memory**: Zero-allocation memory management
- **ref struct**: Stack-only types for performance
- **Unsafe Code**: Low-level memory operations
- **Hardware Intrinsics**: SIMD operations

### Development Tools

- **Source Generators**: Compile-time code generation
- **Analyzers**: Custom compile-time diagnostics
- **Language Version**: Targeting specific C# versions
