# String Search Operations

## Overview

String search operations in .NET provide a comprehensive set of methods for locating substrings, characters, and patterns within text. These operations range from simple character lookups to complex pattern matching, offering solutions for various performance and functionality requirements.

The .NET string search ecosystem includes:

1. **Basic string methods**: Contains, IndexOf, LastIndexOf, StartsWith, EndsWith
2. **SearchValues**: Pre-optimized search for repeated character/substring searches (.NET 8+)
3. **Regular expressions**: Pattern-based matching for complex scenarios
4. **Span-based operations**: Allocation-free searching for high-performance code

Understanding when to use each approach is critical for writing efficient, maintainable code.

## Essential Syntax & Examples

### String.Contains

The simplest way to check for substring existence:

```csharp
string text = "The quick brown fox";

// Basic containment check (ordinal by default)
bool hasFox = text.Contains("fox");  // true

// Case-insensitive search
bool hasQuick = text.Contains("QUICK", StringComparison.OrdinalIgnoreCase);  // true

// Single character check (ordinal, no StringComparison parameter)
bool hasQ = text.Contains('q');  // true
```

**Best practice**: Use CA2249 code analyzer to prefer `Contains` over `IndexOf >= 0`:

```csharp
// Avoid this pattern
if (text.IndexOf("fox") >= 0) { }

// Prefer this
if (text.Contains("fox")) { }
```

### String.IndexOf

Find the position of the first occurrence:

```csharp
string path = "C:\\Users\\Documents\\file.txt";

// Find first backslash
int firstSlash = path.IndexOf('\\');  // Returns 2

// Find substring with comparison type
int docsPos = path.IndexOf("documents", StringComparison.OrdinalIgnoreCase);  // Returns 9

// Search from specific position
int secondSlash = path.IndexOf('\\', firstSlash + 1);  // Returns 8

// Not found returns -1
int notFound = path.IndexOf("missing");  // Returns -1
```

**Culture considerations**:

```csharp
// WARNING: Without StringComparison, string overloads use CurrentCulture
string text = "Hel\0lo";
int idx1 = text.IndexOf("\0");  // May vary by culture/platform!

// RECOMMENDED: Always specify StringComparison for strings
int idx2 = text.IndexOf("\0", StringComparison.Ordinal);  // Consistent behavior
```

### String.LastIndexOf

Find the last occurrence:

```csharp
string filePath = "folder/subfolder/file.txt";

// Find last separator
int lastSlash = filePath.LastIndexOf('/');  // Returns 16

// Get filename
string fileName = filePath.Substring(lastSlash + 1);  // "file.txt"

// Find last occurrence of substring
int lastDot = filePath.LastIndexOf(".txt");  // Returns 21
```

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

### Complementary APIs

- **String.Split**: Divides string based on delimiters
- **String.Replace**: Substitutes found substrings
- **Regex.Match**: Pattern-based searching
- **SearchValues**: Optimized multi-value searching
- **Span methods**: Allocation-free searching

## Input Validation with String Search

```csharp
public bool IsValidEmail(string email)
{
    // Quick validation using Contains
    if (!email.Contains('@'))
        return false;

    int atPos = email.IndexOf('@');
    int dotPos = email.LastIndexOf('.');

    // Ensure @ comes before last dot
    return atPos > 0 && dotPos > atPos && dotPos < email.Length - 1;
}
```

## Path Manipulation with String Search

```csharp
public string GetFileNameWithoutExtension(string filePath)
{
    int lastSlash = Math.Max(
        filePath.LastIndexOf('/'),
        filePath.LastIndexOf('\\'));

    int lastDot = filePath.LastIndexOf('.');

    int start = lastSlash + 1;
    int length = (lastDot > lastSlash ? lastDot : filePath.Length) - start;

    return filePath.Substring(start, length);
}
```

## Parsing Structured Text with String Search

```csharp
public Dictionary<string, string> ParseKeyValuePairs(string input)
{
    var result = new Dictionary<string, string>();
    string[] pairs = input.Split(';');

    foreach (string pair in pairs)
    {
        int colonPos = pair.IndexOf(':');
        if (colonPos > 0)
        {
            string key = pair.Substring(0, colonPos).Trim();
            string value = pair.Substring(colonPos + 1).Trim();
            result[key] = value;
        }
    }

    return result;
}
```

