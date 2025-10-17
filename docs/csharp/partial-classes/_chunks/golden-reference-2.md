# Partial Classes
## Partial Members
### Nested Partial Types

Nested types can be partial even if the containing type is not.

```csharp
public class Container
{
    public partial class NestedData
    {
        public int Id { get; set; }
    }
}

public class Container
{
    public partial class NestedData
    {
        public string Name { get; set; }
    }
}
```

## Partial Members

### Partial Methods

Partial methods separate method signatures from implementations. The declaring declaration specifies the signature, while the implementing declaration provides the body.

```csharp
// File 1: Declaring declaration
public partial class DataProcessor
{
    public partial void ProcessData(string input);
}

// File 2: Implementing declaration
public partial class DataProcessor
{
    public partial void ProcessData(string input)
    {
        Console.WriteLine($"Processing: {input}");
    }
}
```

**Optional implementation:** If a method meets all these criteria, the implementing declaration is optional:
- No accessibility modifiers (defaults to `private`)
- Returns `void`
- No `out` parameters
- No modifiers: `virtual`, `override`, `sealed`, `new`, or `extern`

When implementation is omitted for an optional partial method, the compiler removes both the declaration and all calls to the method at compile time.

```csharp
public partial class DataProcessor
{
    partial void OnDataChanged(); // Optional - can be left unimplemented
    
    public void UpdateData(string data)
    {
        // ... update logic
        OnDataChanged(); // Call is removed if not implemented
    }
}
```

**Required implementation:** Methods that don't meet the optional criteria must have an implementing declaration. This commonly occurs with source generators that implement attributed methods.

```csharp
// Source generator pattern
public partial class RegexContainer
{
    [GeneratedRegex(@"\d{3}-\d{2}-\d{4}")]
    public static partial Regex SsnPattern();
}

// Source generator provides:
// public static partial Regex SsnPattern() => new Regex(@"\d{3}-\d{2}-\d{4}", RegexOptions.Compiled);
```
