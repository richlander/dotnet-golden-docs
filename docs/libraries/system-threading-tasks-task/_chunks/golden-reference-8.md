# Task and Task&lt;T&gt;
## Best Practices
### ContinueWith vs Await

```csharp
// Old style: ContinueWith
public Task<string> OldStyleAsync()
{
    return FetchDataAsync().ContinueWith(task =>
    {
        if (task.IsFaulted)
            return string.Empty;
        
        return task.Result.ToUpper();
    });
}

// Modern: async/await
public async Task<string> ModernStyleAsync()
{
    try
    {
        var data = await FetchDataAsync();
        return data.ToUpper();
    }
    catch
    {
        return string.Empty;
    }
}
```

Prefer async/await over ContinueWith for readability and proper exception handling.

### Task.Factory.StartNew vs Task.Run

```csharp
// Old: Task.Factory.StartNew (more complex, more options)
Task<int> task1 = Task.Factory.StartNew(
    () => Calculate(100),
    CancellationToken.None,
    TaskCreationOptions.DenyChildAttach,
    TaskScheduler.Default);

// Modern: Task.Run (simpler, recommended)
Task<int> task2 = Task.Run(() => Calculate(100));
```

Use `Task.Run` unless you need the advanced options of `Task.Factory.StartNew`.

## Best Practices

### Don't Block on Tasks

Never use `.Result` or `.Wait()` in async code:

```csharp
// Bad: Can cause deadlocks
public void ProcessData()
{
    var data = GetDataAsync().Result; // Dangerous!
}

// Good: Use async all the way
public async Task ProcessDataAsync()
{
    var data = await GetDataAsync();
}
```

### Always Handle Task Exceptions

Unobserved task exceptions can crash the application:

```csharp
// Bad: Fire-and-forget without error handling
public void StartBackground()
{
    Task.Run(() => DoWorkAsync()); // Exception might go unhandled
}

// Good: Handle exceptions
public void StartBackground()
{
    Task.Run(async () =>
    {
        try
        {
            await DoWorkAsync();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Background work failed");
        }
    });
}
```
