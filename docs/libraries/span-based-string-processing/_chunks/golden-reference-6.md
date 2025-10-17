# Span-Based String Processing
## Migration & Compatibility
### Memory Overhead

- **Stack allocation**: Small buffers can use stackalloc instead of heap
- **ArrayPool**: Rent buffers for larger operations, avoiding repeated allocations
- **In-place operations**: Many operations modify data without creating copies

## Best Practices

1. **Use `ReadOnlySpan<char>` for parameters**: Accept ReadOnlySpan<char> instead of string for methods that don't need to store the value
2. **Prefer AsSpan() over Substring()**: Use `string.AsSpan(start, length)` instead of `string.Substring()` to avoid allocations
3. **Stack allocate small buffers**: Use stackalloc for temporary buffers under ~1KB
4. **Use ArrayPool for large buffers**: Rent arrays from `ArrayPool<T>.Shared` for larger temporary buffers
5. **Check normalization before normalizing**: Use `IsNormalized()` to avoid unnecessary work
6. **Process UTF-8 directly when possible**: Avoid converting to UTF-16 strings if working with UTF-8 data
7. **Combine with SearchValues**: Use SearchValues<char> for repeated character set searches

## Migration & Compatibility

### Adopting Span-Based String Processing

Migrating from string-based to span-based code:

```csharp
// Before: Creates substring allocations
static string GetFileExtension(string path)
{
    int dotPos = path.LastIndexOf('.');
    return dotPos >= 0 ? path.Substring(dotPos) : string.Empty;
}

// After: No allocations
static ReadOnlySpan<char> GetFileExtension(ReadOnlySpan<char> path)
{
    int dotPos = path.LastIndexOf('.');
    return dotPos >= 0 ? path.Slice(dotPos) : ReadOnlySpan<char>.Empty;
}

// Or return string when storage is needed
static string GetFileExtensionAsString(ReadOnlySpan<char> path)
{
    ReadOnlySpan<char> extension = GetFileExtension(path);
    return extension.IsEmpty ? string.Empty : new string(extension);
}
```
