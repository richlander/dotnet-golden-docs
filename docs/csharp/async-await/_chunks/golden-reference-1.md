# Async and Await
## Essential Syntax & Examples
### When to Use

Use async/await for:
- Network operations (HTTP requests, web services)
- File I/O operations (reading, writing files)
- Database queries and data access
- Any I/O-bound work that would block threads

Avoid async/await for:
- CPU-bound operations (use `Task.Run` or parallel programming instead)
- Very short operations (overhead not worth it)
- Synchronous code paths (don't fake async)

## Essential Syntax & Examples

### Basic Async Method

```csharp
// Async method returning Task<T>
public async Task<int> GetDataLengthAsync(string url)
{
    using var client = new HttpClient();
    string data = await client.GetStringAsync(url);
    return data.Length;
}

// Calling async method
int length = await GetDataLengthAsync("https://api.example.com");
Console.WriteLine($"Data length: {length}");
```

### Async Method Returning Task

```csharp
// Async method that doesn't return a value
public async Task SaveDataAsync(string filePath, string content)
{
    await File.WriteAllTextAsync(filePath, content);
    Console.WriteLine("Data saved");
}

// Usage
await SaveDataAsync("data.txt", "Hello, World!");
```

### Multiple Sequential Async Operations

```csharp
public async Task<Report> GenerateReportAsync(int userId)
{
    // Sequential operations - each waits for previous
    User user = await FetchUserAsync(userId);
    List<Order> orders = await FetchOrdersAsync(user.Id);
    List<Product> products = await FetchProductsAsync(orders);
    
    return new Report(user, orders, products);
}
```

### Concurrent Async Operations

```csharp
public async Task<Report> GenerateReportAsync(int userId)
{
    // Start all operations concurrently
    Task<User> userTask = FetchUserAsync(userId);
    Task<Settings> settingsTask = FetchSettingsAsync(userId);
    Task<Stats> statsTask = FetchStatsAsync(userId);
    
    // Wait for all to complete
    await Task.WhenAll(userTask, settingsTask, statsTask);
    
    // Get results
    return new Report(userTask.Result, settingsTask.Result, statsTask.Result);
}

// Alternative with WhenAll returning results
public async Task<Report> GenerateReportAsync(int userId)
{
    Task<User> userTask = FetchUserAsync(userId);
    Task<Settings> settingsTask = FetchSettingsAsync(userId);
    Task<Stats> statsTask = FetchStatsAsync(userId);
    
    // WhenAll with multiple different types
    await Task.WhenAll(userTask, settingsTask, statsTask);
    
    return new Report(
        await userTask,
        await settingsTask,
        await statsTask
    );
}
```
