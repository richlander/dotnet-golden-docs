# IAsyncEnumerable&lt;T&gt;

## Overview

`IAsyncEnumerable<T>` represents an asynchronous sequence of elements that can be enumerated using `await foreach`. This interface enables efficient iteration over async data sources like network streams, database queries, or paginated APIs without blocking threads while waiting for data.

Introduced in C# 8.0 with .NET Core 3.0, `IAsyncEnumerable<T>` brings the composability and deferred execution benefits of `IEnumerable<T>` to asynchronous scenarios, allowing you to build async LINQ pipelines and work with streaming data sources efficiently.

```csharp
// Asynchronously iterate over a sequence
await foreach (var item in GetItemsAsync())
{
    Console.WriteLine(item);
}

// Create async sequences with async iterator methods
public async IAsyncEnumerable<int> GetNumbersAsync(int count)
{
    for (int i = 0; i < count; i++)
    {
        await Task.Delay(100); // Simulate async work
        yield return i;
    }
}
```

### Key Advantages

- **Non-blocking iteration**: Awaits each element without blocking threads
- **Streaming data support**: Process data as it arrives from async sources
- **Memory efficiency**: Avoid loading entire datasets into memory
- **Composability**: Chain async operations like LINQ queries
- **Deferred execution**: Operations execute on-demand during iteration
- **Backpressure handling**: Natural flow control for producer-consumer scenarios

### Main Approaches

Consuming IAsyncEnumerable:
- **await foreach**: Asynchronous iteration with `await foreach` loop
- **Async LINQ**: Use System.Linq.Async for query operations
- **ToListAsync/ToArrayAsync**: Materialize async sequences into collections
- **Manual enumeration**: Use `GetAsyncEnumerator()` for low-level control

Producing IAsyncEnumerable:
- **async yield return**: Create async iterators with `async` and `yield return`
- **Async LINQ operators**: Transform existing async sequences
- **Channel-based**: Use `System.Threading.Channels` for producer-consumer patterns
- **Custom implementations**: Implement the interface for full control

### When to Use

Use `IAsyncEnumerable<T>` when:
- Retrieving data from async sources (databases, APIs, file I/O)
- Processing paginated API responses
- Streaming large datasets without loading everything into memory
- Building async data pipelines with composition
- Working with real-time data feeds or event streams

Consider synchronous `IEnumerable<T>` when:
- Data is already in memory
- Operations are CPU-bound rather than I/O-bound
- You don't need async iteration
- Compatibility with older .NET versions is required

Consider `Task<IEnumerable<T>>` when:
- You need to return an entire collection asynchronously
- The async work happens before iteration (loading all data)
- Multiple iterations over the same data are expected

## Essential Syntax & Examples

### Basic Async Iteration

```csharp
// Consuming IAsyncEnumerable<T> with await foreach
public async Task ProcessDataAsync()
{
    await foreach (string line in ReadLinesAsync("file.txt"))
    {
        Console.WriteLine(line);
    }
}

// Creating IAsyncEnumerable<T> with async iterator
public async IAsyncEnumerable<string> ReadLinesAsync(string path)
{
    using var reader = new StreamReader(path);
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        yield return line;
    }
}
```

### Async LINQ Operations

```csharp
using System.Linq;

IAsyncEnumerable<int> numbers = GetNumbersAsync();

// Filter with Where (from System.Linq.Async)
IAsyncEnumerable<int> evenNumbers = numbers.Where(n => n % 2 == 0);

// Transform with Select
IAsyncEnumerable<string> strings = numbers.Select(n => $"Number: {n}");

// Chain operations
IAsyncEnumerable<int> result = numbers
    .Where(n => n > 5)
    .Select(n => n * 2)
    .Take(10);

await foreach (int value in result)
{
    Console.WriteLine(value);
}
```

Note: For full async LINQ support, install the `System.Linq.Async` NuGet package which provides extension methods like `WhereAsync`, `SelectAsync`, etc.

### Cancellation Support

