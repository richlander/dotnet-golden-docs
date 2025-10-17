# Async and Await
## Alternative Syntax Options

### Task.Run for CPU-Bound Work

```csharp
// Don't use async/await for CPU-bound work directly
public async Task<int> CalculateAsync(int n)
{
    // This still blocks a thread!
    return await Task.FromResult(ExpensiveCpuBoundOperation(n));
}

// Better: Use Task.Run to offload to thread pool
public Task<int> CalculateAsync(int n)
{
    return Task.Run(() => ExpensiveCpuBoundOperation(n));
}

// Usage is the same
int result = await CalculateAsync(1000000);
```

### ValueTask for High-Performance Scenarios

```csharp
// ValueTask<T> for scenarios with frequent synchronous completion
public async ValueTask<int> GetCachedValueAsync(string key)
{
    if (_cache.TryGetValue(key, out int value))
    {
        return value; // Synchronous return
    }
    
    value = await FetchFromDatabaseAsync(key);
    _cache[key] = value;
    return value;
}

// Regular Task<T> allocates even when completing synchronously
public async Task<int> GetCachedValueAsync(string key)
{
    if (_cache.TryGetValue(key, out int value))
    {
        return value; // Still allocates Task
    }
    
    value = await FetchFromDatabaseAsync(key);
    _cache[key] = value;
    return value;
}
```

### Synchronous Wrapper (Avoid in Most Cases)

```csharp
// Avoid: Blocking async code can cause deadlocks
public User GetUser(int id)
{
    return GetUserAsync(id).Result; // Dangerous!
}

public User GetUser(int id)
{
    return GetUserAsync(id).GetAwaiter().GetResult(); // Also dangerous!
}

// Better: Make calling code async
public async Task<User> GetUserWrapper(int id)
{
    return await GetUserAsync(id);
}

// Or if truly necessary, use AsyncHelper pattern (complex, avoid if possible)
```

### Task.FromResult for Sync Returns

```csharp
// When you need to return Task but operation is synchronous
public Task<int> GetCachedValueAsync(string key)
{
    if (_cache.TryGetValue(key, out int value))
    {
        return Task.FromResult(value); // No async needed
    }
    
    return FetchAndCacheAsync(key); // Actually async
}

private async Task<int> FetchAndCacheAsync(string key)
{
    var value = await FetchFromDatabaseAsync(key);
    _cache[key] = value;
    return value;
}
```
