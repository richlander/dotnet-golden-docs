# IAsyncEnumerable&lt;T&gt;
## Essential Syntax & Examples
### Cancellation Support

```csharp
// Accept CancellationToken in async iterators
public async IAsyncEnumerable<int> GetNumbersAsync(
    int count,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    for (int i = 0; i < count; i++)
    {
        cancellationToken.ThrowIfCancellationRequested();
        await Task.Delay(100, cancellationToken);
        yield return i;
    }
}

// Use with cancellation
var cts = new CancellationTokenSource(TimeSpan.FromSeconds(5));

try
{
    await foreach (int num in GetNumbersAsync(100, cts.Token))
    {
        Console.WriteLine(num);
    }
}
catch (OperationCanceledException)
{
    Console.WriteLine("Iteration cancelled");
}
```

### Async Data Pipeline

```csharp
public async IAsyncEnumerable<ProcessedData> BuildPipelineAsync(
    IAsyncEnumerable<RawData> source)
{
    await foreach (var raw in source)
    {
        // Async transformation
        var validated = await ValidateAsync(raw);
        if (validated != null)
        {
            var enriched = await EnrichAsync(validated);
            var processed = await TransformAsync(enriched);
            yield return processed;
        }
    }
}

// Usage
IAsyncEnumerable<RawData> rawData = FetchFromApiAsync();
IAsyncEnumerable<ProcessedData> processed = BuildPipelineAsync(rawData);

await foreach (var item in processed)
{
    await SaveAsync(item);
}
```

### Materialization

```csharp
IAsyncEnumerable<int> numbers = GetNumbersAsync();

// Materialize to collections (requires System.Linq.Async)
List<int> list = await numbers.ToListAsync();
int[] array = await numbers.ToArrayAsync();

// Aggregation operations
int sum = await numbers.SumAsync();
int count = await numbers.CountAsync();
int max = await numbers.MaxAsync();
bool any = await numbers.AnyAsync(n => n > 5);
```

### ConfigureAwait Support

```csharp
// Use ConfigureAwait to control synchronization context
await foreach (var item in GetItemsAsync().ConfigureAwait(false))
{
    // Process without capturing context
    await ProcessAsync(item).ConfigureAwait(false);
}

// Also applies to async enumerator disposal
public async IAsyncEnumerable<int> GetNumbersAsync()
{
    // Cleanup happens with ConfigureAwait if specified during iteration
    await using var resource = await GetResourceAsync();
    
    for (int i = 0; i < 10; i++)
    {
        yield return i;
    }
}
```
