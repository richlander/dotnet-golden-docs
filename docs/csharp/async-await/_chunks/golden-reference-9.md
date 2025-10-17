# Async and Await
## Limitations and Considerations
### Don't Block on Async Code

Never use `.Result` or `.Wait()` on tasks in async contexts:

```csharp
// Bad: Can cause deadlocks
public async Task ProcessAsync()
{
    var data = GetDataAsync().Result; // Deadlock risk!
    await SaveDataAsync(data);
}

// Good: Await properly
public async Task ProcessAsync()
{
    var data = await GetDataAsync();
    await SaveDataAsync(data);
}
```

### Handle Exceptions Appropriately

Use try/catch with async code naturally:

```csharp
public async Task<Result> ProcessWithErrorHandlingAsync()
{
    try
    {
        var data = await FetchDataAsync();
        return new Result { Success = true, Data = data };
    }
    catch (HttpRequestException ex)
    {
        _logger.LogError(ex, "Failed to fetch data");
        return new Result { Success = false, Error = ex.Message };
    }
}
```

### Avoid Capturing Too Much Context

Be mindful of what closures capture in async lambdas:

```csharp
// Can capture large objects unnecessarily
public async Task ProcessItemsAsync(List<HugeObject> items)
{
    await Task.Run(async () =>
    {
        // This captures the entire 'items' list
        await Task.Delay(100);
    });
}

// Better: Only capture what you need
public async Task ProcessItemsAsync(List<HugeObject> items)
{
    int count = items.Count;
    await Task.Run(async () =>
    {
        // Only captures 'count'
        await Task.Delay(100);
    });
}
```

## Limitations and Considerations

### Async Methods Have Overhead

Async/await has a small performance cost:

```csharp
// Overhead not worth it for very fast operations
public async Task<int> AddAsync(int a, int b)
{
    return await Task.FromResult(a + b); // Wasteful
}

// Better: Just use synchronous code
public int Add(int a, int b)
{
    return a + b;
}
```

Use async only when operations are genuinely I/O-bound or long-running.
