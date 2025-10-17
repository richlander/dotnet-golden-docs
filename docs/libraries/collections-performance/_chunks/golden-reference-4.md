# Collections Performance
## High-Performance Collection Patterns

### Small Temporary Collections

For small, temporary collections in hot paths, prefer array initialization:

```csharp
// Efficient - stack allocated when small and local
public bool IsValidExtension(string ext)
{
    string[] validExtensions = { ".txt", ".md", ".doc" };
    return validExtensions.Contains(ext);
}

// Alternative using collection expressions (C# 12)
public bool IsValidExtension(string ext)
{
    ReadOnlySpan<string> validExtensions = [".txt", ".md", ".doc"];
    return validExtensions.Contains(ext);
}
```

### Ordered Configuration with Fast Lookups

Use `OrderedDictionary` when you need both fast lookups and predictable iteration order:

```csharp
// Maintains insertion order for display while allowing fast key lookup
public class AppSettings
{
    private readonly OrderedDictionary<string, string> _settings = new();
    
    public void Load(IEnumerable<KeyValuePair<string, string>> entries)
    {
        foreach (var entry in entries)
        {
            _settings[entry.Key] = entry.Value;
        }
    }
    
    public string GetSetting(string key) => _settings[key];
    
    public void DisplaySettings()
    {
        // Displays in insertion/modification order
        for (int i = 0; i < _settings.Count; i++)
        {
            var kvp = _settings.GetAt(i);
            Console.WriteLine($"{kvp.Key} = {kvp.Value}");
        }
    }
}
```

### Efficient Updates with Index Caching

Cache indices for repeated updates to `OrderedDictionary`:

```csharp
var metrics = new OrderedDictionary<string, int>();

// Add with index tracking
if (metrics.TryAdd("requests", 0, out int requestsIndex))
{
    // Cache the index for fast updates
    for (int i = 0; i < 1000; i++)
    {
        int current = metrics.GetAt(requestsIndex).Value;
        metrics.SetAt(requestsIndex, current + 1);  // O(1) update
    }
}
```
