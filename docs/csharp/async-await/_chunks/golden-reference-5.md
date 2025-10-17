# Async and Await
## Common Scenarios
### Parallel Async Operations

**When to use**: Running multiple independent async operations concurrently.

```csharp
public async Task<Dashboard> LoadDashboardAsync(int userId)
{
    // Start all tasks concurrently
    var userTask = GetUserAsync(userId);
    var ordersTask = GetRecentOrdersAsync(userId);
    var notificationsTask = GetNotificationsAsync(userId);
    var statsTask = GetUserStatsAsync(userId);
    
    // Wait for all to complete
    await Task.WhenAll(userTask, ordersTask, notificationsTask, statsTask);
    
    // Build dashboard from results
    return new Dashboard
    {
        User = await userTask,
        RecentOrders = await ordersTask,
        Notifications = await notificationsTask,
        Stats = await statsTask
    };
}
```

**Considerations**: Tasks start executing immediately when created. Use `Task.WhenAll` to wait for all completions.

### Retry Logic with Exponential Backoff

**When to use**: Implementing resilience for unreliable operations.

```csharp
public async Task<T> RetryAsync<T>(
    Func<Task<T>> operation,
    int maxRetries = 3,
    CancellationToken cancellationToken = default)
{
    for (int i = 0; i < maxRetries; i++)
    {
        try
        {
            return await operation();
        }
        catch (Exception ex) when (i < maxRetries - 1)
        {
            var delay = TimeSpan.FromSeconds(Math.Pow(2, i));
            await Task.Delay(delay, cancellationToken);
        }
    }
    
    // Last attempt without catching
    return await operation();
}

// Usage
var data = await RetryAsync(async () => await FetchDataFromUnreliableApiAsync());
```

**Considerations**: Use libraries like Polly for production retry scenarios with more sophisticated policies.

### Async Initialization Pattern

**When to use**: Objects that require async initialization.

```csharp
public class DataService
{
    private readonly HttpClient _client;
    private Config _config;
    
    private DataService()
    {
        _client = new HttpClient();
    }
    
    public static async Task<DataService> CreateAsync()
    {
        var service = new DataService();
        await service.InitializeAsync();
        return service;
    }
    
    private async Task InitializeAsync()
    {
        _config = await LoadConfigAsync();
        _client.DefaultRequestHeaders.Add("Authorization", _config.ApiKey);
    }
}

// Usage
var service = await DataService.CreateAsync();
```

**Considerations**: Constructors can't be async, so use factory methods for async initialization.
