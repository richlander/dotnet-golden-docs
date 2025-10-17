# Async and Await
## Common Scenarios
### Processing Items in Batches

**When to use**: Processing large collections with controlled concurrency.

```csharp
public async Task ProcessItemsInBatchesAsync<T>(
    IEnumerable<T> items,
    Func<T, Task> processItem,
    int batchSize = 10)
{
    var batches = items.Chunk(batchSize);
    
    foreach (var batch in batches)
    {
        var tasks = batch.Select(processItem);
        await Task.WhenAll(tasks);
    }
}

// Usage
await ProcessItemsInBatchesAsync(
    customers,
    async customer => await SendEmailAsync(customer),
    batchSize: 20
);
```

**Considerations**: Control concurrency to avoid overwhelming resources or rate limits.

### Timeout Pattern

**When to use**: Adding timeout to operations that don't support cancellation.

```csharp
public async Task<T> WithTimeoutAsync<T>(Task<T> task, TimeSpan timeout)
{
    using var cts = new CancellationTokenSource();
    var delayTask = Task.Delay(timeout, cts.Token);
    var completedTask = await Task.WhenAny(task, delayTask);
    
    if (completedTask == delayTask)
    {
        throw new TimeoutException("Operation timed out");
    }
    
    cts.Cancel(); // Cancel the delay
    return await task;
}

// Usage
try
{
    var result = await WithTimeoutAsync(
        SlowOperationAsync(),
        TimeSpan.FromSeconds(5)
    );
}
catch (TimeoutException)
{
    Console.WriteLine("Operation timed out");
}
```

**Considerations**: This doesn't actually cancel the original operation, just stops waiting for it.

### Async Lock Pattern

**When to use**: Coordinating async operations that need mutual exclusion.

```csharp
public class AsyncCache<TKey, TValue>
{
    private readonly Dictionary<TKey, TValue> _cache = new();
    private readonly SemaphoreSlim _semaphore = new(1, 1);
    
    public async Task<TValue> GetOrAddAsync(TKey key, Func<Task<TValue>> valueFactory)
    {
        await _semaphore.WaitAsync();
        try
        {
            if (_cache.TryGetValue(key, out var value))
            {
                return value;
            }
            
            value = await valueFactory();
            _cache[key] = value;
            return value;
        }
        finally
        {
            _semaphore.Release();
        }
    }
}

// Usage
var cache = new AsyncCache<string, User>();
var user = await cache.GetOrAddAsync("user123", async () => await FetchUserAsync("user123"));
```

**Considerations**: Use `SemaphoreSlim` for async synchronization, not `lock` statements.
