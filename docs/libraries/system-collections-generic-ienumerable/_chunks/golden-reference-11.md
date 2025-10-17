# IEnumerable and IEnumerable&lt;T&gt;
## Limitations and Considerations
### No Count Property

`IEnumerable<T>` doesn't have a Count property, only a Count() method that requires enumeration:

```csharp
IEnumerable<int> numbers = GetNumbers();

// This enumerates the entire sequence
int count = numbers.Count();

// More efficient if you have a collection
if (numbers is ICollection<int> collection)
{
    int count = collection.Count; // O(1)
}

// Or materialize if you need the count
List<int> list = numbers.ToList();
int count = list.Count; // O(1)
```

### Thread Safety

`IEnumerable<T>` provides no thread-safety guarantees. Concurrent enumeration or modification can cause errors:

```csharp
var list = new List<int> { 1, 2, 3, 4, 5 };

// Problematic: Modifying while enumerating
foreach (int num in list)
{
    if (num == 3)
    {
        list.Add(6); // Throws InvalidOperationException
    }
}

// Problematic: Concurrent enumeration
Parallel.ForEach(list, num =>
{
    list.Add(num * 2); // Race condition
});
```

Use thread-safe collections like `ConcurrentBag<T>` or synchronization for concurrent scenarios.

### Lazy Evaluation and Side Effects

Side effects in LINQ chains can execute multiple times or not at all:

```csharp
int callCount = 0;

IEnumerable<int> numbers = Enumerable.Range(1, 5)
    .Select(n =>
    {
        callCount++;
        Console.WriteLine($"Processing {n}");
        return n * 2;
    });

// Nothing happens yet - no enumeration
Console.WriteLine($"Calls so far: {callCount}"); // 0

// Enumeration triggers execution
var list = numbers.ToList();
Console.WriteLine($"Calls after ToList: {callCount}"); // 5

// Enumerating again re-executes
var array = numbers.ToArray();
Console.WriteLine($"Calls after ToArray: {callCount}"); // 10
```

Avoid side effects in LINQ operations. Use foreach for operations with side effects.