```csharp
// Accept CancellationToken in async iterators
public async IAsyncEnumerable<int> GetNumbersAsync(
    int count,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    for (int i = 0; i < count; i++)
    {
        cancellationToken.ThrowIfCancellationRequested();
        await Task.Delay(100, cancellationToken);
        yield return i;
    }
}

// Use with cancellation
var cts = new CancellationTokenSource(TimeSpan.FromSeconds(5));

try
{
    await foreach (int num in GetNumbersAsync(100, cts.Token))
    {
        Console.WriteLine(num);
    }
}
catch (OperationCanceledException)
{
    Console.WriteLine("Iteration cancelled");
}
```

### Async Data Pipeline

```csharp
public async IAsyncEnumerable<ProcessedData> BuildPipelineAsync(
    IAsyncEnumerable<RawData> source)
{
    await foreach (var raw in source)
    {
        // Async transformation
        var validated = await ValidateAsync(raw);
        if (validated != null)
        {
            var enriched = await EnrichAsync(validated);
            var processed = await TransformAsync(enriched);
            yield return processed;
        }
    }
}

// Usage
IAsyncEnumerable<RawData> rawData = FetchFromApiAsync();
IAsyncEnumerable<ProcessedData> processed = BuildPipelineAsync(rawData);

await foreach (var item in processed)
{
    await SaveAsync(item);
}
```

### Materialization

```csharp
IAsyncEnumerable<int> numbers = GetNumbersAsync();

// Materialize to collections (requires System.Linq.Async)
List<int> list = await numbers.ToListAsync();
int[] array = await numbers.ToArrayAsync();

// Aggregation operations
int sum = await numbers.SumAsync();
int count = await numbers.CountAsync();
int max = await numbers.MaxAsync();
bool any = await numbers.AnyAsync(n => n > 5);
```

### ConfigureAwait Support

```csharp
// Use ConfigureAwait to control synchronization context
await foreach (var item in GetItemsAsync().ConfigureAwait(false))
{
    // Process without capturing context
    await ProcessAsync(item).ConfigureAwait(false);
}

// Also applies to async enumerator disposal
public async IAsyncEnumerable<int> GetNumbersAsync()
{
    // Cleanup happens with ConfigureAwait if specified during iteration
    await using var resource = await GetResourceAsync();
    
    for (int i = 0; i < 10; i++)
    {
        yield return i;
    }
}
```

## Relationships & Integration

### Relationship to IEnumerable&lt;T&gt;

`IAsyncEnumerable<T>` is the async counterpart to `IEnumerable<T>`:

```csharp
// Synchronous enumeration
IEnumerable<int> SyncNumbers()
{
    for (int i = 0; i < 5; i++)
    {
        Thread.Sleep(100); // Blocks thread
        yield return i;
    }
}

foreach (int n in SyncNumbers()) // Synchronous
{
    Console.WriteLine(n);
}

// Asynchronous enumeration
async IAsyncEnumerable<int> AsyncNumbers()
{
    for (int i = 0; i < 5; i++)
    {
        await Task.Delay(100); // Doesn't block
        yield return i;
    }
}

await foreach (int n in AsyncNumbers()) // Asynchronous
{
    Console.WriteLine(n);
}
```

### Task Integration

`IAsyncEnumerable<T>` works seamlessly with `Task` and `Task<T>`:

```csharp
// Combining Task<T> with IAsyncEnumerable<T>
public async IAsyncEnumerable<Customer> GetCustomersAsync()
{
    // Await a Task before yielding
    string[] customerIds = await FetchCustomerIdsAsync();
    
    foreach (string id in customerIds)
    {
        // Await for each element
        Customer customer = await FetchCustomerAsync(id);
        yield return customer;
    }
}

// Returns Task when consuming the entire sequence
public async Task<List<Customer>> GetAllCustomersAsync()
{
    var customers = new List<Customer>();
    
    await foreach (var customer in GetCustomersAsync())
    {
        customers.Add(customer);
    }
    
    return customers;
}
```

### JSON Serialization with System.Text.Json

System.Text.Json supports streaming JSON arrays with `IAsyncEnumerable<T>`:

