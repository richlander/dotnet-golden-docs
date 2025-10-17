# Task and Task&lt;T&gt;
## Limitations and Considerations
### Task.Result Can Deadlock

Blocking on tasks can deadlock in certain contexts:

```csharp
// Deadlock in UI or ASP.NET contexts
public void Button_Click()
{
    var data = GetDataAsync().Result; // Deadlock!
}

// Solution: Use async event handler
public async void Button_Click()
{
    var data = await GetDataAsync();
}
```

### Task.WhenAll Exception Handling

Only first exception is thrown:

```csharp
try
{
    await Task.WhenAll(task1, task2, task3);
}
catch (Exception ex)
{
    // Only first exception
    // Others in task.Exception.InnerExceptions
}
```

### Task State is Cached

Completed tasks cache their state:

```csharp
Task<int> task = Task.FromResult(42);
// task.Result can be read synchronously forever
// task.IsCompleted is always true
```

### No Timeout Built-In

Tasks don't have built-in timeout:

```csharp
// Must implement timeout manually
using var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));
await FetchDataAsync(cts.Token);

// Or use Task.WhenAny pattern
```

### Hot Tasks vs Cold Tasks

.NET tasks are "hot" - they start immediately:

```csharp
// Task starts immediately when created
var task = GetDataAsync(); // Already running!
await task;

// No way to create "cold" task that starts on await
// (unlike some other async frameworks)
```

### Memory Overhead

Each Task allocates memory:

```csharp
// This creates many task objects
for (int i = 0; i < 1000000; i++)
{
    await Task.FromResult(i); // Not efficient
}

// Consider ValueTask for hot paths
for (int i = 0; i < 1000000; i++)
{
    await GetValueAsync(i); // ValueTask reduces allocations
}
```
