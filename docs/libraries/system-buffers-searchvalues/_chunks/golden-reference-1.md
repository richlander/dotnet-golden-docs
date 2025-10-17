# System.Buffers.SearchValues
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
