# System.Buffers.SearchValues
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

## High-Performance Text Processing with SearchValues

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

## Protocol Parsing with SearchValues

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
