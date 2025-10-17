# IAsyncEnumerable&lt;T&gt;
## Limitations and Considerations
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
