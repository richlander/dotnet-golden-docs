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
