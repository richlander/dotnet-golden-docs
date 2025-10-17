# Collections Performance
## Migration & Compatibility
### OrderedDictionary Performance

- **Key lookup**: O(1) hash-based access
- **Index access**: O(1) direct indexing with GetAt/SetAt
- **Iteration**: Linear, in insertion order
- **Memory**: Comparable to `Dictionary<TKey, TValue>` with small additional overhead for ordering

## Best Practices

1. **Let the runtime optimize**: Write natural code with small arrays; the runtime will stack-allocate when beneficial
2. **Use interfaces for abstraction**: Don't avoid `IEnumerable<T>` for performance; array interface devirtualization eliminates overhead
3. **Prefer `OrderedDictionary` for ordered key-value data**: When you need both dictionary semantics and predictable iteration order
4. **Cache indices for repeated updates**: Use TryAdd/TryGetValue overloads that return index for frequent updates
5. **Keep escape scope minimal**: Arrays that don't escape the method are candidates for stack allocation

## Migration & Compatibility

### Adopting OrderedDictionary

Migrating from `Dictionary` where order matters:

```csharp
// Before: Dictionary with separate ordering mechanism
private Dictionary<string, string> _config = new();
private List<string> _keyOrder = new();

public void Add(string key, string value)
{
    _config[key] = value;
    if (!_keyOrder.Contains(key))
    {
        _keyOrder.Add(key);
    }
}

// After: OrderedDictionary handles ordering automatically
private OrderedDictionary<string, string> _config = new();

public void Add(string key, string value)
{
    _config[key] = value;  // Maintains insertion order automatically
}
```

### Leveraging Automatic Optimizations

No code changes needed to benefit from runtime improvements:

```csharp
// This code gets faster as the runtime evolves
public void ProcessData()
{
    string[] messages = { "Error", "Warning", "Info" };  // May be stack allocated
    
    IEnumerable<string> enumerable = messages;
    foreach (var msg in enumerable)  // Devirtualized when possible
    {
        Console.WriteLine(msg);
    }
}
```

**Version requirements**:
- Stack allocation for value type arrays: Available in earlier .NET versions
- Stack allocation for reference type arrays: .NET 10+
- Array interface devirtualization: .NET 10+
- `OrderedDictionary<TKey, TValue>`: .NET 9+
- `OrderedDictionary` index-returning overloads: .NET 10+
- Collection expressions: C# 12 (.NET 8+)
