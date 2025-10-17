# Task and Task&lt;T&gt;
## Limitations and Considerations
### Use Task.CompletedTask for Synchronous No-Op

```csharp
// Good: Return completed task for sync path
public Task SaveAsync(Data data)
{
    if (data == null)
        return Task.CompletedTask;
    
    return SaveToDbAsync(data);
}

// Less efficient: Creating new task
public Task SaveAsync(Data data)
{
    if (data == null)
        return Task.FromResult(0); // Unnecessary
    
    return SaveToDbAsync(data);
}
```

### Avoid Task Constructor

Don't create tasks with constructor (legacy pattern):

```csharp
// Bad: Old pattern
var task = new Task(() => DoWork());
task.Start();

// Good: Use Task.Run
var task = Task.Run(() => DoWork());

// Or async method
public async Task DoWorkAsync()
{
    await SomeOperationAsync();
}
```

### Use ConfigureAwait(false) in Libraries

Library code should not capture synchronization context:

```csharp
// Library code
public async Task<Data> ProcessDataAsync()
{
    var data = await FetchDataAsync().ConfigureAwait(false);
    var result = await TransformDataAsync(data).ConfigureAwait(false);
    return result;
}
```

### Dispose Tasks Carefully

Tasks don't implement IDisposable. Don't dispose them:

```csharp
// Wrong: Task is not IDisposable
using (var task = GetDataAsync()) // Compiler error
{
}

// Right: Await the task
var data = await GetDataAsync();

// Dispose resources returned from tasks
await using var stream = await GetStreamAsync();
```

## Limitations and Considerations

### Tasks Always Complete Asynchronously

Tasks posted to synchronization context complete asynchronously:

```csharp
// Even synchronous completion posts to context
public async Task<int> GetValueAsync()
{
    return 42; // Still completes asynchronously
}
```
