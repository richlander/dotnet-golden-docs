# Async and Await -- Q&A

## Basic Concepts

---
difficulty: "beginner"
validation: "manual-review"
topics: ["async", "await", "asynchronous-programming"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: What are async and await in C#?
A: `async` and `await` are keywords that enable asynchronous programming in C#. The `async` modifier marks a method as asynchronous, and the `await` keyword suspends execution of the method until an awaited task completes, without blocking the thread.

```csharp
public async Task<string> FetchDataAsync(string url)
{
    using var client = new HttpClient();
    string content = await client.GetStringAsync(url);
    return content;
}
```

------

---
difficulty: "beginner"
validation: "manual-review"
topics: ["async", "benefits", "performance"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Why should I use async and await?
Q: What are the benefits of async/await?
A: Async/await enables non-blocking I/O operations, improving application responsiveness and scalability. It allows threads to handle other work while waiting for I/O operations (network requests, file access, database queries) to complete, rather than blocking and wasting thread resources.

------

---
difficulty: "beginner"
validation: "code-compiles"
topics: ["async", "task", "return-types"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: What return types can async methods have?
A: Async methods can return `Task`, `Task<T>`, `ValueTask<T>`, or `void` (only for event handlers). Use `Task<T>` when returning a value, `Task` when returning no value, and avoid `async void` except for event handlers.

```csharp
// Returns a value
public async Task<int> GetLengthAsync(string url)
{
    var client = new HttpClient();
    string data = await client.GetStringAsync(url);
    return data.Length;
}

// Returns no value
public async Task SaveDataAsync(string path, string content)
{
    await File.WriteAllTextAsync(path, content);
}

// Event handler only
private async void Button_Click(object sender, EventArgs e)
{
    await LoadDataAsync();
}
```

------

## Basic Usage

---
difficulty: "beginner"
validation: "code-compiles"
topics: ["async", "await", "http"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I make an async HTTP request?
A: Use `HttpClient` with `await`:

```csharp
public async Task<string> GetDataAsync(string url)
{
    using var client = new HttpClient();
    return await client.GetStringAsync(url);
}

// Usage
string data = await GetDataAsync("https://api.example.com/data");
```

------

---
difficulty: "beginner"
validation: "code-compiles"
topics: ["async", "await", "file-io"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I read a file asynchronously?
A: Use the async file methods:

```csharp
public async Task<string> ReadFileAsync(string path)
{
    return await File.ReadAllTextAsync(path);
}

public async Task WriteFileAsync(string path, string content)
{
    await File.WriteAllTextAsync(path, content);
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["async", "sequential", "operations"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I run async operations sequentially?
Q: How do I await multiple operations one after another?
A: Simply await each operation in sequence:

```csharp
public async Task<Report> GenerateReportAsync(int userId)
{
    // Each operation waits for the previous one to complete
    User user = await FetchUserAsync(userId);
    List<Order> orders = await FetchOrdersAsync(user.Id);
    Stats stats = await CalculateStatsAsync(orders);
    
    return new Report(user, orders, stats);
}
```

------

## Concurrent Operations

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["async", "parallel", "task-whenall"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I run multiple async operations concurrently?
Q: How do I use Task.WhenAll?
A: Start all tasks before awaiting them, then use `Task.WhenAll`:

```csharp
public async Task<Dashboard> LoadDashboardAsync(int userId)
{
    // Start all tasks concurrently
    var userTask = GetUserAsync(userId);
    var ordersTask = GetOrdersAsync(userId);
    var statsTask = GetStatsAsync(userId);
    
    // Wait for all to complete
    await Task.WhenAll(userTask, ordersTask, statsTask);
    
    // Get results
    return new Dashboard
    {
        User = await userTask,
        Orders = await ordersTask,
        Stats = await statsTask
    };
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["async", "task-whenany", "timeout"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I implement a timeout with async operations?
A: Use `Task.WhenAny` with `Task.Delay`:

```csharp
public async Task<T> WithTimeoutAsync<T>(Task<T> task, TimeSpan timeout)
{
    var delayTask = Task.Delay(timeout);
    var completedTask = await Task.WhenAny(task, delayTask);
    
    if (completedTask == delayTask)
    {
        throw new TimeoutException("Operation timed out");
    }
    
    return await task;
}

// Usage
try
{
    var result = await WithTimeoutAsync(
        SlowOperationAsync(),
        TimeSpan.FromSeconds(5)
    );
}
catch (TimeoutException)
{
    Console.WriteLine("Operation timed out");
}
```

------

## Error Handling

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["async", "exceptions", "error-handling"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I handle exceptions in async methods?
A: Use try/catch blocks normally with async code:

```csharp
public async Task<string> FetchDataAsync(string url)
{
    try
    {
        using var client = new HttpClient();
        return await client.GetStringAsync(url);
    }
    catch (HttpRequestException ex)
    {
        Console.WriteLine($"Request failed: {ex.Message}");
        return string.Empty;
    }
    catch (TaskCanceledException ex)
    {
        Console.WriteLine($"Request timeout: {ex.Message}");
        return string.Empty;
    }
}
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["async", "task-whenall", "exceptions"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I handle exceptions when using Task.WhenAll?
A: `Task.WhenAll` throws only the first exception. To see all exceptions, check each task:

```csharp
var tasks = new[] { Task1Async(), Task2Async(), Task3Async() };

try
{
    await Task.WhenAll(tasks);
}
catch (Exception ex)
{
    // Only first exception caught here
    Console.WriteLine($"First exception: {ex.Message}");
    
    // To see all exceptions:
    foreach (var task in tasks.Where(t => t.IsFaulted))
    {
        Console.WriteLine($"Task exception: {task.Exception?.InnerException?.Message}");
    }
}
```

------

## Cancellation

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["async", "cancellation", "cancellationtoken"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I add cancellation support to async methods?
Q: How do I use CancellationToken with async/await?
A: Accept a `CancellationToken` parameter and pass it to async operations:

```csharp
public async Task<string> FetchDataAsync(string url, CancellationToken cancellationToken)
{
    using var client = new HttpClient();
    return await client.GetStringAsync(url, cancellationToken);
}

// Usage with timeout
var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));

try
{
    string data = await FetchDataAsync("https://api.example.com", cts.Token);
}
catch (OperationCanceledException)
{
    Console.WriteLine("Operation was cancelled");
}
```

------

## ConfigureAwait

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["async", "configureawait", "context"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: What is ConfigureAwait and when should I use it?
Q: When should I use ConfigureAwait(false)?
A: `ConfigureAwait(false)` tells the await to not capture the synchronization context. Use it in library code to avoid unnecessary context switches and potential deadlocks. Don't use it in UI code where you need to update UI elements after the await.

```csharp
// Library code - use ConfigureAwait(false)
public async Task<Data> ProcessDataAsync()
{
    var raw = await FetchDataAsync().ConfigureAwait(false);
    var processed = await TransformAsync(raw).ConfigureAwait(false);
    return processed;
}

// UI code - don't use ConfigureAwait(false)
public async Task LoadDataAsync()
{
    var data = await FetchDataAsync(); // Captures context
    this.Label.Text = data.ToString(); // Can update UI safely
}
```

------

## Integration Scenarios

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["async", "json", "serialization"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I serialize JSON asynchronously?
A: Use `JsonSerializer.SerializeAsync` and `JsonSerializer.DeserializeAsync`:

```csharp
using System.Text.Json;

// Async serialization
public async Task SaveToJsonAsync<T>(string path, T data)
{
    using var stream = File.Create(path);
    await JsonSerializer.SerializeAsync(stream, data);
}

// Async deserialization
public async Task<T> LoadFromJsonAsync<T>(string path)
{
    using var stream = File.OpenRead(path);
    return await JsonSerializer.DeserializeAsync<T>(stream);
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["async", "entity-framework", "database"]
audience: ["backend-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I use async with Entity Framework Core?
A: Use the async query methods like `ToListAsync`, `FindAsync`, `SaveChangesAsync`:

```csharp
using Microsoft.EntityFrameworkCore;

public async Task<List<Customer>> GetActiveCustomersAsync(MyDbContext context)
{
    return await context.Customers
        .Where(c => c.IsActive)
        .OrderBy(c => c.Name)
        .ToListAsync();
}

public async Task<Customer> FindCustomerAsync(MyDbContext context, int id)
{
    return await context.Customers.FindAsync(id);
}

public async Task SaveChangesAsync(MyDbContext context)
{
    await context.SaveChangesAsync();
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["async", "iasyncenumerable", "iteration"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I iterate asynchronously with IAsyncEnumerable?
A: Use `await foreach` with `IAsyncEnumerable<T>`:

```csharp
public async IAsyncEnumerable<int> GetNumbersAsync()
{
    for (int i = 0; i < 10; i++)
    {
        await Task.Delay(100);
        yield return i;
    }
}

// Consume with await foreach
await foreach (int num in GetNumbersAsync())
{
    Console.WriteLine(num);
}
```

------

## Best Practices

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["async", "best-practices", "async-all-the-way"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Should I use .Result or .Wait() on async tasks?
Q: Why is blocking async code dangerous?
A: Never use `.Result` or `.Wait()` in async code - they can cause deadlocks. Always use `await` and keep async throughout your call chain ("async all the way").

```csharp
// Bad: Can cause deadlocks
public void ProcessData()
{
    var data = GetDataAsync().Result; // Dangerous!
}

// Good: Async all the way
public async Task ProcessDataAsync()
{
    var data = await GetDataAsync();
}
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["async", "async-void", "best-practices"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: When should I use async void?
Q: Why should I avoid async void?
A: Only use `async void` for event handlers. For all other methods, use `async Task`. Async void methods can't be awaited and exceptions in them can crash your application.

```csharp
// Good: Event handler
private async void Button_Click(object sender, EventArgs e)
{
    try
    {
        await LoadDataAsync();
    }
    catch (Exception ex)
    {
        MessageBox.Show($"Error: {ex.Message}");
    }
}

// Bad: Regular method
private async void LoadData() // Can't be awaited, swallows exceptions
{
    await FetchDataAsync();
}

// Good: Regular method
private async Task LoadDataAsync()
{
    await FetchDataAsync();
}
```

------

---
difficulty: "advanced"
validation: "manual-review"
topics: ["async", "cpu-bound", "task-run"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Should I use async/await for CPU-bound operations?
Q: When should I use Task.Run?
A: Async/await is for I/O-bound operations. For CPU-bound work, use `Task.Run` to offload to the thread pool, or use parallel programming constructs like `Parallel.For` or PLINQ.

```csharp
// Don't use async for CPU-bound work directly
public async Task<int> CalculateAsync(int n)
{
    return await Task.FromResult(ExpensiveCalculation(n)); // Wrong!
}

// Better: Use Task.Run for CPU-bound work
public Task<int> CalculateAsync(int n)
{
    return Task.Run(() => ExpensiveCalculation(n));
}

// Usage is the same
int result = await CalculateAsync(1000000);
```

------

## Advanced Scenarios

---
difficulty: "advanced"
validation: "code-compiles"
topics: ["async", "retry", "resilience"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I implement retry logic with async/await?
A: Create a retry helper that catches exceptions and delays between attempts:

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

------

---
difficulty: "advanced"
validation: "code-compiles"
topics: ["async", "semaphore", "synchronization"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I synchronize async operations?
Q: Why can't I use lock with await?
A: You can't use `lock` with `await`. Instead, use `SemaphoreSlim` for async synchronization:

```csharp
private readonly SemaphoreSlim _semaphore = new SemaphoreSlim(1, 1);

public async Task<T> GetOrAddAsync<T>(string key, Func<Task<T>> factory)
{
    await _semaphore.WaitAsync();
    try
    {
        if (_cache.TryGetValue(key, out T value))
        {
            return value;
        }
        
        value = await factory();
        _cache[key] = value;
        return value;
    }
    finally
    {
        _semaphore.Release();
    }
}
```

------

---
difficulty: "advanced"
validation: "code-compiles"
topics: ["async", "valuetask", "performance"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: What is ValueTask and when should I use it?
Q: When should I use ValueTask instead of Task?
A: `ValueTask<T>` is a struct-based alternative to `Task<T>` that can avoid allocations when operations complete synchronously. Use it for high-performance scenarios where operations often complete synchronously (e.g., cached results).

```csharp
// ValueTask for frequently synchronous completions
public async ValueTask<int> GetCachedValueAsync(string key)
{
    if (_cache.TryGetValue(key, out int value))
    {
        return value; // Synchronous return, no allocation
    }
    
    value = await FetchFromDatabaseAsync(key);
    _cache[key] = value;
    return value;
}
```

Note: Only use `ValueTask<T>` for hot paths where allocation matters. Regular `Task<T>` is simpler and safer for most scenarios.

------

## Troubleshooting

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["async", "troubleshooting", "deadlock"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Why is my async code deadlocking?
Q: How do I fix async deadlocks?
A: Deadlocks often occur when blocking on async code with `.Result` or `.Wait()` in contexts with a synchronization context (UI, old ASP.NET). Solution: use async all the way, never block on async code.

```csharp
// Deadlock scenario
public void ProcessData()
{
    var data = GetDataAsync().Result; // Blocks waiting
    // GetDataAsync tries to return to this context which is blocked
}

// Solution: Make it async
public async Task ProcessDataAsync()
{
    var data = await GetDataAsync();
}
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["async", "troubleshooting", "performance"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Why isn't my async code running faster?
A: Async doesn't make code faster - it improves scalability and responsiveness by freeing threads during I/O waits. For CPU-bound work, async won't help; use parallel programming instead.

```csharp
// This doesn't make calculation faster
public async Task<int> CalculateAsync(int n)
{
    return await Task.Run(() => ExpensiveCalculation(n));
    // Still takes same time, just doesn't block calling thread
}

// For CPU-bound parallelism, use Parallel or PLINQ
var results = Parallel.For(0, 1000, i => Calculate(i));
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["async", "troubleshooting", "task"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Why is my async method not awaiting?
Q: What happens if I don't await an async method?
A: If you don't await an async method, it starts executing but you don't wait for completion. This can lead to unhandled exceptions and race conditions.

```csharp
// Bad: Fire-and-forget
public void ProcessData()
{
    SaveDataAsync(); // Starts but doesn't wait
    // Method returns immediately, SaveDataAsync might not finish
}

// Good: Await the operation
public async Task ProcessDataAsync()
{
    await SaveDataAsync(); // Waits for completion
}

// If you intentionally want fire-and-forget, handle exceptions
public void ProcessData()
{
    _ = SaveDataAsync().ContinueWith(t =>
    {
        if (t.IsFaulted)
        {
            _logger.LogError(t.Exception, "Save failed");
        }
    });
}
```

------

## Comparison

---
difficulty: "beginner"
validation: "manual-review"
topics: ["async", "sync", "comparison"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: What's the difference between synchronous and asynchronous code?
A: Synchronous code blocks the thread while waiting for operations to complete. Asynchronous code (async/await) frees the thread to do other work while waiting, improving scalability and responsiveness.

```csharp
// Synchronous - blocks thread
public string FetchData(string url)
{
    using var client = new WebClient();
    return client.DownloadString(url); // Thread blocked here
}

// Asynchronous - doesn't block
public async Task<string> FetchDataAsync(string url)
{
    using var client = new HttpClient();
    return await client.GetStringAsync(url); // Thread freed while waiting
}
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["async", "task", "thread"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Does async/await create new threads?
A: No, async/await doesn't create new threads. It reuses existing thread pool threads more efficiently by not blocking them during I/O operations.

------
