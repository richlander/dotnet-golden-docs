# IAsyncEnumerable&lt;T&gt;
## Limitations and Considerations
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
