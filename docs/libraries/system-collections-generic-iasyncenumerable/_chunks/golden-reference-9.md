# IAsyncEnumerable&lt;T&gt;
## Best Practices
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
