# IAsyncEnumerable&lt;T&gt;
## Alternative Syntax Options
### Retry and Error Handling

**When to use**: Implementing resilience patterns for async sequences.

```csharp
public async IAsyncEnumerable<T> WithRetryAsync<T>(
    IAsyncEnumerable<T> source,
    int maxRetries = 3,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    await using var enumerator = source.GetAsyncEnumerator(cancellationToken);
    
    while (true)
    {
        int retryCount = 0;
        bool hasNext = false;
        
        while (retryCount < maxRetries)
        {
            try
            {
                hasNext = await enumerator.MoveNextAsync();
                break;
            }
            catch (Exception ex) when (retryCount < maxRetries - 1)
            {
                retryCount++;
                await Task.Delay(TimeSpan.FromSeconds(Math.Pow(2, retryCount)), cancellationToken);
            }
        }
        
        if (!hasNext)
            break;
        
        yield return enumerator.Current;
    }
}

// Usage
await foreach (var item in WithRetryAsync(FetchFromUnreliableApiAsync()))
{
    await ProcessAsync(item);
}
```

**Considerations**: Retry logic adds complexity. Consider using libraries like Polly for production scenarios.

## Alternative Syntax Options

### Multiple Ways to Create IAsyncEnumerable

```csharp
// Async iterator method (most common)
public async IAsyncEnumerable<int> Method1()
{
    for (int i = 0; i < 5; i++)
    {
        await Task.Delay(10);
        yield return i;
    }
}

// Channel-based
public IAsyncEnumerable<int> Method2()
{
    var channel = Channel.CreateUnbounded<int>();
    
    Task.Run(async () =>
    {
        for (int i = 0; i < 5; i++)
        {
            await channel.Writer.WriteAsync(i);
        }
        channel.Writer.Complete();
    });
    
    return channel.Reader.ReadAllAsync();
}

// From Task<IEnumerable<T>>
public async IAsyncEnumerable<int> Method3()
{
    var items = await GetItemsAsync(); // Returns Task<List<int>>
    
    foreach (var item in items)
    {
        yield return item;
    }
}

// Wrap synchronous IEnumerable with async operations
public async IAsyncEnumerable<int> Method4(IEnumerable<int> source)
{
    foreach (var item in source)
    {
        await Task.Delay(10); // Some async work
        yield return item;
    }
}
```
