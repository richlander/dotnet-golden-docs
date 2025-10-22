# C# 14
## Zero-Allocation String Processing with Params Collections

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

## Type Extension Patterns

Extensions provide more capable patterns compared to traditional extension methods.

```csharp
public static class CollectionExtensions
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
