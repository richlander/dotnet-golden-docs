# Task and Task&lt;T&gt;
## Common Scenarios
### Progress Reporting

**When to use**: Long-running operations that need to report progress.

```csharp
public async Task<List<Result>> ProcessItemsWithProgressAsync(
    List<Item> items,
    IProgress<int> progress)
{
    var results = new List<Result>();
    
    for (int i = 0; i < items.Count; i++)
    {
        var result = await ProcessItemAsync(items[i]);
        results.Add(result);
        
        progress?.Report((i + 1) * 100 / items.Count);
    }
    
    return results;
}

// Usage
var progress = new Progress<int>(percent =>
{
    Console.WriteLine($"Progress: {percent}%");
});

var results = await ProcessItemsWithProgressAsync(items, progress);
```

**Considerations**: Progress callbacks may run on different threads. Use appropriate synchronization for UI updates.

### Fire and Forget (Rarely Recommended)

**When to use**: Background operations that don't need to block the caller (use sparingly).

```csharp
public void FireAndForget(Task task)
{
    _ = Task.Run(async () =>
    {
        try
        {
            await task;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Background task failed");
        }
    });
}

// Usage
FireAndForget(SendAnalyticsAsync());

// Or with explicit continuation
Task.Run(() => SendAnalyticsAsync()).ContinueWith(t =>
{
    if (t.IsFaulted)
    {
        _logger.LogError(t.Exception, "Analytics failed");
    }
}, TaskScheduler.Default);
```

**Considerations**: Unhandled exceptions in fire-and-forget tasks can crash the app. Always handle exceptions.

### Lazy Task Initialization

**When to use**: Expensive async initialization that should happen once.

```csharp
public class DataService
{
    private readonly Lazy<Task<Config>> _configTask;
    
    public DataService()
    {
        _configTask = new Lazy<Task<Config>>(() => LoadConfigAsync());
    }
    
    private async Task<Config> LoadConfigAsync()
    {
        await Task.Delay(1000); // Simulate expensive load
        return new Config();
    }
    
    public async Task<Data> GetDataAsync()
    {
        var config = await _configTask.Value; // Loads once
        return await FetchDataAsync(config);
    }
}
```

**Considerations**: The task is created on first access and subsequent calls get the same task.
