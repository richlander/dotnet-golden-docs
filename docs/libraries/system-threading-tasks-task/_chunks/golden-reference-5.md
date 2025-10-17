# Task and Task&lt;T&gt;
## Common Scenarios

### Parallel API Calls

**When to use**: Fetching data from multiple independent sources concurrently.

```csharp
public async Task<Dashboard> LoadDashboardAsync(int userId)
{
    // Create tasks for parallel execution
    Task<User> userTask = _userService.GetUserAsync(userId);
    Task<List<Order>> ordersTask = _orderService.GetRecentOrdersAsync(userId);
    Task<Stats> statsTask = _statsService.GetUserStatsAsync(userId);
    Task<List<Notification>> notificationsTask = _notificationService.GetUnreadAsync(userId);
    
    // Wait for all
    await Task.WhenAll(userTask, ordersTask, statsTask, notificationsTask);
    
    return new Dashboard
    {
        User = await userTask,
        Orders = await ordersTask,
        Stats = await statsTask,
        Notifications = await notificationsTask
    };
}
```

**Considerations**: All tasks execute concurrently. If one fails, `Task.WhenAll` still waits for all others to complete before throwing.

### Timeout with Fallback

**When to use**: Operations that might hang or take too long.

```csharp
public async Task<T> GetWithTimeoutAsync<T>(
    Task<T> primaryTask,
    Task<T> fallbackTask,
    TimeSpan timeout)
{
    var delayTask = Task.Delay(timeout);
    var completed = await Task.WhenAny(primaryTask, delayTask);
    
    if (completed == delayTask)
    {
        // Timeout - use fallback
        return await fallbackTask;
    }
    
    return await primaryTask;
}

// Usage
var primary = FetchFromPrimaryApiAsync();
var fallback = FetchFromCacheAsync();
var result = await GetWithTimeoutAsync(primary, fallback, TimeSpan.FromSeconds(5));
```

**Considerations**: The timed-out task continues running in background. Consider cancellation tokens for cleanup.

### Retry with Exponential Backoff

**When to use**: Handling transient failures in network operations.

```csharp
public async Task<T> RetryAsync<T>(
    Func<Task<T>> operation,
    int maxRetries = 3)
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
            await Task.Delay(delay);
        }
    }
    
    return await operation(); // Last attempt
}

// Usage
var data = await RetryAsync(() => FetchDataFromUnreliableApiAsync());
```

**Considerations**: Consider using Polly library for production scenarios with more sophisticated policies.
