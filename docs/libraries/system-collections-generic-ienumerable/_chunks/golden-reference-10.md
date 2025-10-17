# IEnumerable and IEnumerable&lt;T&gt;
## Limitations and Considerations

### Deferred Execution Can Be Surprising

LINQ operations on `IEnumerable<T>` use deferred execution, which can lead to unexpected behavior:

```csharp
var numbers = new List<int> { 1, 2, 3 };

var query = numbers.Where(n => n > 1);

numbers.Add(4); // Modify source

// Query executes now and sees the modification
foreach (int n in query)
{
    Console.WriteLine(n); // 2, 3, 4
}
```

If you need a snapshot of data at a specific point in time, materialize with `.ToList()` or `.ToArray()`.

### Multiple Enumeration Cost

Each enumeration of `IEnumerable<T>` can re-execute the entire chain:

```csharp
IEnumerable<int> expensiveQuery = database
    .GetRecords()
    .Where(r => ComplexFilter(r))
    .Select(r => ExpensiveTransform(r));

// Each of these operations enumerates the entire chain
int count = expensiveQuery.Count();           // Full execution
int sum = expensiveQuery.Sum();               // Full execution again
var list = expensiveQuery.ToList();           // Full execution again
```

For expensive operations that need multiple enumerations, materialize once.

### No Random Access

`IEnumerable<T>` doesn't support indexing or random access:

```csharp
IEnumerable<int> numbers = GetNumbers();

// These don't compile:
// int third = numbers[2];
// int count = numbers.Count; // Count is a method, not a property

// Need to enumerate to access elements
int third = numbers.ElementAt(2);     // O(n) operation
int count = numbers.Count();          // O(n) operation
```

If you need indexing, use `IList<T>`, `IReadOnlyList<T>`, or materialize to an array/list.
