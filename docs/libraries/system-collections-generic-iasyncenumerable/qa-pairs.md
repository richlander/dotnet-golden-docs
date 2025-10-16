# IAsyncEnumerable&lt;T&gt; -- Q&A

## Basic Concepts

---
difficulty: "beginner"
validation: "manual-review"
topics: ["iasyncenumerable", "async", "iteration"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: What is IAsyncEnumerable<T>?
A: `IAsyncEnumerable<T>` is an interface representing an asynchronous sequence of elements that can be enumerated using `await foreach`. It enables non-blocking iteration over async data sources like network streams, database queries, or paginated APIs without blocking threads.

```csharp
await foreach (var item in GetItemsAsync())
{
    Console.WriteLine(item);
}
```

------

---
difficulty: "beginner"
validation: "manual-review"
topics: ["iasyncenumerable", "ienumerable", "async"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: What's the difference between IEnumerable<T> and IAsyncEnumerable<T>?
Q: When should I use IAsyncEnumerable instead of IEnumerable?
A: `IEnumerable<T>` is for synchronous iteration with `foreach`, while `IAsyncEnumerable<T>` is for asynchronous iteration with `await foreach`. Use `IAsyncEnumerable<T>` when retrieving elements involves async operations (I/O, network calls) to avoid blocking threads.

```csharp
// Synchronous - blocks thread
IEnumerable<int> SyncNumbers()
{
    for (int i = 0; i < 5; i++)
    {
        Thread.Sleep(100); // Blocks
        yield return i;
    }
}

// Asynchronous - doesn't block
async IAsyncEnumerable<int> AsyncNumbers()
{
    for (int i = 0; i < 5; i++)
    {
        await Task.Delay(100); // Doesn't block
        yield return i;
    }
}
```

------

---
difficulty: "beginner"
validation: "code-compiles"
topics: ["iasyncenumerable", "await-foreach", "iteration"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I iterate over an IAsyncEnumerable?
Q: How do I use await foreach?
A: Use `await foreach` to asynchronously iterate over the sequence:

```csharp
IAsyncEnumerable<string> items = GetItemsAsync();

await foreach (string item in items)
{
    Console.WriteLine(item);
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "creation", "yield"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I create an IAsyncEnumerable with yield return?
Q: How do I implement an async iterator method?
A: Use `async` and `yield return` in a method returning `IAsyncEnumerable<T>`:

```csharp
public async IAsyncEnumerable<int> GetNumbersAsync(int count)
{
    for (int i = 0; i < count; i++)
    {
        await Task.Delay(100); // Async operation
        yield return i;
    }
}

await foreach (var num in GetNumbersAsync(5))
{
    Console.WriteLine(num);
}
```

------

## Async Operations

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "cancellation", "cancellationtoken"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I add cancellation support to IAsyncEnumerable?
Q: How do I use CancellationToken with IAsyncEnumerable?
A: Use the `[EnumeratorCancellation]` attribute on the cancellation token parameter:

```csharp
using System.Runtime.CompilerServices;

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

// Usage
var cts = new CancellationTokenSource(TimeSpan.FromSeconds(5));
await foreach (var num in GetNumbersAsync(100, cts.Token))
{
    Console.WriteLine(num);
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "materialization", "tolist"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I convert IAsyncEnumerable to a List?
Q: How do I materialize an IAsyncEnumerable?
A: Use `ToListAsync()` from the System.Linq.Async package:

```csharp
using System.Linq;

IAsyncEnumerable<int> numbers = GetNumbersAsync();

// Requires System.Linq.Async NuGet package
List<int> list = await numbers.ToListAsync();

// Also available: ToArrayAsync()
int[] array = await numbers.ToArrayAsync();
```

------

---
difficulty: "beginner"
validation: "code-compiles"
topics: ["iasyncenumerable", "file-io", "streaming"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I read a file line-by-line asynchronously with IAsyncEnumerable?
A: Create an async iterator that reads lines asynchronously:

```csharp
public async IAsyncEnumerable<string> ReadLinesAsync(string path)
{
    using var reader = new StreamReader(path);
    
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        yield return line;
    }
}

// Usage
await foreach (var line in ReadLinesAsync("file.txt"))
{
    Console.WriteLine(line);
}
```

------

## LINQ and Filtering

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "linq", "filtering"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I filter an IAsyncEnumerable with Where?
Q: Does LINQ work with IAsyncEnumerable?
A: Install the System.Linq.Async NuGet package for async LINQ operators:

```csharp
using System.Linq;

IAsyncEnumerable<int> numbers = GetNumbersAsync();

// Where, Select, Take etc. from System.Linq.Async
IAsyncEnumerable<int> evenNumbers = numbers.Where(n => n % 2 == 0);

await foreach (var num in evenNumbers)
{
    Console.WriteLine(num);
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "linq", "chaining"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I chain LINQ operations on IAsyncEnumerable?
A: Chain async LINQ extension methods just like synchronous LINQ:

```csharp
using System.Linq;

IAsyncEnumerable<int> numbers = GetNumbersAsync();

IAsyncEnumerable<string> result = numbers
    .Where(n => n > 5)
    .Select(n => n * 2)
    .Take(10)
    .Select(n => $"Value: {n}");

await foreach (var item in result)
{
    Console.WriteLine(item);
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "linq", "aggregation"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I count elements in an IAsyncEnumerable?
Q: How do I sum an IAsyncEnumerable?
A: Use async aggregation methods from System.Linq.Async:

```csharp
using System.Linq;

IAsyncEnumerable<int> numbers = GetNumbersAsync();

int count = await numbers.CountAsync();
int sum = await numbers.SumAsync();
int max = await numbers.MaxAsync();
double average = await numbers.AverageAsync();
bool any = await numbers.AnyAsync(n => n > 10);
```

------

## JSON Integration

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "json", "serialization", "system-text-json"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I deserialize JSON as IAsyncEnumerable?
Q: How do I stream JSON arrays with System.Text.Json?
A: Use `JsonSerializer.DeserializeAsyncEnumerable()` to stream large JSON arrays:

```csharp
using System.Text.Json;

public async Task ProcessJsonStreamAsync(Stream jsonStream)
{
    await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<DataItem>(jsonStream))
    {
        Console.WriteLine($"Processing: {item.Name}");
        await ProcessItemAsync(item);
    }
}

// From HTTP response
using var response = await httpClient.GetAsync("api/data");
using var stream = await response.Content.ReadAsStreamAsync();

await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<Product>(stream))
{
    Console.WriteLine(item.Name);
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "json", "serialization"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I serialize IAsyncEnumerable to JSON?
A: Use `JsonSerializer.SerializeAsync()` which accepts `IAsyncEnumerable<T>`:

```csharp
using System.Text.Json;

IAsyncEnumerable<Product> products = GetProductsAsync();

using var stream = new FileStream("products.json", FileMode.Create);
await JsonSerializer.SerializeAsync(stream, products);
```

------

## Common Scenarios

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "pagination", "api"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I fetch all pages from a paginated API with IAsyncEnumerable?
A: Create an async iterator that handles pagination automatically:

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

// Usage - abstracts away pagination
await foreach (var user in GetAllUsersAsync(httpClient))
{
    Console.WriteLine(user.Name);
}
```

------

---
difficulty: "advanced"
validation: "code-compiles"
topics: ["iasyncenumerable", "pipeline", "transformation"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I build an async data transformation pipeline with IAsyncEnumerable?
A: Chain async operations in an iterator method:

```csharp
public async IAsyncEnumerable<ProcessedData> BuildPipelineAsync(
    IAsyncEnumerable<RawData> source)
{
    await foreach (var raw in source)
    {
        // Each stage can be async
        var validated = await ValidateAsync(raw);
        if (validated == null) continue;
        
        var enriched = await EnrichAsync(validated);
        var transformed = await TransformAsync(enriched);
        
        yield return transformed;
    }
}

// Chain pipelines
IAsyncEnumerable<RawData> raw = FetchDataAsync();
IAsyncEnumerable<ProcessedData> processed = BuildPipelineAsync(raw);
IAsyncEnumerable<ProcessedData> filtered = processed.Where(p => p.IsValid);

await foreach (var item in filtered)
{
    await SaveAsync(item);
}
```

------

## Entity Framework Integration

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "entity-framework", "database"]
audience: ["backend-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I use IAsyncEnumerable with Entity Framework Core?
Q: How do I stream database results with EF Core?
A: Use `AsAsyncEnumerable()` to stream query results:

```csharp
using Microsoft.EntityFrameworkCore;

public async Task ProcessCustomersAsync(MyDbContext context)
{
    IAsyncEnumerable<Customer> customers = context.Customers
        .Where(c => c.IsActive)
        .AsAsyncEnumerable();
    
    await foreach (var customer in customers)
    {
        await ProcessCustomerAsync(customer);
        
        // Save periodically
        if (customer.Id % 100 == 0)
        {
            await context.SaveChangesAsync();
        }
    }
}
```

------

## ASP.NET Core Integration

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "aspnet-core", "api"]
audience: ["backend-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I return IAsyncEnumerable from an ASP.NET Core API endpoint?
Q: Can I stream data from an ASP.NET Core controller?
A: Return `IAsyncEnumerable<T>` directly from a controller action:

```csharp
[ApiController]
[Route("api/[controller]")]
public class DataController : ControllerBase
{
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
```

ASP.NET Core automatically streams the response as JSON.

------

## Advanced Usage

---
difficulty: "advanced"
validation: "code-compiles"
topics: ["iasyncenumerable", "channels", "producer-consumer"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I use IAsyncEnumerable with Channels?
A: Channels provide `ReadAllAsync()` which returns `IAsyncEnumerable<T>`:

```csharp
using System.Threading.Channels;

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
```

------

---
difficulty: "advanced"
validation: "code-compiles"
topics: ["iasyncenumerable", "configureawait"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I use ConfigureAwait with IAsyncEnumerable?
A: Call `ConfigureAwait(false)` on the async enumerable:

```csharp
// In library code, avoid capturing synchronization context
await foreach (var item in GetItemsAsync().ConfigureAwait(false))
{
    await ProcessAsync(item).ConfigureAwait(false);
}
```

------

---
difficulty: "advanced"
validation: "code-compiles"
topics: ["iasyncenumerable", "manual-enumeration"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I manually enumerate an IAsyncEnumerable?
Q: How do I use GetAsyncEnumerator?
A: Use `GetAsyncEnumerator()` for manual control:

```csharp
await using var enumerator = source.GetAsyncEnumerator();

while (await enumerator.MoveNextAsync())
{
    var current = enumerator.Current;
    Console.WriteLine(current);
}

// Equivalent to:
await foreach (var item in source)
{
    Console.WriteLine(item);
}
```

------

## Performance and Best Practices

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["iasyncenumerable", "performance", "best-practices"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: When should I use IAsyncEnumerable instead of Task<List<T>>?
A: Use `IAsyncEnumerable<T>` when you want to stream results as they become available. Use `Task<List<T>>` when you need all data before processing or need multiple iterations.

```csharp
// IAsyncEnumerable - streams results, memory efficient
public async IAsyncEnumerable<Customer> GetCustomersStreamingAsync()
{
    for (int i = 0; i < 1000; i++)
    {
        yield return await FetchCustomerAsync(i); // Yield as available
    }
}

// Task<List<T>> - waits for all data, supports multiple iterations
public async Task<List<Customer>> GetAllCustomersAsync()
{
    var customers = new List<Customer>();
    for (int i = 0; i < 1000; i++)
    {
        customers.Add(await FetchCustomerAsync(i));
    }
    return customers; // Returns all at once
}
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["iasyncenumerable", "disposal", "resources"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I properly dispose resources in IAsyncEnumerable?
A: Use `await using` for async disposable resources:

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
    // Disposed asynchronously after iteration completes
}
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["iasyncenumerable", "multiple-enumeration", "performance"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Can I enumerate an IAsyncEnumerable multiple times?
A: Yes, but each enumeration re-executes the entire sequence. For expensive operations, materialize once:

```csharp
IAsyncEnumerable<int> numbers = FetchFromApiAsync();

// Each enumeration makes new API calls
int count = await numbers.CountAsync();  // API call
int sum = await numbers.SumAsync();      // Another API call

// Better: Materialize once
var list = await numbers.ToListAsync();  // One API call
int count = list.Count;
int sum = list.Sum();
```

------

## Troubleshooting

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["iasyncenumerable", "troubleshooting", "exceptions"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Why is my IAsyncEnumerable not executing?
Q: Why doesn't my async iterator run?
A: Like `IEnumerable<T>`, `IAsyncEnumerable<T>` uses deferred execution. It doesn't execute until enumerated:

```csharp
// Creates the sequence but doesn't execute
var numbers = GetNumbersAsync();

// Execution happens here during enumeration
await foreach (var num in numbers)
{
    Console.WriteLine(num);
}

// Or when materializing
var list = await numbers.ToListAsync();
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["iasyncenumerable", "troubleshooting", "linq"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Why don't standard LINQ methods work on IAsyncEnumerable?
A: Standard LINQ is for `IEnumerable<T>`. Install the `System.Linq.Async` NuGet package for async LINQ:

```bash
dotnet add package System.Linq.Async
```

```csharp
using System.Linq; // Import the async LINQ extensions

IAsyncEnumerable<int> numbers = GetNumbersAsync();

// Now these work
var filtered = numbers.Where(n => n > 5);
int count = await numbers.CountAsync();
```

------

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["iasyncenumerable", "troubleshooting", "task"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I convert Task<IEnumerable<T>> to IAsyncEnumerable<T>?
A: Await the task, then yield the elements:

```csharp
public async IAsyncEnumerable<T> ConvertAsync<T>(Task<IEnumerable<T>> task)
{
    var items = await task;
    
    foreach (var item in items)
    {
        yield return item;
    }
}

// Usage
Task<List<int>> numbersTask = GetNumbersAsync();
IAsyncEnumerable<int> asyncEnumerable = ConvertAsync(numbersTask);
```

------

---
difficulty: "advanced"
validation: "manual-review"
topics: ["iasyncenumerable", "troubleshooting", "exceptions"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: When do exceptions occur in IAsyncEnumerable?
A: Exceptions occur during enumeration, not when creating the sequence:

```csharp
public async IAsyncEnumerable<int> ProduceAsync()
{
    yield return 1;
    yield return 2;
    await Task.Delay(100);
    throw new Exception("Error after delay");
}

var sequence = ProduceAsync(); // No exception yet

try
{
    await foreach (var num in sequence)
    {
        Console.WriteLine(num); // 1, 2, then exception
    }
}
catch (Exception ex)
{
    Console.WriteLine($"Caught: {ex.Message}");
}
```

------

## Comparison and Migration

---
difficulty: "intermediate"
validation: "manual-review"
topics: ["iasyncenumerable", "ienumerable", "comparison"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: Should I always use IAsyncEnumerable instead of IEnumerable?
A: No. Use `IAsyncEnumerable<T>` only when operations are I/O-bound. For CPU-bound or in-memory operations, `IEnumerable<T>` is simpler and more efficient:

```csharp
// Use IEnumerable for in-memory data
IEnumerable<int> numbers = list.Where(n => n > 5);

// Use IAsyncEnumerable for I/O operations
async IAsyncEnumerable<Customer> GetCustomersAsync()
{
    await foreach (var id in GetCustomerIdsAsync())
    {
        yield return await httpClient.GetFromJsonAsync<Customer>($"/api/customers/{id}");
    }
}
```

------

---
difficulty: "intermediate"
validation: "code-compiles"
topics: ["iasyncenumerable", "ienumerable", "conversion"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2025-10-14"
---
Q: How do I convert IEnumerable<T> to IAsyncEnumerable<T>?
A: Wrap it in an async iterator:

```csharp
public async IAsyncEnumerable<T> ToAsyncEnumerable<T>(IEnumerable<T> source)
{
    foreach (var item in source)
    {
        yield return item;
        await Task.Yield(); // Yield control
    }
}

// Usage
IEnumerable<int> syncNumbers = new[] { 1, 2, 3 };
IAsyncEnumerable<int> asyncNumbers = ToAsyncEnumerable(syncNumbers);
```

------
