# IEnumerable and IEnumerable&lt;T&gt;
## See Also
### Memory Implications with Large Sequences

Deferred execution keeps the entire chain in memory as a series of iterators:

```csharp
// This creates a chain of iterators, not intermediate collections
IEnumerable<string> results = hugeDataset
    .Where(x => x.IsActive)
    .Select(x => x.Transform())
    .OrderBy(x => x.Priority)
    .Where(x => x.Score > 100)
    .Select(x => x.ToString());

// OrderBy must materialize the sequence internally
// Other operations stream through
```

Operations like `OrderBy`, `Reverse`, `GroupBy` require materialization. Be aware of memory usage with large sequences.

### IEnumerable Doesn't Support Modification

`IEnumerable<T>` is read-only for iteration. It provides no methods to add, remove, or modify elements:

```csharp
IEnumerable<int> numbers = new List<int> { 1, 2, 3 };

// These don't exist on IEnumerable<T>:
// numbers.Add(4);
// numbers.Remove(2);
// numbers[0] = 10;

// Need to check the concrete type or use a different interface
if (numbers is List<int> list)
{
    list.Add(4);
}

// Or work with ICollection<T>, IList<T>, etc.
```

Use `ICollection<T>` or `IList<T>` if you need modification capabilities.

## See Also

- **IAsyncEnumerable&lt;T&gt;**: Async version for asynchronous iteration scenarios
- **IQueryable&lt;T&gt;**: Expression-based queries that can translate to other query languages (SQL, etc.)
- **LINQ**: Language Integrated Query operations that extend IEnumerable&lt;T&gt;
- **Collection Expressions**: Modern C# syntax for creating collections
- **yield return**: C# keyword for creating iterator methods
- **Task and Task&lt;T&gt;**: For async operations that complement IAsyncEnumerable&lt;T&gt;
- **ICollection&lt;T&gt; and IList&lt;T&gt;**: Collection interfaces with modification and indexing capabilities
- **System.Text.Json**: JSON serialization of enumerable sequences
