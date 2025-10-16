# Async and Await

## Overview

The `async` and `await` keywords enable asynchronous programming in C#, allowing you to write non-blocking code that appears synchronous. This programming model makes it straightforward to handle I/O-bound operations (network requests, file access, database queries) without blocking threads, improving application responsiveness and scalability.

Async/await represents a fundamental shift in how .NET handles asynchronous operations. Instead of callbacks or blocking waits, you write linear code that the compiler transforms into a state machine, enabling efficient cooperative multitasking.

```csharp
// Asynchronous method using async/await
public async Task<string> FetchDataAsync(string url)
{
    using var client = new HttpClient();
    string content = await client.GetStringAsync(url);
    return content;
}

// Calling async method
string data = await FetchDataAsync("https://api.example.com/data");
Console.WriteLine(data);
```

### Key Advantages

- **Non-blocking execution**: Free up threads while waiting for I/O operations
- **Improved scalability**: Handle more concurrent operations with fewer threads
- **Responsive UI**: Keep applications responsive during long-running operations
- **Linear code flow**: Write async code that looks like synchronous code
- **Composability**: Easily chain and combine async operations
- **Exception handling**: Use try/catch with async operations naturally

### Main Approaches

**Task-based async methods**:
- Use `async Task` for methods that perform async work and return no value
- Use `async Task<T>` for methods that return a value
- Use `async ValueTask<T>` for high-performance scenarios
- Use `async void` only for event handlers (avoid otherwise)

**Consuming async operations**:
- `await` expressions to wait for async operations
- `Task.WhenAll` for concurrent operations
- `Task.WhenAny` for race conditions or timeouts
- Async LINQ with `IAsyncEnumerable<T>`

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

### Error Handling

```csharp
public async Task<string> FetchDataWithErrorHandlingAsync(string url)
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

### Cancellation Support

```csharp
public async Task<string> FetchDataAsync(string url, CancellationToken cancellationToken)
{
    using var client = new HttpClient();
    
    // Pass cancellation token to async operations
    return await client.GetStringAsync(url, cancellationToken);
}

// Usage with timeout
var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));

try
{
    string data = await FetchDataAsync("https://api.example.com", cts.Token);
    Console.WriteLine(data);
}
catch (OperationCanceledException)
{
    Console.WriteLine("Operation was cancelled");
}
```

### ConfigureAwait

```csharp
// Library code - don't capture synchronization context
public async Task<Data> ProcessDataAsync()
{
    var raw = await FetchRawDataAsync().ConfigureAwait(false);
    var processed = await TransformDataAsync(raw).ConfigureAwait(false);
    return processed;
}

// UI code - capture context to update UI
public async Task LoadDataAsync()
{
    var data = await FetchDataAsync(); // Captures context by default
    this.DataLabel.Text = data.ToString(); // Can update UI safely
}
```

### Async Void (Event Handlers Only)

```csharp
// Async void for event handlers only
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

// Avoid async void for other methods - use async Task instead
```

## Relationships & Integration

### Task and Task&lt;T&gt;

`async` and `await` work with the `Task` type, which represents asynchronous operations:

```csharp
// Async method returns Task<T>
public async Task<int> GetValueAsync()
{
    await Task.Delay(100);
    return 42;
}

// Task represents the ongoing operation
Task<int> task = GetValueAsync();

// Await the task to get the result
int value = await task;

// Can also check status without awaiting
if (task.IsCompleted)
{
    int result = task.Result; // Don't block in async code
}
```

### IAsyncEnumerable Integration

Async/await enables asynchronous iteration with `IAsyncEnumerable<T>`:

```csharp
// Produce async sequence
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

### JSON Serialization with System.Text.Json

System.Text.Json provides async serialization methods:

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

// Stream large JSON arrays
public async Task ProcessLargeJsonAsync(string path)
{
    using var stream = File.OpenRead(path);
    
    await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream))
    {
        await ProcessItemAsync(item);
    }
}
```

### Entity Framework Core Integration

Entity Framework Core provides async query methods:

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

### ASP.NET Core Integration

ASP.NET Core is built on async/await throughout:

```csharp
[ApiController]
[Route("api/[controller]")]
public class CustomersController : ControllerBase
{
    private readonly MyDbContext _context;
    