```csharp
using System.Text.Json;

// Deserialize large JSON arrays as async streams
public async IAsyncEnumerable<WeatherForecast> DeserializeJsonStreamAsync(
    Stream utf8Json)
{
    await foreach (var forecast in JsonSerializer.DeserializeAsyncEnumerable<WeatherForecast>(utf8Json))
    {
        yield return forecast;
    }
}

// Serialize IAsyncEnumerable to JSON stream
public async Task SerializeToJsonAsync(
    IAsyncEnumerable<WeatherForecast> forecasts,
    Stream utf8Json)
{
    await JsonSerializer.SerializeAsync(utf8Json, forecasts);
}

// Usage with HTTP
public async Task ProcessApiResponseAsync(HttpResponseMessage response)
{
    using var stream = await response.Content.ReadAsStreamAsync();
    
    await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream))
    {
        Console.WriteLine($"Received: {item.Name}");
        await ProcessItemAsync(item);
    }
}
```

### Entity Framework Core Integration

Entity Framework Core returns `IAsyncEnumerable<T>` for streaming query results:

```csharp
using Microsoft.EntityFrameworkCore;

public async Task ProcessLargeDatasetAsync(MyDbContext context)
{
    // AsAsyncEnumerable returns IAsyncEnumerable<T>
    IAsyncEnumerable<Customer> customers = context.Customers
        .Where(c => c.IsActive)
        .AsAsyncEnumerable();
    
    await foreach (var customer in customers)
    {
        // Process one at a time without loading all into memory
        await UpdateCustomerAsync(customer);
        
        // Save changes periodically
        if (customer.Id % 100 == 0)
        {
            await context.SaveChangesAsync();
        }
    }
}
```

### ASP.NET Core Integration

ASP.NET Core supports returning `IAsyncEnumerable<T>` from API endpoints:

```csharp
[ApiController]
[Route("api/[controller]")]
public class DataController : ControllerBase
{
    // Return IAsyncEnumerable directly - ASP.NET Core streams the response
    [HttpGet("stream")]
    public async IAsyncEnumerable<WeatherForecast> GetWeatherStream(
        [EnumeratorCancellation] CancellationToken cancellationToken)
    {
        for (int i = 0; i < 100; i++)
        {
            cancellationToken.ThrowIfCancellationRequested();
            
            await Task.Delay(100, cancellationToken);
            
            yield return new WeatherForecast
            {
                Date = DateTime.Now.AddDays(i),
                TemperatureC = Random.Shared.Next(-20, 55)
            };
        }
    }
}

// Client consumption
public async Task ConsumeStreamingApiAsync(HttpClient client)
{
    var stream = await client.GetStreamAsync("api/data/stream");
    
    await foreach (var forecast in JsonSerializer.DeserializeAsyncEnumerable<WeatherForecast>(stream))
    {
        Console.WriteLine($"{forecast.Date}: {forecast.TemperatureC}°C");
    }
}
```

### Channels Integration

`System.Threading.Channels` works well with `IAsyncEnumerable<T>`:

```csharp
using System.Threading.Channels;

// Convert Channel to IAsyncEnumerable
public async IAsyncEnumerable<T> ReadAllAsync<T>(ChannelReader<T> reader)
{
    await foreach (var item in reader.ReadAllAsync())
    {
        yield return item;
    }
}

// Producer-consumer pattern
public async Task ProducerConsumerAsync()
{
    var channel = Channel.CreateUnbounded<int>();
    
    // Producer
    _ = Task.Run(async () =>
    {
        for (int i = 0; i < 100; i++)
        {
            await channel.Writer.WriteAsync(i);
            await Task.Delay(10);
        }
        channel.Writer.Complete();
    });
    
    // Consumer using IAsyncEnumerable
    await foreach (int item in channel.Reader.ReadAllAsync())
    {
        Console.WriteLine($"Consumed: {item}");
    }
}
```

## Common Scenarios

### Paginated API Consumption

**When to use**: Fetching large datasets from paginated REST APIs.

```csharp
public async IAsyncEnumerable<User> GetAllUsersAsync(
    HttpClient client,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    int page = 1;
    bool hasMore = true;
    
    while (hasMore)
    {
        var response = await client.GetFromJsonAsync<PagedResponse<User>>(
            $"/api/users?page={page}",
            cancellationToken);
        
        foreach (var user in response.Items)
        {
            yield return user;
        }
        
        hasMore = response.HasNextPage;
        page++;
    }
}

// Usage
await foreach (var user in GetAllUsersAsync(httpClient))
{
    Console.WriteLine(user.Name);
}
```

