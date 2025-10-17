# Async and Await
## See Also
### Async Doesn't Make Code Faster

Async improves scalability and responsiveness, not raw speed:

```csharp
// This doesn't make the calculation faster
public async Task<int> CalculateAsync(int n)
{
    return await Task.Run(() => ExpensiveCalculation(n));
    // Still takes same time, just doesn't block calling thread
}
```

For CPU-bound work, use parallelism (Parallel.For, PLINQ) not async.

### State Machine Allocation

Every async method creates a state machine:

```csharp
// Each call allocates a state machine
public async Task<int> SimpleAsync()
{
    await Task.Delay(100);
    return 42;
}

// For hot paths, consider ValueTask
public async ValueTask<int> SimpleAsync()
{
    await Task.Delay(100);
    return 42;
}
```

### Exceptions in Task.WhenAll

Only first exception is thrown, others are in AggregateException:

```csharp
var tasks = new[]
{
    Task.Run(() => throw new Exception("Error 1")),
    Task.Run(() => throw new Exception("Error 2")),
    Task.Run(() => throw new Exception("Error 3"))
};

try
{
    await Task.WhenAll(tasks);
}
catch (Exception ex)
{
    // Only "Error 1" is caught here
    Console.WriteLine(ex.Message);
    
    // To see all exceptions:
    foreach (var task in tasks)
    {
        if (task.Exception != null)
        {
            foreach (var innerEx in task.Exception.InnerExceptions)
            {
                Console.WriteLine(innerEx.Message);
            }
        }
    }
}
```

## See Also

- **Task and Task&lt;T&gt;**: The types that represent asynchronous operations
- **IAsyncEnumerable&lt;T&gt;**: Asynchronous iteration with await foreach
- **IEnumerable&lt;T&gt;**: Synchronous enumeration foundation
- **System.Text.Json**: JSON serialization with async methods
- **Entity Framework Core**: Async database queries
- **ASP.NET Core**: Built on async/await throughout
- **CancellationToken**: Cancellation support for async operations
- **ValueTask**: High-performance async scenarios
- **SemaphoreSlim**: Async-compatible synchronization
