# System.Buffers.SearchValues
## Input Validation with SearchValues

Efficiently checking for invalid characters in user input:

```csharp
private static readonly SearchValues<char> s_sqlInjectionChars =
    SearchValues.Create("';--/**/");

public bool IsSafeInput(string userInput)
{
    return !userInput.AsSpan().ContainsAny(s_sqlInjectionChars);
}
```

## URL and Path Processing with SearchValues

Finding special characters in URLs or file paths:

```csharp
private static readonly SearchValues<char> s_urlEncodingRequired =
    SearchValues.Create(" <>\"#%{}|\\^[]`");

public bool RequiresUrlEncoding(string url)
{
    return url.AsSpan().ContainsAny(s_urlEncodingRequired);
}
```

## Performance Characteristics

SearchValues provides significant performance advantages:

1. **One-time setup cost**: Optimization analysis happens once at creation
2. **SIMD acceleration**: Automatically uses vector instructions when beneficial
3. **Allocation-free searches**: Zero allocations during search operations
4. **Scalable**: Performance scales well with the number of values being searched

Performance comparison:

```csharp
// Slower: Multiple sequential searches
bool found = text.Contains('a') || text.Contains('e') ||
             text.Contains('i') || text.Contains('o');

// Faster: Single SearchValues lookup with SIMD
private static readonly SearchValues<char> s_vowels = SearchValues.Create("aeiou");
bool found = text.AsSpan().ContainsAny(s_vowels);
```

## Best Practices

1. **Declare as static readonly**: Create SearchValues once and reuse
2. **Use for repeated searches**: Most beneficial when searching the same values multiple times
3. **Consider span-based APIs**: Prefer `AsSpan()` for allocation-free operations
4. **Know the threshold**: For 1-2 values, direct comparison may be faster
5. **Profile performance**: Measure impact in your specific scenario

## Migration & Compatibility

Migrating to SearchValues:

```csharp
// Before: Multiple Contains calls
if (value.Contains(',') || value.Contains(';') || value.Contains('\t'))
{
    return true;
}

// After: SearchValues
private static readonly SearchValues<char> s_separators =
    SearchValues.Create(",;\t");

if (value.AsSpan().ContainsAny(s_separators))
{
    return true;
}
```

**Version requirements**:
- Character and byte SearchValues: .NET 8+
- Substring SearchValues: .NET 9+