    public CustomersController(MyDbContext context)
    {
        _context = context;
    }
    
    [HttpGet("{id}")]
    public async Task<ActionResult<Customer>> GetCustomer(int id)
    {
        var customer = await _context.Customers.FindAsync(id);
        
        if (customer == null)
            return NotFound();
        
        return customer;
    }
    
    [HttpPost]
    public async Task<ActionResult<Customer>> CreateCustomer(Customer customer)
    {
        _context.Customers.Add(customer);
        await _context.SaveChangesAsync();
        
        return CreatedAtAction(nameof(GetCustomer), new { id = customer.Id }, customer);
    }
}
```

### File I/O Integration

.NET provides async methods for file operations:

```csharp
// Read file asynchronously
public async Task<string> ReadFileAsync(string path)
{
    return await File.ReadAllTextAsync(path);
}

// Write file asynchronously
public async Task WriteFileAsync(string path, string content)
{
    await File.WriteAllTextAsync(path, content);
}

// Stream file reading
public async Task<List<string>> ReadLinesAsync(string path)
{
    var lines = new List<string>();
    
    using var reader = new StreamReader(path);
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        lines.Add(line);
    }
    
    return lines;
}
```

### HttpClient Integration

HttpClient is designed for async operations:

```csharp
public async Task<Product> GetProductAsync(int id)
{
    using var client = new HttpClient();
    return await client.GetFromJsonAsync<Product>($"https://api.example.com/products/{id}");
}

public async Task<string> PostDataAsync(string url, object data)
{
    using var client = new HttpClient();
    var response = await client.PostAsJsonAsync(url, data);
    response.EnsureSuccessStatusCode();
    return await response.Content.ReadAsStringAsync();
}
```

## Common Scenarios

### Web API Request with Error Handling

**When to use**: Making HTTP requests with proper error handling and timeouts.

```csharp
public async Task<ApiResponse<T>> CallApiAsync<T>(string url)
{
    using var client = new HttpClient();
    using var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));
    
    try
    {
        var response = await client.GetAsync(url, cts.Token);
        response.EnsureSuccessStatusCode();
        
        var data = await response.Content.ReadFromJsonAsync<T>(cancellationToken: cts.Token);
        
        return new ApiResponse<T>
        {
            Success = true,
            Data = data
        };
    }
    catch (HttpRequestException ex)
    {
        return new ApiResponse<T>
        {
            Success = false,
            Error = $"HTTP error: {ex.Message}"
        };
    }
    catch (OperationCanceledException)
    {
        return new ApiResponse<T>
        {
            Success = false,
            Error = "Request timeout"
        };
    }
}
```

**Considerations**: Always use cancellation tokens and handle timeouts appropriately.

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

### Processing Items in Batches

**When to use**: Processing large collections with controlled concurrency.

```csharp
public async Task ProcessItemsInBatchesAsync<T>(
    IEnumerable<T> items,
    Func<T, Task> processItem,
    int batchSize = 10)
{
    var batches = items.Chunk(batchSize);
    
    foreach (var batch in batches)
    {
        var tasks = batch.Select(processItem);
        await Task.WhenAll(tasks);
    }
}

