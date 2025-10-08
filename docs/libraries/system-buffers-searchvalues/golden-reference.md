# System.Buffers.SearchValues

## Overview

SearchValues<T> is a performance-focused type introduced in .NET 8 that provides optimized searching for specific sets of values within spans. It creates an immutable, pre-computed data structure that accelerates repeated searches for the same set of values, making it ideal for high-performance scenarios where the same search criteria are used multiple times.

Key advantages include:

- Pre-computed optimization: Analysis happens once at creation time
- SIMD acceleration: Leverages hardware vector instructions when possible
- Multiple value types: Supports byte, char, and string (substring) searches
- Zero allocation: Designed for allocation-free search operations
- Consistent performance: Predictable search behavior across platforms

SearchValues is particularly valuable when:

1. The same set of values is searched repeatedly
2. Performance is critical and allocation should be minimized
3. You need to search for multiple values simultaneously
4. Working with spans and high-performance string/buffer operations

## Essential Syntax & Examples

### Creating SearchValues for Characters

```csharp
// Create SearchValues for a set of characters
SearchValues<char> vowels = SearchValues.Create("aeiouAEIOU");

// Use with IndexOfAny
ReadOnlySpan<char> text = "Hello World";
int index = text.IndexOfAny(vowels);  // Returns 1 (position of 'e')

// Use with ContainsAny
bool hasVowel = text.ContainsAny(vowels);  // Returns true
```

### Creating SearchValues for Bytes

```csharp
// Create SearchValues for byte values
SearchValues<byte> delimiters = SearchValues.Create(new byte[] { 0x0A, 0x0D, 0x20 });  // LF, CR, Space

ReadOnlySpan<byte> data = GetData();
int delimiterPos = data.IndexOfAny(delimiters);
```

### Substring Search (.NET 9+)

```csharp
// Search for multiple substrings within a larger string
SearchValues<string> animalNames = SearchValues.Create(
    new[] { "cat", "dog", "bird", "fish" },
    StringComparison.OrdinalIgnoreCase);

string text = "I saw a dog in the park";
int index = text.AsSpan().IndexOfAny(animalNames);  // Returns position of "dog"
```

### Common Use Cases

```csharp
// CSV parsing - find field delimiters
private static readonly SearchValues<char> s_csvDelimiters =
    SearchValues.Create(",\r\n");

public void ParseCsvLine(ReadOnlySpan<char> line)
{
    while (!line.IsEmpty)
    {
        int delimiterPos = line.IndexOfAny(s_csvDelimiters);
        ReadOnlySpan<char> field = delimiterPos >= 0
            ? line.Slice(0, delimiterPos)
            : line;

        ProcessField(field);
        line = delimiterPos >= 0 ? line.Slice(delimiterPos + 1) : default;
    }
}
```

### Path Validation

```csharp
// Check for invalid path characters
private static readonly SearchValues<char> s_invalidPathChars =
    SearchValues.Create(Path.GetInvalidPathChars());

public bool IsValidPath(string path)
{
    return !path.AsSpan().ContainsAny(s_invalidPathChars);
}
```

## Relationships & Integration

SearchValues integrates with and complements several .NET APIs:

- **String search methods**: Used with `string.IndexOfAny()`, `string.ContainsAny()`, `string.IndexOfAnyExcept()`, `string.LastIndexOfAny()`
- **Span operations**: Works with `ReadOnlySpan<T>.IndexOfAny()` and related methods
- **MemoryExtensions**: Provides span-based search extensions that accept SearchValues
- **Regular expressions**: Can be used as a faster alternative for simple multi-character searches
- **String.Contains/IndexOf**: Replaces less efficient multiple searches with single optimized operation

SearchValues is designed to replace patterns like:

```csharp
// Before: Multiple IndexOf calls
if (text.IndexOf('a') >= 0 || text.IndexOf('e') >= 0 ||
    text.IndexOf('i') >= 0 || text.IndexOf('o') >= 0)
{
    // Found a vowel
}

// After: Single call with SearchValues
private static readonly SearchValues<char> s_vowels = SearchValues.Create("aeiou");
if (text.AsSpan().ContainsAny(s_vowels))
{
    // Found a vowel
}
```

## Common Scenarios

### High-Performance Text Processing

When parsing or validating text repeatedly with the same character set:

```csharp
private static readonly SearchValues<char> s_whitespace =
    SearchValues.Create(" \t\r\n");

public ReadOnlySpan<char> TrimStart(ReadOnlySpan<char> text)
{
    int firstNonWhitespace = text.IndexOfAnyExcept(s_whitespace);
    return firstNonWhitespace >= 0
        ? text.Slice(firstNonWhitespace)
        : ReadOnlySpan<char>.Empty;
}
```

### Protocol Parsing

Searching for protocol-specific delimiters or special characters:

```csharp
private static readonly SearchValues<byte> s_httpDelimiters =
    SearchValues.Create(new byte[] { (byte)'\r', (byte)'\n', (byte)':' });

public void ParseHttpHeader(ReadOnlySpan<byte> header)
{
    int delimiterPos = header.IndexOfAny(s_httpDelimiters);
    // Process header based on delimiter found
}
```

### Input Validation

Efficiently checking for invalid characters in user input:

```csharp
private static readonly SearchValues<char> s_sqlInjectionChars =
    SearchValues.Create("';--/**/");

public bool IsSafeInput(string userInput)
{
    return !userInput.AsSpan().ContainsAny(s_sqlInjectionChars);
}
```

### URL/Path Processing

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

## Related Topics

- **String search operations**: Contains, IndexOf, LastIndexOf for basic searches
- **Regular expressions**: For complex pattern matching beyond simple character sets
- **Span\<T\> and Memory\<T\>**: For allocation-free buffer operations
- **MemoryExtensions**: Provides extension methods that work with SearchValues