**Considerations**: Each page requires a network call. The iterator naturally handles paging logic and backpressure.

### Streaming File Processing

**When to use**: Processing large files line-by-line without loading into memory.

```csharp
public async IAsyncEnumerable<LogEntry> ParseLogFileAsync(
    string path,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    using var reader = new StreamReader(path);
    
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        cancellationToken.ThrowIfCancellationRequested();
        
        if (TryParseLogEntry(line, out var entry))
        {
            yield return entry;
        }
    }
}

// Process with filtering
await foreach (var entry in ParseLogFileAsync("app.log")
    .Where(e => e.Level == LogLevel.Error))
{
    await ReportErrorAsync(entry);
}
```

**Considerations**: File remains open during iteration. Use cancellation tokens for long-running operations.

### Database Streaming

**When to use**: Processing large database result sets without loading all rows into memory.

```csharp
public async IAsyncEnumerable<Customer> GetActiveCustomersAsync(
    MyDbContext context,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    await foreach (var customer in context.Customers
        .Where(c => c.IsActive)
        .OrderBy(c => c.Name)
        .AsAsyncEnumerable()
        .WithCancellation(cancellationToken))
    {
        yield return customer;
    }
}

// Batch processing
await foreach (var customer in GetActiveCustomersAsync(dbContext))
{
    await SendWelcomeEmailAsync(customer);
}
```

**Considerations**: Keep DbContext alive during iteration. Consider batching for better performance.

### Real-Time Data Processing

**When to use**: Processing live data feeds, event streams, or message queues.

```csharp
public async IAsyncEnumerable<StockPrice> StreamStockPricesAsync(
    string symbol,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    using var webSocket = new ClientWebSocket();
    await webSocket.ConnectAsync(new Uri($"wss://api.example.com/stocks/{symbol}"), cancellationToken);
    
    var buffer = new byte[4096];
    
    while (!cancellationToken.IsCancellationRequested)
    {
        var result = await webSocket.ReceiveAsync(buffer, cancellationToken);
        
        if (result.MessageType == WebSocketMessageType.Close)
            break;
        
        var price = ParseStockPrice(buffer, result.Count);
        yield return price;
    }
}

// Usage with filtering
await foreach (var price in StreamStockPricesAsync("MSFT")
    .Where(p => p.Change > 0))
{
    Console.WriteLine($"${price.Value} (+{price.Change})");
}
```

**Considerations**: WebSocket stays open during iteration. Implement proper cleanup and error handling.

### Async Data Transformation Pipeline

**When to use**: Building multi-stage async processing pipelines.

```csharp
public async IAsyncEnumerable<EnrichedOrder> ProcessOrdersAsync(
    IAsyncEnumerable<Order> orders,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    await foreach (var order in orders.WithCancellation(cancellationToken))
    {
        // Stage 1: Validate
        if (!await ValidateOrderAsync(order))
            continue;
        
        // Stage 2: Enrich with customer data
        var customer = await FetchCustomerAsync(order.CustomerId);
        
        // Stage 3: Calculate pricing
        var pricing = await CalculatePricingAsync(order, customer);
        
        // Stage 4: Apply discounts
        var discounts = await GetApplicableDiscountsAsync(customer);
        
        yield return new EnrichedOrder(order, customer, pricing, discounts);
    }
}

// Chain multiple pipelines
IAsyncEnumerable<Order> rawOrders = FetchOrdersAsync();
IAsyncEnumerable<EnrichedOrder> enriched = ProcessOrdersAsync(rawOrders);
IAsyncEnumerable<EnrichedOrder> filtered = enriched.Where(o => o.Total > 100);

await foreach (var order in filtered)
{
    await FulfillOrderAsync(order);
}
```

**Considerations**: Each stage can perform async operations. Consider parallel processing with `Channels` for better throughput.

### Retry and Error Handling

**When to use**: Implementing resilience patterns for async sequences.