// Usage
await ProcessItemsInBatchesAsync(
    customers,
    async customer => await SendEmailAsync(customer),
    batchSize: 20
);
```

**Considerations**: Control concurrency to avoid overwhelming resources or rate limits.

### Timeout Pattern

**When to use**: Adding timeout to operations that don't support cancellation.

```csharp
public async Task<T> WithTimeoutAsync<T>(Task<T> task, TimeSpan timeout)
{
    using var cts = new CancellationTokenSource();
    var delayTask = Task.Delay(timeout, cts.Token);
    var completedTask = await Task.WhenAny(task, delayTask);
    
    if (completedTask == delayTask)
    {
        throw new TimeoutException("Operation timed out");
    }
    
    cts.Cancel(); // Cancel the delay
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

**Considerations**: This doesn't actually cancel the original operation, just stops waiting for it.

### Async Lock Pattern

**When to use**: Coordinating async operations that need mutual exclusion.

```csharp
public class AsyncCache<TKey, TValue>
{
    private readonly Dictionary<TKey, TValue> _cache = new();
    private readonly SemaphoreSlim _semaphore = new(1, 1);
    
    public async Task<TValue> GetOrAddAsync(TKey key, Func<Task<TValue>> valueFactory)
    {
        await _semaphore.WaitAsync();
        try
        {
            if (_cache.TryGetValue(key, out var value))
            {
                return value;
            }
            
            value = await valueFactory();
            _cache[key] = value;
            return value;
        }
        finally
        {
            _semaphore.Release();
        }
    }
}

// Usage
var cache = new AsyncCache<string, User>();
var user = await cache.GetOrAddAsync("user123", async () => await FetchUserAsync("user123"));
```

**Considerations**: Use `SemaphoreSlim` for async synchronization, not `lock` statements.

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

## Best Practices

### Use Async All the Way

Once you start async, keep it async throughout the call chain:

```csharp
// Good: Async all the way
public async Task<string> Controller_Action()
{
    var data = await Service_GetDataAsync();
    return await Processor_ProcessAsync(data);
}

// Bad: Mixing sync and async (can cause deadlocks)
public string Controller_Action()
{
    var data = Service_GetDataAsync().Result; // Blocking!
    return Processor_ProcessAsync(data).Result; // Blocking!
}
```

### Always Use CancellationToken

Pass cancellation tokens through async call chains:

```csharp
public async Task<Data> ProcessDataAsync(CancellationToken cancellationToken = default)
{
    var raw = await FetchDataAsync(cancellationToken);
    var processed = await TransformDataAsync(raw, cancellationToken);
    return processed;
}
```

### Avoid Async Void

Only use `async void` for event handlers:

```csharp
// Good: Event handler
private async void Button_Click(object sender, EventArgs e)
{
    await LoadDataAsync();
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

// Application code can omit ConfigureAwait (defaults to true)
public async Task UpdateUIAsync()
{
    var data = await FetchDataAsync();
    this.Label.Text = data.ToString(); // Can update UI
}
```

### Don't Block on Async Code

Never use `.Result` or `.Wait()` on tasks in async contexts:

```csharp
// Bad: Can cause deadlocks
public async Task ProcessAsync()
{
    var data = GetDataAsync().Result; // Deadlock risk!
    await SaveDataAsync(data);
}

// Good: Await properly
public async Task ProcessAsync()
{
    var data = await GetDataAsync();
    await SaveDataAsync(data);
}
```

### Handle Exceptions Appropriately

Use try/catch with async code naturally:

```csharp
public async Task<Result> ProcessWithErrorHandlingAsync()
{
    try
    {
        var data = await FetchDataAsync();
        return new Result { Success = true, Data = data };
    }
    catch (HttpRequestException ex)
    {
        _logger.LogError(ex, "Failed to fetch data");
        return new Result { Success = false, Error = ex.Message };
    }
}
```

### Avoid Capturing Too Much Context

Be mindful of what closures capture in async lambdas:

```csharp
// Can capture large objects unnecessarily
public async Task ProcessItemsAsync(List<HugeObject> items)
{
    await Task.Run(async () =>
    {
        // This captures the entire 'items' list
        await Task.Delay(100);
    });
}

// Better: Only capture what you need
public async Task ProcessItemsAsync(List<HugeObject> items)
{
    int count = items.Count;
    await Task.Run(async () =>
    {
        // Only captures 'count'
        await Task.Delay(100);
    });
}
```

## Limitations and Considerations

### Async Methods Have Overhead

Async/await has a small performance cost:

```csharp
// Overhead not worth it for very fast operations
public async Task<int> AddAsync(int a, int b)
{
    return await Task.FromResult(a + b); // Wasteful
}

// Better: Just use synchronous code
public int Add(int a, int b)
{
    return a + b;
}
```

Use async only when operations are genuinely I/O-bound or long-running.

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
