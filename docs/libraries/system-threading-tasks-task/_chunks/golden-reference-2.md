# Task and Task&lt;T&gt;
## Essential Syntax & Examples
### Task.WhenAny for First Completion

```csharp
public async Task<string> GetFastestResponseAsync(List<string> urls)
{
    var tasks = urls.Select(url => GetDataAsync(url)).ToList();
    
    Task<string> firstCompleted = await Task.WhenAny(tasks);
    return await firstCompleted;
}

// Timeout pattern with WhenAny
public async Task<T> WithTimeoutAsync<T>(Task<T> task, TimeSpan timeout)
{
    var delayTask = Task.Delay(timeout);
    var completed = await Task.WhenAny(task, delayTask);
    
    if (completed == delayTask)
    {
        throw new TimeoutException();
    }
    
    return await task;
}
```

### Task.FromResult for Synchronous Completion

```csharp
public Task<int> GetCachedValueAsync(string key)
{
    // Check cache first
    if (_cache.TryGetValue(key, out int value))
    {
        return Task.FromResult(value); // Synchronous completion
    }
    
    // Actually async operation
    return FetchFromDatabaseAsync(key);
}
```

### TaskCompletionSource for Manual Control

```csharp
public Task<string> ReadLineAsync()
{
    var tcs = new TaskCompletionSource<string>();
    
    Console.ReadLine(); // Sync operation
    var line = Console.ReadLine();
    
    if (line != null)
    {
        tcs.SetResult(line);
    }
    else
    {
        tcs.SetException(new InvalidOperationException("No input"));
    }
    
    return tcs.Task;
}

// Wrapper for callback-based APIs
public Task<Data> GetDataAsync()
{
    var tcs = new TaskCompletionSource<Data>();
    
    // Legacy callback API
    _client.GetDataCompleted += (sender, args) =>
    {
        if (args.Error != null)
        {
            tcs.SetException(args.Error);
        }
        else
        {
            tcs.SetResult(args.Data);
        }
    };
    
    _client.GetDataAsync();
    
    return tcs.Task;
}
```

### Task Status and Properties

```csharp
Task<int> task = GetDataAsync();

// Check status
bool isCompleted = task.IsCompleted;
bool isFaulted = task.IsFaulted;
bool isCanceled = task.IsCanceled;
TaskStatus status = task.Status;

// Get exception (if faulted)
if (task.IsFaulted && task.Exception != null)
{
    foreach (var ex in task.Exception.InnerExceptions)
    {
        Console.WriteLine(ex.Message);
    }
}

// Get result (blocks if not completed)
if (task.IsCompletedSuccessfully)
{
    int result = task.Result; // Safe, already completed
}
```
