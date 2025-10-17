# C# 14
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