```csharp
public async IAsyncEnumerable<T> WithRetryAsync<T>(
    IAsyncEnumerable<T> source,
    int maxRetries = 3,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    await using var enumerator = source.GetAsyncEnumerator(cancellationToken);
    
    while (true)
    {
        int retryCount = 0;
        bool hasNext = false;
        
        while (retryCount < maxRetries)
        {
            try
            {
                hasNext = await enumerator.MoveNextAsync();
                break;
            }
            catch (Exception ex) when (retryCount < maxRetries - 1)
            {
                retryCount++;
                await Task.Delay(TimeSpan.FromSeconds(Math.Pow(2, retryCount)), cancellationToken);
            }
        }
        
        if (!hasNext)
            break;
        
        yield return enumerator.Current;
    }
}

// Usage
await foreach (var item in WithRetryAsync(FetchFromUnreliableApiAsync()))
{
    await ProcessAsync(item);
}
```

**Considerations**: Retry logic adds complexity. Consider using libraries like Polly for production scenarios.

## Alternative Syntax Options

### Multiple Ways to Create IAsyncEnumerable

```csharp
// Async iterator method (most common)
public async IAsyncEnumerable<int> Method1()
{
    for (int i = 0; i < 5; i++)
    {
        await Task.Delay(10);
        yield return i;
    }
}

// Channel-based
public IAsyncEnumerable<int> Method2()
{
    var channel = Channel.CreateUnbounded<int>();
    
    Task.Run(async () =>
    {
        for (int i = 0; i < 5; i++)
        {
            await channel.Writer.WriteAsync(i);
        }
        channel.Writer.Complete();
    });
    
    return channel.Reader.ReadAllAsync();
}

// From Task<IEnumerable<T>>
public async IAsyncEnumerable<int> Method3()
{
    var items = await GetItemsAsync(); // Returns Task<List<int>>
    
    foreach (var item in items)
    {
        yield return item;
    }
}

// Wrap synchronous IEnumerable with async operations
public async IAsyncEnumerable<int> Method4(IEnumerable<int> source)
{
    foreach (var item in source)
    {
        await Task.Delay(10); // Some async work
        yield return item;
    }
}
```

### Manual Enumerator Pattern

```csharp
// Using GetAsyncEnumerator manually
public async Task ProcessManuallyAsync(IAsyncEnumerable<int> source)
{
    await using var enumerator = source.GetAsyncEnumerator();
    
    while (await enumerator.MoveNextAsync())
    {
        int current = enumerator.Current;
        Console.WriteLine(current);
    }
}

// Equivalent to await foreach
await foreach (int item in source)
{
    Console.WriteLine(item);
}
```

### Converting Between Sync and Async

```csharp
// IEnumerable<T> to IAsyncEnumerable<T>
public async IAsyncEnumerable<T> ToAsyncEnumerable<T>(IEnumerable<T> source)
{
    foreach (var item in source)
    {
        yield return item;
        await Task.Yield(); // Yield control
    }
}

// IAsyncEnumerable<T> to IEnumerable<T> (blocks - avoid if possible)
public IEnumerable<T> ToSyncEnumerable<T>(IAsyncEnumerable<T> source)
{
    await foreach (var item in source)
    {
        yield return item;
    }
}

// Better: Materialize async then enumerate sync
public async Task<IEnumerable<T>> MaterializeAsync<T>(IAsyncEnumerable<T> source)
{
    return await source.ToListAsync();
}
```

## Best Practices

### Use Cancellation Tokens

Always support cancellation in async iterators:

```csharp
// Good: Supports cancellation
public async IAsyncEnumerable<int> GetNumbersAsync(
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    for (int i = 0; i < 1000; i++)
    {
        cancellationToken.ThrowIfCancellationRequested();
        await Task.Delay(100, cancellationToken);
        yield return i;
    }
}

// Usage
var cts = new CancellationTokenSource();
await foreach (var num in GetNumbersAsync(cts.Token))
{
    if (num > 10)
        cts.Cancel();
}
```

The `[EnumeratorCancellation]` attribute automatically flows the cancellation token from `WithCancellation()`.

### Dispose Resources Properly

Use `await using` for async disposable resources:

```csharp
public async IAsyncEnumerable<string> ReadLinesAsync(string path)
{
    // await using ensures proper async disposal
    await using var reader = new StreamReader(path);
    
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        yield return line;
    }
    // StreamReader disposed asynchronously after iteration
}
```

