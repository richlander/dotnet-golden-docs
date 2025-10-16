# Collections Performance

## Overview

Collections performance in .NET encompasses both runtime-delivered optimizations and code patterns that enable efficient use of arrays, lists, and other collection types. The .NET runtime has continuously evolved to make collection operations faster through techniques like stack allocation, devirtualization, and improved code generation. The runtime combines automatic optimizations with developer-accessible patterns to achieve high performance.

Key performance capabilities include:

- **Automatic stack allocation**: Small arrays that don't escape their method are allocated on the stack, eliminating heap allocations and GC pressure
- **Array interface devirtualization**: Arrays accessed through interfaces like `IEnumerable<T>` perform as efficiently as direct array access
- **Improved enumeration**: Array enumeration through interfaces achieves performance parity with concrete type iteration
- **Insertion-order collections**: `OrderedDictionary<TKey, TValue>` provides fast indexed access while maintaining insertion order

These optimizations are particularly valuable when:

1. Working with small, temporary collections in hot code paths
2. Using LINQ or foreach with arrays through abstraction boundaries
3. Needing both dictionary semantics and predictable iteration order
4. Processing collections in performance-critical scenarios

## Automatic Stack Allocation for Small Arrays

The runtime automatically stack-allocates small arrays that don't escape their method scope:

```csharp
// Small arrays are stack allocated when they don't escape
static int CalculateSum()
{
    int[] numbers = { 1, 2, 3, 4, 5 };  // Stack allocated
    int sum = 0;
    
    foreach (int num in numbers)
    {
        sum += num;
    }
    
    return sum;
}

// Also works for reference type arrays
static void PrintMessages()
{
    string[] messages = { "Hello", "World", "!" };  // Stack allocated
    
    foreach (string msg in messages)
    {
        Console.WriteLine(msg);
    }
}
```

These arrays are allocated on the stack automatically because the compiler can prove they don't escape the method. No heap allocation or garbage collection is required.

**Note**: Stack allocation for value type arrays has been available in earlier .NET versions, while reference type arrays gained this optimization in .NET 10.

## Array Interface Performance Parity

Arrays accessed through interfaces have the same performance as direct array access due to devirtualization:

```csharp
// Both approaches have equivalent performance
static int SumDirect(int[] array)
{
    int sum = 0;
    for (int i = 0; i < array.Length; i++)
    {
        sum += array[i];
    }
    return sum;
}

static int SumViaInterface(int[] array)
{
    int sum = 0;
    IEnumerable<int> enumerable = array;  // No performance penalty
    
    foreach (int num in enumerable)
    {
        sum += num;
    }
    
    return sum;
}
```

The JIT devirtualizes the interface calls and applies the same optimizations (inlining, bounds check elimination, vectorization) to both versions.

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

## Understanding Stack Allocation

The runtime stack-allocates arrays when escape analysis proves they don't leave the method:

```csharp
// Stack allocated - doesn't escape
static void ProcessLocally()
{
    int[] data = { 1, 2, 3 };
    int sum = data.Sum();  // Inlined, array stays local
    Console.WriteLine(sum);
}

// Heap allocated - escapes via return
static int[] CreateArray()
{
    return new int[] { 1, 2, 3 };  // Must be heap allocated
}

// Heap allocated - escapes via assignment to field
class Container
{
    private int[] _data;
    
    void Initialize()
    {
        _data = new int[] { 1, 2, 3 };  // Escapes to field
    }
}

// Stack allocated - captured by struct, doesn't escape
static void ProcessWithStruct()
{
    int[] numbers = { 1, 2, 3 };
    
    var processor = new ArrayProcessor { Data = numbers };
    processor.Process();  // If ArrayProcessor is a struct and doesn't escape
}
```

### Escape Analysis for Struct Fields

The JIT tracks references through struct fields to enable more stack allocations:

```csharp
struct Container
{
    public int[] Numbers;
}

static void Process()
{
    int[] data = { 1, 2, 3, 4, 5 };  // Stack allocated
    var container = new Container { Numbers = data };
    
    // container doesn't escape, so data doesn't escape
    int sum = container.Numbers.Sum();
    Console.WriteLine(sum);
}
```

## High-Performance Collection Patterns

### Small Temporary Collections

For small, temporary collections in hot paths, prefer array initialization:

```csharp
// Efficient - stack allocated when small and local
public bool IsValidExtension(string ext)
{
    string[] validExtensions = { ".txt", ".md", ".doc" };
    return validExtensions.Contains(ext);
}

// Alternative using collection expressions (C# 12)
public bool IsValidExtension(string ext)
{
    ReadOnlySpan<string> validExtensions = [".txt", ".md", ".doc"];
    return validExtensions.Contains(ext);
}
```

### Ordered Configuration with Fast Lookups

Use `OrderedDictionary` when you need both fast lookups and predictable iteration order:

```csharp
// Maintains insertion order for display while allowing fast key lookup
public class AppSettings
{
    private readonly OrderedDictionary<string, string> _settings = new();
    
    public void Load(IEnumerable<KeyValuePair<string, string>> entries)
    {
        foreach (var entry in entries)
        {
            _settings[entry.Key] = entry.Value;
        }
    }
    
    public string GetSetting(string key) => _settings[key];
    
    public void DisplaySettings()
    {
        // Displays in insertion/modification order
        for (int i = 0; i < _settings.Count; i++)
        {
            var kvp = _settings.GetAt(i);
            Console.WriteLine($"{kvp.Key} = {kvp.Value}");
        }
    }
}
```