### Security Filtering

```csharp
private static readonly SearchValues<char> s_sqlInjectionChars =
    SearchValues.Create("';--");

public bool ContainsSqlInjectionRisk(string userInput)
{
    // Fast check using SearchValues
    if (userInput.AsSpan().ContainsAny(s_sqlInjectionChars))
        return true;

    // Additional checks
    if (userInput.IndexOf("DROP", StringComparison.OrdinalIgnoreCase) >= 0)
        return true;

    return false;
}
```

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

### Span-Based Searching

```csharp
// Allocation-free searching with spans
ReadOnlySpan<char> span = text.AsSpan();
int pos = span.IndexOf("search", StringComparison.Ordinal);
```

## Best Practices

### 1. Always Specify StringComparison for Strings

```csharp
// ❌ Avoid: Implicit culture dependency
if (text.IndexOf("test") >= 0) { }

// ✅ Prefer: Explicit comparison type
if (text.IndexOf("test", StringComparison.Ordinal) >= 0) { }

// ✅ Better: Use Contains when checking existence
if (text.Contains("test", StringComparison.Ordinal)) { }
```

### 2. Use Contains Instead of IndexOf for Existence Checks

```csharp
// ❌ Avoid
if (text.IndexOf("pattern") >= 0) { }

// ✅ Prefer
if (text.Contains("pattern")) { }
```

### 3. Optimize Repeated Searches with SearchValues

```csharp
// ❌ Avoid: Creating array repeatedly
for (int i = 0; i < data.Length; i++)
{
    int pos = data[i].IndexOfAny(new[] { ',', ';', '\t' });
}

// ✅ Prefer: Reuse SearchValues
private static readonly SearchValues<char> s_separators =
    SearchValues.Create(",;\t");

for (int i = 0; i < data.Length; i++)
{
    int pos = data[i].AsSpan().IndexOfAny(s_separators);
}
```

### 4. Choose the Right Tool

```csharp
// Simple substring: Use Contains/IndexOf
if (text.Contains("error")) { }

// Multiple characters: Use SearchValues
private static readonly SearchValues<char> s_digits =
    SearchValues.Create("0123456789");
if (text.AsSpan().ContainsAny(s_digits)) { }

// Complex pattern: Use Regex
if (Regex.IsMatch(text, @"\b\d{3}-\d{2}-\d{4}\b")) { }
```

### 5. Consider Culture for User-Facing Text

```csharp
// For machine-readable data: Ordinal
bool isJson = contentType.StartsWith("application/json",
    StringComparison.Ordinal);

// For user-visible sorting/comparison: CurrentCulture
bool matchesUserQuery = userName.IndexOf(searchTerm,
    StringComparison.CurrentCultureIgnoreCase) >= 0;
```

## Migration & Compatibility

### From IndexOf to Contains

```csharp
// .NET Framework and earlier patterns
if (text.IndexOf("search") != -1) { }
if (text.IndexOf("search") >= 0) { }

// Modern .NET pattern (enabled by CA2249 analyzer)
if (text.Contains("search")) { }
```

### From IndexOfAny to SearchValues

```csharp
// .NET 7 and earlier
char[] separators = { ',', ';', '\t' };
int pos = text.IndexOfAny(separators);

// .NET 8+ with SearchValues
private static readonly SearchValues<char> s_separators =
    SearchValues.Create(",;\t");
int pos = text.AsSpan().IndexOfAny(s_separators);
```

### From Regex to SearchValues

```csharp
// When you only need simple character set matching
// Before: Regex
if (Regex.IsMatch(text, "[aeiou]")) { }

// After: SearchValues (much faster)
private static readonly SearchValues<char> s_vowels =
    SearchValues.Create("aeiou");
if (text.AsSpan().ContainsAny(s_vowels)) { }
```

## Related Topics

- **SearchValues**: Optimized search for repeated character/substring lookups
- **Regular Expressions**: Complex pattern matching and extraction
- **String.Split**: Dividing strings based on delimiters
- **Span\<T\>**: Allocation-free string operations
- **StringComparison**: Culture-aware vs ordinal comparison
