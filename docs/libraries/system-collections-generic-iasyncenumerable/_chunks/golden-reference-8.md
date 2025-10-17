# IAsyncEnumerable&lt;T&gt;
## Best Practices
### Manual Enumerator Pattern

```csharp
// Using GetAsyncEnumerator manually
public async Task ProcessManuallyAsync(IAsyncEnumerable<int> source)
{
    await using var enumerator = source.GetAsyncEnumerator();
    
    while (await enumerator.MoveNextAsync())
    {
        int current = enumerator.Current;
        Console.WriteLine(current);
    }
}

// Equivalent to await foreach
await foreach (int item in source)
{
    Console.WriteLine(item);
}
```

### Converting Between Sync and Async

```csharp
// IEnumerable<T> to IAsyncEnumerable<T>
public async IAsyncEnumerable<T> ToAsyncEnumerable<T>(IEnumerable<T> source)
{
    foreach (var item in source)
    {
        yield return item;
        await Task.Yield(); // Yield control
    }
}

// IAsyncEnumerable<T> to IEnumerable<T> (blocks - avoid if possible)
public IEnumerable<T> ToSyncEnumerable<T>(IAsyncEnumerable<T> source)
{
    await foreach (var item in source)
    {
        yield return item;
    }
}

// Better: Materialize async then enumerate sync
public async Task<IEnumerable<T>> MaterializeAsync<T>(IAsyncEnumerable<T> source)
{
    return await source.ToListAsync();
}
```

## Best Practices

### Use Cancellation Tokens

Always support cancellation in async iterators:

```csharp
// Good: Supports cancellation
public async IAsyncEnumerable<int> GetNumbersAsync(
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    for (int i = 0; i < 1000; i++)
    {
        cancellationToken.ThrowIfCancellationRequested();
        await Task.Delay(100, cancellationToken);
        yield return i;
    }
}

// Usage
var cts = new CancellationTokenSource();
await foreach (var num in GetNumbersAsync(cts.Token))
{
    if (num > 10)
        cts.Cancel();
}
```

The `[EnumeratorCancellation]` attribute automatically flows the cancellation token from `WithCancellation()`.

### Dispose Resources Properly

Use `await using` for async disposable resources:

```csharp
public async IAsyncEnumerable<string> ReadLinesAsync(string path)
{
    // await using ensures proper async disposal
    await using var reader = new StreamReader(path);
    
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        yield return line;
    }
    // StreamReader disposed asynchronously after iteration
}
```
