# String Search Operations
## Parsing Structured Text with String Search
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
