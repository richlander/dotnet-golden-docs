# Task and Task&lt;T&gt;
## Essential Syntax & Examples
### When to Use

Use Task/Task&lt;T&gt; when:
- Implementing async methods with `async/await`
- Representing I/O-bound operations (network, file, database)
- Offloading CPU-bound work with `Task.Run`
- Building async APIs and libraries
- Coordinating multiple async operations

Consider alternatives when:
- Operations complete synchronously most of the time: Use `ValueTask<T>`
- Streaming async data: Use `IAsyncEnumerable<T>`
- Very simple async scenarios in hot paths: Use `ValueTask<T>`

## Essential Syntax & Examples

### Basic Task Creation and Await

```csharp
// Async method returns Task<T>
public async Task<int> GetDataLengthAsync(string url)
{
    using var client = new HttpClient();
    string data = await client.GetStringAsync(url);
    return data.Length;
}

// Consuming the task
Task<int> lengthTask = GetDataLengthAsync("https://api.example.com");
int length = await lengthTask;
```

### Task Without Return Value

```csharp
// Async method returns Task
public async Task SaveDataAsync(string path, string content)
{
    await File.WriteAllTextAsync(path, content);
    Console.WriteLine("Saved");
}

// Usage
await SaveDataAsync("file.txt", "data");
```

### Task.Run for CPU-Bound Work

```csharp
// Offload CPU-bound work to thread pool
public Task<int> CalculateAsync(int n)
{
    return Task.Run(() =>
    {
        int result = 0;
        for (int i = 0; i < n; i++)
        {
            result += i;
        }
        return result;
    });
}

// Usage
int result = await CalculateAsync(1000000);
```

### Task.WhenAll for Concurrent Operations

```csharp
public async Task<Summary> GetSummaryAsync(int userId)
{
    // Start all tasks concurrently
    Task<User> userTask = GetUserAsync(userId);
    Task<List<Order>> ordersTask = GetOrdersAsync(userId);
    Task<Stats> statsTask = GetStatsAsync(userId);
    
    // Wait for all to complete
    await Task.WhenAll(userTask, ordersTask, statsTask);
    
    // All tasks completed, get results
    return new Summary
    {
        User = userTask.Result,
        Orders = ordersTask.Result,
        Stats = statsTask.Result
    };
}
```