### Consider ConfigureAwait(false) in Libraries

For library code, use `ConfigureAwait(false)` to avoid capturing context:

```csharp
public async IAsyncEnumerable<T> LibraryMethodAsync<T>(IAsyncEnumerable<T> source)
{
    await foreach (var item in source.ConfigureAwait(false))
    {
        var result = await ProcessAsync(item).ConfigureAwait(false);
        yield return result;
    }
}
```

### Avoid Buffering Unless Necessary

Don't materialize sequences unnecessarily:

```csharp
// Bad: Loses streaming benefits
public async Task ProcessAsync(IAsyncEnumerable<int> numbers)
{
    var list = await numbers.ToListAsync(); // Loads everything into memory
    
    foreach (var num in list)
    {
        Console.WriteLine(num);
    }
}

// Good: Stream through
public async Task ProcessAsync(IAsyncEnumerable<int> numbers)
{
    await foreach (var num in numbers)
    {
        Console.WriteLine(num);
    }
}
```

Only materialize when you need multiple iterations or random access.

### Use System.Linq.Async for LINQ Operations

Install the `System.Linq.Async` NuGet package for async LINQ:

```csharp
using System.Linq;

IAsyncEnumerable<int> numbers = GetNumbersAsync();

// These extension methods are from System.Linq.Async
var filtered = numbers.Where(n => n > 5);
var transformed = numbers.Select(n => n * 2);
var taken = numbers.Take(10);

int sum = await numbers.SumAsync();
int count = await numbers.CountAsync();
```

### Handle Exceptions at the Right Level

Be careful where you handle exceptions in async sequences:

```csharp
// Exception in producer propagates to consumer
public async IAsyncEnumerable<int> ProducerAsync()
{
    for (int i = 0; i < 10; i++)
    {
        if (i == 5)
            throw new InvalidOperationException("Error at 5");
        
        yield return i;
    }
}

// Consumer sees exception during iteration
try
{
    await foreach (var num in ProducerAsync())
    {
        Console.WriteLine(num); // 0, 1, 2, 3, 4, then exception
    }
}
catch (InvalidOperationException ex)
{
    Console.WriteLine($"Caught: {ex.Message}");
}
```

### Prefer IAsyncEnumerable Over Task&lt;IEnumerable&lt;T&gt;&gt; for Streaming

```csharp
// Less efficient: Loads all data before returning
public async Task<IEnumerable<Customer>> GetCustomersOldWayAsync()
{
    var customers = new List<Customer>();
    
    for (int i = 0; i < 1000; i++)
    {
        var customer = await FetchCustomerAsync(i);
        customers.Add(customer);
    }
    
    return customers; // Must wait for all 1000
}

// Better: Stream results as they arrive
public async IAsyncEnumerable<Customer> GetCustomersNewWayAsync()
{
    for (int i = 0; i < 1000; i++)
    {
        var customer = await FetchCustomerAsync(i);
        yield return customer; // Yield as soon as available
    }
}
```

## Limitations and Considerations

### No Synchronous LINQ Methods

Standard LINQ methods don't work directly on `IAsyncEnumerable<T>`:

```csharp
IAsyncEnumerable<int> numbers = GetNumbersAsync();

// These don't compile:
// var filtered = numbers.Where(n => n > 5);
// int count = numbers.Count();

// Solution: Use System.Linq.Async
var filtered = numbers.Where(n => n > 5);      // Async version
int count = await numbers.CountAsync();         // Async version

// Or materialize first (loses streaming benefits)
var list = await numbers.ToListAsync();
var filteredList = list.Where(n => n > 5);
int listCount = list.Count;
```

### Multiple Enumeration Can Be Expensive

Each enumeration re-executes the async sequence:

```csharp
IAsyncEnumerable<int> numbers = FetchFromApiAsync();

// Each of these enumerates the entire sequence
int count = await numbers.CountAsync();    // First API call
int sum = await numbers.SumAsync();        // Second API call
var list = await numbers.ToListAsync();    // Third API call

// Better: Materialize once
var materializedList = await numbers.ToListAsync();
int count = materializedList.Count;
int sum = materializedList.Sum();
```

