# Type Extensions
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
