# Type Extensions
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
