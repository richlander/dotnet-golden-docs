# Async and Await
## Limitations and Considerations
### Async Void Swallows Exceptions

Exceptions in `async void` methods can't be caught normally:

```csharp
// Exception will crash the app or get lost
private async void DoWorkAsync()
{
    throw new Exception("Error"); // Can't be caught by caller
}

// Solution: Use async Task and handle exceptions internally
private async void Button_Click(object sender, EventArgs e)
{
    try
    {
        await DoWorkAsync(); // Now exceptions can be caught
    }
    catch (Exception ex)
    {
        MessageBox.Show($"Error: {ex.Message}");
    }
}

private async Task DoWorkAsync()
{
    throw new Exception("Error");
}
```

### Blocking Async Code Can Deadlock

Calling `.Result` or `.Wait()` can cause deadlocks:

```csharp
// Deadlock scenario (especially in UI/ASP.NET contexts)
public void ProcessData()
{
    var data = GetDataAsync().Result; // Blocks waiting
    // GetDataAsync tries to return to this context which is blocked
}

// Solution: Use async all the way
public async Task ProcessDataAsync()
{
    var data = await GetDataAsync();
}
```

### Task.WhenAll Doesn't Short-Circuit

`Task.WhenAll` waits for all tasks even if one fails:

```csharp
public async Task ProcessMultipleAsync()
{
    try
    {
        await Task.WhenAll(
            Task1Async(), // Fails immediately
            Task2Async(), // Still runs to completion
            Task3Async()  // Still runs to completion
        );
    }
    catch (Exception ex)
    {
        // Only gets first exception
        // Other exceptions in task.Exception.InnerExceptions
    }
}
```

### Can't Use Await in Lock Statements

Lock statements don't work with await:

```csharp
// This doesn't compile
lock (_lock)
{
    await DoSomethingAsync(); // Error: await in lock
}

// Solution: Use SemaphoreSlim
await _semaphore.WaitAsync();
try
{
    await DoSomethingAsync();
}
finally
{
    _semaphore.Release();
}
```