### Efficient Updates with Index Caching

Cache indices for repeated updates to `OrderedDictionary`:

```csharp
var metrics = new OrderedDictionary<string, int>();

// Add with index tracking
if (metrics.TryAdd("requests", 0, out int requestsIndex))
{
    // Cache the index for fast updates
    for (int i = 0; i < 1000; i++)
    {
        int current = metrics.GetAt(requestsIndex).Value;
        metrics.SetAt(requestsIndex, current + 1);  // O(1) update
    }
}
```

## Array Enumeration Performance

### Direct vs. Interface Enumeration

Both patterns perform equivalently with devirtualization:

```csharp
static void ProcessArray(int[] data)
{
    // Direct enumeration
    foreach (int value in data)
    {
        Process(value);
    }
}

static void ProcessEnumerable(IEnumerable<int> data)
{
    // Interface enumeration - same performance when data is an array
    foreach (int value in data)
    {
        Process(value);
    }
}

// Both calls are equally efficient
int[] numbers = { 1, 2, 3, 4, 5 };
ProcessArray(numbers);
ProcessEnumerable(numbers);  // No virtualization overhead
```

### LINQ Performance on Arrays

LINQ queries on arrays benefit from devirtualization:

```csharp
int[] numbers = Enumerable.Range(1, 100).ToArray();

// Efficient - JIT devirtualizes and optimizes
var evenNumbers = numbers.Where(n => n % 2 == 0).ToArray();

// Also efficient - no abstraction penalty
IEnumerable<int> enumerable = numbers;
var squares = enumerable.Select(n => n * n).ToArray();
```

## Performance Characteristics

### Stack Allocation

- **Benefit**: Eliminates heap allocation and GC pressure
- **Applies to**: Small arrays (typically < 100 elements) that don't escape
- **Types**: Both value types and reference types (reference types store references on stack)
- **Automatic**: No code changes required, runtime optimization

### Array Interface Devirtualization

- **Benefit**: Eliminates virtual call overhead (typically 5-10ns per call)
- **Applies to**: Arrays accessed through IEnumerable<T> and related interfaces
- **Enables**: Inlining, bounds check elimination, SIMD vectorization
- **Automatic**: JIT optimization, no code changes required

### OrderedDictionary Performance

- **Key lookup**: O(1) hash-based access
- **Index access**: O(1) direct indexing with GetAt/SetAt
- **Iteration**: Linear, in insertion order
- **Memory**: Comparable to `Dictionary<TKey, TValue>` with small additional overhead for ordering

## Best Practices

1. **Let the runtime optimize**: Write natural code with small arrays; the runtime will stack-allocate when beneficial
2. **Use interfaces for abstraction**: Don't avoid `IEnumerable<T>` for performance; array interface devirtualization eliminates overhead
3. **Prefer `OrderedDictionary` for ordered key-value data**: When you need both dictionary semantics and predictable iteration order
4. **Cache indices for repeated updates**: Use TryAdd/TryGetValue overloads that return index for frequent updates
5. **Keep escape scope minimal**: Arrays that don't escape the method are candidates for stack allocation

## Migration & Compatibility

### Adopting OrderedDictionary

Migrating from `Dictionary` where order matters:

```csharp
// Before: Dictionary with separate ordering mechanism
private Dictionary<string, string> _config = new();
private List<string> _keyOrder = new();

public void Add(string key, string value)
{
    _config[key] = value;
    if (!_keyOrder.Contains(key))
    {
        _keyOrder.Add(key);
    }
}

// After: OrderedDictionary handles ordering automatically
private OrderedDictionary<string, string> _config = new();

public void Add(string key, string value)
{
    _config[key] = value;  // Maintains insertion order automatically
}
```

### Leveraging Automatic Optimizations

No code changes needed to benefit from runtime improvements:

```csharp
// This code gets faster as the runtime evolves
public void ProcessData()
{
    string[] messages = { "Error", "Warning", "Info" };  // May be stack allocated
    
    IEnumerable<string> enumerable = messages;
    foreach (var msg in enumerable)  // Devirtualized when possible
    {
        Console.WriteLine(msg);
    }
}
```

**Version requirements**:
- Stack allocation for value type arrays: Available in earlier .NET versions
- Stack allocation for reference type arrays: .NET 10+
- Array interface devirtualization: .NET 10+
- `OrderedDictionary<TKey, TValue>`: .NET 9+
- `OrderedDictionary` index-returning overloads: .NET 10+
- Collection expressions: C# 12 (.NET 8+)

## Related Topics

- **`Span<T>` and `Memory<T>`**: For advanced zero-allocation scenarios
- **Collection expressions (C# 12)**: Concise syntax for collection initialization
- **LINQ**: Query operators that benefit from array interface devirtualization
- **Inline arrays (C# 12)**: Fixed-size arrays in structs
- **`SearchValues<T>`**: For high-performance searching in collections
