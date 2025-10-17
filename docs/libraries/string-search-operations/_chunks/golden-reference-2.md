# String Search Operations
## Relationships & Integration
### IndexOfAny and LastIndexOfAny

Search for any character from a set:

```csharp
string data = "Name: John Doe";

// Find any delimiter
char[] delimiters = { ':', ';', ',' };
int delimiterPos = data.IndexOfAny(delimiters);  // Returns 4 (position of ':')

// Find last vowel
char[] vowels = { 'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U' };
int lastVowelPos = data.LastIndexOfAny(vowels);  // Returns 12 (position of 'o')
```

**Performance note**: For repeated searches, use SearchValues instead:

```csharp
private static readonly SearchValues<char> s_delimiters =
    SearchValues.Create(":;,");

int pos = data.AsSpan().IndexOfAny(s_delimiters);
```

### StartsWith and EndsWith

Check string boundaries:

```csharp
string fileName = "report.pdf";

// Check file extension (ordinal comparison)
bool isPdf = fileName.EndsWith(".pdf", StringComparison.OrdinalIgnoreCase);

// Check prefix
string url = "https://example.com";
bool isSecure = url.StartsWith("https://", StringComparison.Ordinal);

// Character overloads (always ordinal)
bool startsWithR = fileName.StartsWith('r');  // true
bool endsWithF = fileName.EndsWith('f');  // true
```

## Relationships & Integration

String search operations form a hierarchy of tools for different needs:

### Performance Spectrum

```text
Simple → Complex
Fast   → Flexible

Contains/IndexOf → SearchValues → Regular Expressions
```

1. **String.Contains/IndexOf**: Best for single, simple searches
2. **SearchValues**: Optimal for repeated multi-value searches
3. **Regular Expressions**: Best for complex pattern matching

### Method Interoperability

```csharp
// These methods often work together
string text = GetUserInput();

// 1. Check if search term exists
if (text.Contains("error", StringComparison.OrdinalIgnoreCase))
{
    // 2. Find exact position
    int errorPos = text.IndexOf("error", StringComparison.OrdinalIgnoreCase);

    // 3. Extract context around error
    int start = Math.Max(0, errorPos - 20);
    string context = text.Substring(start, 50);
}
```