### No Random Access or Indexing

`IAsyncEnumerable<T>` doesn't support indexing:

```csharp
IAsyncEnumerable<int> numbers = GetNumbersAsync();

// These don't exist:
// int third = numbers[2];
// int count = numbers.Count; // No property, only CountAsync() method

// Must enumerate to access elements
int third = await numbers.ElementAtAsync(2);  // Still requires enumeration
```

### State Is Not Preserved Between Enumerations

Each enumeration creates a new enumerator with fresh state:

```csharp
public async IAsyncEnumerable<int> GetNumbersAsync()
{
    int counter = 0;
    
    for (int i = 0; i < 5; i++)
    {
        Console.WriteLine($"Iteration {++counter}");
        yield return i;
    }
}

var numbers = GetNumbersAsync();

await foreach (var n in numbers) { } // Prints "Iteration 1" through "Iteration 5"
await foreach (var n in numbers) { } // Prints "Iteration 1" through "Iteration 5" again
```

### Requires C# 8.0 and .NET Core 3.0+

`IAsyncEnumerable<T>` is not available in older framework versions:

```csharp
// Requires:
// - C# 8.0 or later
// - .NET Core 3.0+ or .NET 5+
// - .NET Standard 2.1+

// Not available in:
// - .NET Framework
// - .NET Standard 2.0
```

### Deferred Execution Can Cause Unexpected Behavior

Like `IEnumerable<T>`, deferred execution can lead to surprises:

```csharp
var list = new List<int> { 1, 2, 3 };

async IAsyncEnumerable<int> GetNumbers()
{
    foreach (var num in list)
    {
        yield return num;
    }
}

var query = GetNumbers();

list.Add(4); // Modify source

await foreach (var n in query)
{
    Console.WriteLine(n); // 1, 2, 3, 4 - sees the modification
}
```

### Exception Handling Can Be Complex

Exceptions during iteration can occur at unexpected times:

```csharp
public async IAsyncEnumerable<int> ProduceAsync()
{
    yield return 1;
    yield return 2;
    await Task.Delay(100);
    throw new Exception("Error after delay");
}

// Exception doesn't occur until enumeration reaches it
var sequence = ProduceAsync(); // No exception yet

await foreach (var num in sequence)
{
    Console.WriteLine(num); // 1, 2, then exception during next MoveNextAsync
}
```

### Memory Implications with Operators

Some async LINQ operators must buffer elements:

```csharp
IAsyncEnumerable<int> numbers = GetLargeDatasetAsync();

// Streaming operators (process one at a time)
var filtered = numbers.Where(n => n > 5);      // Streaming
var transformed = numbers.Select(n => n * 2);  // Streaming

// Buffering operators (must hold elements in memory)
var ordered = numbers.OrderByAsync(n => n);    // Buffers all elements
var reversed = numbers.ReverseAsync();         // Buffers all elements
var distinct = numbers.DistinctAsync();        // Buffers to track uniqueness
```

### Thread Safety Concerns

`IAsyncEnumerable<T>` provides no inherent thread safety:

```csharp
var numbers = GetNumbersAsync();

// Problematic: Multiple concurrent iterations
var task1 = Task.Run(async () =>
{
    await foreach (var n in numbers) { }
});

var task2 = Task.Run(async () =>
{
    await foreach (var n in numbers) { }
});

await Task.WhenAll(task1, task2);
```

Each enumeration should happen on a single consumer. For multiple consumers, use `Channels` or materialize and share the data.

## See Also

- **IEnumerable&lt;T&gt;**: Synchronous enumeration foundation
- **Task and Task&lt;T&gt;**: Async programming primitives that IAsyncEnumerable builds upon
- **System.Linq.Async**: NuGet package providing async LINQ operators
- **System.Threading.Channels**: Producer-consumer patterns for async streams
- **yield return**: C# keyword for creating iterator methods
- **Entity Framework Core**: Database queries with AsAsyncEnumerable
- **System.Text.Json**: JSON streaming with JsonSerializer.DeserializeAsyncEnumerable
- **ASP.NET Core**: Returning IAsyncEnumerable from API endpoints
- **CancellationToken**: Cancellation support for long-running operations
