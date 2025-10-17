# String Search Operations
## Performance Characteristics
### Multi-Format Searching

```csharp
public int FindNextDelimiter(string text, int startIndex)
{
    // Search for multiple delimiter types
    int commaPos = text.IndexOf(',', startIndex);
    int semicolonPos = text.IndexOf(';', startIndex);
    int newlinePos = text.IndexOf('\n', startIndex);

    // Return the closest delimiter
    int min = int.MaxValue;
    if (commaPos >= 0) min = Math.Min(min, commaPos);
    if (semicolonPos >= 0) min = Math.Min(min, semicolonPos);
    if (newlinePos >= 0) min = Math.Min(min, newlinePos);

    return min == int.MaxValue ? -1 : min;
}

// Better approach with SearchValues
private static readonly SearchValues<char> s_delimiters =
    SearchValues.Create(",;\n");

public int FindNextDelimiterFast(string text, int startIndex)
{
    return text.AsSpan(startIndex).IndexOfAny(s_delimiters);
}
```

## Performance Characteristics

### String.Contains vs String.IndexOf

```csharp
// These have similar performance for simple checks
bool found1 = text.Contains("search");
bool found2 = text.IndexOf("search") >= 0;

// Contains is clearer and preferred (CA2249 analyzer)
```

### Ordinal vs Culture-Aware

```csharp
// Ordinal: Fast, byte-by-byte comparison
int pos1 = text.IndexOf("test", StringComparison.Ordinal);

// CurrentCulture: Slower, considers locale-specific rules
int pos2 = text.IndexOf("test", StringComparison.CurrentCulture);

// Recommendation: Use Ordinal unless culture-aware comparison is needed
```

### SearchValues Optimization

```csharp
// Repeated searches with IndexOfAny - slower
for (int i = 0; i < 10000; i++)
{
    int pos = text.IndexOfAny(new[] { 'a', 'e', 'i', 'o', 'u' });
}

// SearchValues - much faster for repeated searches
private static readonly SearchValues<char> s_vowels =
    SearchValues.Create("aeiou");

for (int i = 0; i < 10000; i++)
{
    int pos = text.AsSpan().IndexOfAny(s_vowels);
}
```
