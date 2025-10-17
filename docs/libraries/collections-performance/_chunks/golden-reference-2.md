# Collections Performance
## OrderedDictionary with Index Access

`OrderedDictionary<TKey, TValue>` combines dictionary semantics with fast indexed access:

```csharp
using System.Collections.Generic;

// Create an ordered dictionary
var settings = new OrderedDictionary<string, string>
{
    { "Host", "localhost" },
    { "Port", "8080" },
    { "Timeout", "30" }
};

// Access by key (O(1) hash lookup)
string host = settings["Host"];

// Access by index (O(1) indexed access)
KeyValuePair<string, string> firstSetting = settings.GetAt(0);
Console.WriteLine($"{firstSetting.Key}: {firstSetting.Value}");

// Iterate in insertion order
foreach (var kvp in settings)
{
    Console.WriteLine($"{kvp.Key} = {kvp.Value}");
}
```

## TryAdd and TryGetValue with Index

Overloads return the index for subsequent operations:

```csharp
var cache = new OrderedDictionary<string, object>();

// TryAdd returns the index where the item was added or found
if (cache.TryAdd("key1", "value1", out int index))
{
    Console.WriteLine($"Added at index {index}");
}
else
{
    // Key already exists, index points to existing entry
    var existing = cache.GetAt(index);
    Console.WriteLine($"Existing value at index {index}: {existing.Value}");
}

// TryGetValue also returns the index
if (cache.TryGetValue("key1", out object? value, out int foundIndex))
{
    // Use index for fast subsequent access
    cache.SetAt(foundIndex, "updated-value");
}
```

## Relationships & Integration

Collections performance relates to and integrates with several .NET features:

- **`Span<T>` and `Memory<T>`**: Stack allocation works seamlessly with span-based APIs for zero-allocation processing
- **LINQ**: Array interface devirtualization enables LINQ queries on arrays without abstraction overhead
- **Collection expressions (C# 12)**: Concise syntax that works efficiently with runtime optimizations
- **Inline arrays (C# 12)**: For fixed-size arrays in structs with array-like syntax
- **`IEnumerable<T>`**: Interface-based enumeration now performs as well as direct array access

Collections performance improvements enable these patterns to work efficiently:

```csharp
// Collection expressions with efficient array allocation
int[] squares = [1, 4, 9, 16, 25];  // Stack allocated for small arrays

// LINQ on arrays - no performance penalty
int[] numbers = { 1, 2, 3, 4, 5 };
IEnumerable<int> evenNumbers = numbers.Where(n => n % 2 == 0);  // Efficient enumeration

// OrderedDictionary with LINQ
var config = new OrderedDictionary<string, int>
{
    { "MaxConnections", 100 },
    { "Timeout", 30 },
    { "RetryCount", 3 }
};

var highValues = config.Where(kvp => kvp.Value > 50);  // Efficient iteration
```
