# IAsyncEnumerable&lt;T&gt;
## Essential Syntax & Examples
### When to Use

Use `IAsyncEnumerable<T>` when:
- Retrieving data from async sources (databases, APIs, file I/O)
- Processing paginated API responses
- Streaming large datasets without loading everything into memory
- Building async data pipelines with composition
- Working with real-time data feeds or event streams

Consider synchronous `IEnumerable<T>` when:
- Data is already in memory
- Operations are CPU-bound rather than I/O-bound
- You don't need async iteration
- Compatibility with older .NET versions is required

Consider `Task<IEnumerable<T>>` when:
- You need to return an entire collection asynchronously
- The async work happens before iteration (loading all data)
- Multiple iterations over the same data are expected

## Essential Syntax & Examples

### Basic Async Iteration

```csharp
// Consuming IAsyncEnumerable<T> with await foreach
public async Task ProcessDataAsync()
{
    await foreach (string line in ReadLinesAsync("file.txt"))
    {
        Console.WriteLine(line);
    }
}

// Creating IAsyncEnumerable<T> with async iterator
public async IAsyncEnumerable<string> ReadLinesAsync(string path)
{
    using var reader = new StreamReader(path);
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        yield return line;
    }
}
```

### Async LINQ Operations

```csharp
using System.Linq;

IAsyncEnumerable<int> numbers = GetNumbersAsync();

// Filter with Where (from System.Linq.Async)
IAsyncEnumerable<int> evenNumbers = numbers.Where(n => n % 2 == 0);

// Transform with Select
IAsyncEnumerable<string> strings = numbers.Select(n => $"Number: {n}");

// Chain operations
IAsyncEnumerable<int> result = numbers
    .Where(n => n > 5)
    .Select(n => n * 2)
    .Take(10);

await foreach (int value in result)
{
    Console.WriteLine(value);
}
```

Note: For full async LINQ support, install the `System.Linq.Async` NuGet package which provides extension methods like `WhereAsync`, `SelectAsync`, etc.
