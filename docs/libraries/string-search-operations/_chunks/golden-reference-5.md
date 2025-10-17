# String Search Operations
## Best Practices
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
