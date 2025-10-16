# IEnumerable and IEnumerable&lt;T&gt;

## Overview

`IEnumerable<T>` is the foundation of LINQ and iteration in .NET, representing any sequence of elements that can be enumerated one at a time. This interface enables foreach loops, LINQ queries, and a consistent approach to working with collections, streams, and computed sequences.

The non-generic `IEnumerable` interface serves the same purpose for untyped collections and maintains compatibility with legacy code. Modern .NET code typically uses the generic `IEnumerable<T>` for type safety and better performance.

```csharp
// IEnumerable<T> enables iteration over sequences
IEnumerable<int> numbers = new[] { 1, 2, 3, 4, 5 };
foreach (int num in numbers)
{
    Console.WriteLine(num);
}

// LINQ operations work on IEnumerable<T>
IEnumerable<int> evenNumbers = numbers.Where(n => n % 2 == 0);
```

### Key Advantages

- **LINQ integration**: Enables all LINQ query operations (Where, Select, OrderBy, etc.)
- **Deferred execution**: Sequences can represent computed or lazy-loaded data
- **Composition**: Multiple operations can be chained without creating intermediate collections
- **Abstraction**: Code can work with any enumerable source without knowing the concrete type
- **Memory efficiency**: Allows iteration without loading entire sequences into memory
- **Flexibility**: Supports filtering, transformation, and aggregation through a unified interface

### Main Approaches

Consuming IEnumerable:
- **foreach iteration**: Process elements one at a time
- **LINQ queries**: Filter, transform, and combine sequences
- **ToList/ToArray**: Materialize sequences into concrete collections
- **Aggregation**: Compute results (Sum, Count, Average, etc.)

Producing IEnumerable:
- **yield return**: Generate sequences with iterator methods
- **LINQ operators**: Transform existing sequences into new ones
- **Collection APIs**: Most collections implement IEnumerable<T>
- **Custom iterators**: Implement IEnumerable<T> and IEnumerator<T> for complete control

### When to Use

Use `IEnumerable<T>` as a parameter type when:
- You need to iterate through a sequence once
- You want to support LINQ operations on the input
- You don't need random access or modification capabilities
- You want maximum flexibility in what callers can pass

Use `IEnumerable<T>` as a return type when:
- You want to support deferred execution
- The sequence might be computed or filtered lazily
- You want to hide the concrete collection type
- The sequence could be infinite or very large

Consider more specific types when:
- You need indexing: Use `IList<T>` or `IReadOnlyList<T>`
- You need modification: Use `ICollection<T>` or `List<T>`
- You need multiple iterations efficiently: Return `IReadOnlyList<T>` or materialize to a collection
- You need async iteration: Use `IAsyncEnumerable<T>`

## Essential Syntax & Examples

### Basic Iteration

```csharp
// foreach is the primary way to consume IEnumerable<T>
IEnumerable<string> names = new List<string> { "Alice", "Bob", "Charlie" };

foreach (string name in names)
{
    Console.WriteLine(name);
}
```

### LINQ Query Operations

```csharp
IEnumerable<int> numbers = new[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

// Filter with Where
IEnumerable<int> evenNumbers = numbers.Where(n => n % 2 == 0);

// Transform with Select
IEnumerable<string> numberStrings = numbers.Select(n => $"Number: {n}");

// Chain multiple operations
IEnumerable<int> result = numbers
    .Where(n => n > 3)
    .Select(n => n * 2)
    .OrderByDescending(n => n);

foreach (int value in result)
{
    Console.WriteLine(value); // 20, 18, 16, 14, 12, 10, 8
}
```

### Creating Sequences with yield return

```csharp
// Iterator methods produce IEnumerable<T> with deferred execution
public IEnumerable<int> GetNumbers(int count)
{
    for (int i = 1; i <= count; i++)
    {
        yield return i;
    }
}

// The sequence is generated on-demand during iteration
IEnumerable<int> numbers = GetNumbers(5);
foreach (int num in numbers)
{
    Console.WriteLine(num); // 1, 2, 3, 4, 5
}
```

### Deferred Execution

```csharp
// LINQ operations don't execute until the sequence is enumerated
var numbers = new List<int> { 1, 2, 3, 4, 5 };

IEnumerable<int> query = numbers
    .Where(n => n > 2)
    .Select(n => n * 2);

// No execution yet - query is just a plan

numbers.Add(6); // Modify source before enumeration

// Execution happens during iteration
foreach (int value in query)
{
    Console.WriteLine(value); // 6, 8, 10, 12
}
```

### Materialization

```csharp
IEnumerable<int> numbers = Enumerable.Range(1, 5);

// Materialize to concrete collections
List<int> list = numbers.ToList();
int[] array = numbers.ToArray();
HashSet<int> set = numbers.ToHashSet();

// Aggregation operations also force execution
int sum = numbers.Sum();
int count = numbers.Count();
int max = numbers.Max();
```

### Infinite Sequences

```csharp
// IEnumerable<T> can represent infinite sequences
public IEnumerable<int> GetInfiniteSequence()
{
    int i = 0;
    while (true)
    {
        yield return i++;
    }
}

// Take only what you need
IEnumerable<int> firstTen = GetInfiniteSequence().Take(10);
```

## Relationships & Integration

### LINQ Integration

`IEnumerable<T>` is the foundation for LINQ to Objects. All standard LINQ operators are extension methods on `IEnumerable<T>`:

```csharp
using System.Linq;

IEnumerable<int> numbers = new[] { 1, 2, 3, 4, 5 };

// Extension methods from System.Linq
var result = numbers
    .Where(n => n > 2)      // Filtering
    .Select(n => n * 2)     // Transformation
    .OrderBy(n => n)        // Ordering
    .Take(3);               // Limiting

int sum = numbers.Sum();
double average = numbers.Average();
bool any = numbers.Any(n => n > 3);
```

### Collection Framework

Most .NET collections implement `IEnumerable<T>`:

```csharp
// Arrays
int[] array = { 1, 2, 3 };
IEnumerable<int> fromArray = array;

// Lists
List<string> list = new() { "a", "b", "c" };
IEnumerable<string> fromList = list;

// Sets
HashSet<int> set = new() { 1, 2, 3 };
IEnumerable<int> fromSet = set;

// Dictionaries (as KeyValuePair sequences)
Dictionary<string, int> dict = new() { ["a"] = 1, ["b"] = 2 };
IEnumerable<KeyValuePair<string, int>> fromDict = dict;
```

### JSON Serialization Integration

`IEnumerable<T>` works seamlessly with System.Text.Json:

```csharp
using System.Text.Json;

IEnumerable<string> names = new[] { "Alice", "Bob", "Charlie" };

// Serialize IEnumerable<T> directly
string json = JsonSerializer.Serialize(names);
// ["Alice","Bob","Charlie"]

// Deserialize to IEnumerable<T> (actually creates a list)
IEnumerable<string> deserialized = JsonSerializer.Deserialize<IEnumerable<string>>(json);
```

Note: Deserialization to `IEnumerable<T>` or `ICollection<T>` creates a `List<T>` internally. For read-only scenarios, deserialize to `IReadOnlyList<T>` or `List<T>` explicitly.

### Async Enumeration

For async sequences, use `IAsyncEnumerable<T>` instead:

```csharp
// IAsyncEnumerable<T> for async iteration
public async IAsyncEnumerable<int> GetNumbersAsync()
{
    for (int i = 0; i < 5; i++)
    {
        await Task.Delay(100);
        yield return i;
    }
}

// Consume with await foreach
await foreach (int num in GetNumbersAsync())
{
    Console.WriteLine(num);
}
```

### Entity Framework and Database Queries

Entity Framework returns `IQueryable<T>` (which inherits from `IEnumerable<T>`), enabling deferred execution and translation to SQL:

```csharp
// IQueryable<T> inherits from IEnumerable<T>
using (var context = new MyDbContext())
{
    IEnumerable<Customer> customers = context.Customers
        .Where(c => c.City == "Seattle")
        .OrderBy(c => c.Name);
    
    // Query executes when enumerated
    foreach (var customer in customers)
    {
        Console.WriteLine(customer.Name);
    }
}
```

## Common Scenarios

### Filtering and Transformation Pipeline

**When to use**: Processing data with multiple filtering and transformation steps.

```csharp
public class Product
{
    public string Name { get; set; }
    public decimal Price { get; set; }
    public string Category { get; set; }
}

IEnumerable<Product> products = GetProducts();

// Build a processing pipeline
IEnumerable<string> discountedElectronics = products
    .Where(p => p.Category == "Electronics")
    .Where(p => p.Price > 100)
    .Select(p => new { p.Name, DiscountPrice = p.Price * 0.9m })
    .OrderBy(p => p.DiscountPrice)
    .Select(p => $"{p.Name}: ${p.DiscountPrice:F2}");

foreach (string item in discountedElectronics)
{
    Console.WriteLine(item);
}
```

**Considerations**: Each LINQ operation creates a new iterator. The entire chain executes lazily when enumerated.

### Lazy Data Generation

**When to use**: Computing sequences on-demand to save memory or defer expensive operations.

```csharp
// Generate Fibonacci sequence lazily
public IEnumerable<long> GenerateFibonacci()
{
    long a = 0, b = 1;
    
    while (true)
    {
        yield return a;
        (a, b) = (b, a + b);
    }
}

// Take only what you need
IEnumerable<long> first20 = GenerateFibonacci().Take(20);
foreach (long fib in first20)
{
    Console.WriteLine(fib);
}
```

**Considerations**: Infinite sequences work well with limiting operators (Take, TakeWhile). The sequence resets on each iteration unless materialized.

### Processing Large Files

**When to use**: Reading large files without loading everything into memory.

```csharp
public IEnumerable<string> ReadLargeFile(string path)
{
    using var reader = new StreamReader(path);
    string line;
    while ((line = reader.ReadLine()) != null)
    {
        yield return line;
    }
}

// Process one line at a time
IEnumerable<string> importantLines = ReadLargeFile("large.txt")
    .Where(line => line.Contains("ERROR"))
    .Select(line => line.Trim());

foreach (string line in importantLines)
{
    ProcessError(line);
}
```

**Considerations**: The file handle stays open during iteration when using `using` in an iterator method. Consider using `IEnumerable<T>` for streaming scenarios.

### Chaining API Results

**When to use**: Combining data from multiple sources or API calls.

```csharp
public IEnumerable<User> GetAllUsers(IEnumerable<int> userIds)
{
    foreach (int id in userIds)
    {
        User user = FetchUserFromApi(id);
        if (user != null)
        {
            yield return user;
        }
    }
}

// Use with LINQ
IEnumerable<int> activeUserIds = GetActiveUserIds();
IEnumerable<string> userNames = GetAllUsers(activeUserIds)
    .Select(u => u.Name);
```

**Considerations**: Each iteration triggers an API call. Consider materializing with ToList() if you need to iterate multiple times.

### Grouping and Aggregation

**When to use**: Organizing data into categories and computing statistics.

```csharp
public class Sale
{
    public string Product { get; set; }
    public string Region { get; set; }
    public decimal Amount { get; set; }
}

IEnumerable<Sale> sales = GetSales();

// Group and aggregate
var regionalTotals = sales
    .GroupBy(s => s.Region)
    .Select(g => new
    {
        Region = g.Key,
        Total = g.Sum(s => s.Amount),
        Count = g.Count(),
        Average = g.Average(s => s.Amount)
    });

foreach (var summary in regionalTotals)
{
    Console.WriteLine($"{summary.Region}: {summary.Total:C} ({summary.Count} sales)");
}
```

**Considerations**: GroupBy creates in-memory groups. For large datasets, consider processing groups as you create them or using more memory-efficient approaches.

### Custom Iterator with State

**When to use**: Generating sequences with complex logic or maintaining state across iterations.

```csharp
public IEnumerable<DateTime> GetBusinessDays(DateTime start, int count)
{
    DateTime current = start;
    int yielded = 0;
    
    while (yielded < count)
    {
        if (current.DayOfWeek != DayOfWeek.Saturday && 
            current.DayOfWeek != DayOfWeek.Sunday)
        {
            yield return current;
            yielded++;
        }
        current = current.AddDays(1);
    }
}

// Get next 10 business days
IEnumerable<DateTime> businessDays = GetBusinessDays(DateTime.Today, 10);
```

**Considerations**: Iterator state is maintained during enumeration but resets when you start a new iteration.

## Alternative Syntax Options

### Multiple Ways to Create IEnumerable

```csharp
// Collection expressions (C# 12+)
IEnumerable<int> numbers1 = [1, 2, 3, 4, 5];

// Array syntax
IEnumerable<int> numbers2 = new[] { 1, 2, 3, 4, 5 };

// List initialization
IEnumerable<int> numbers3 = new List<int> { 1, 2, 3, 4, 5 };

// Enumerable helper methods
IEnumerable<int> numbers4 = Enumerable.Range(1, 5);
IEnumerable<int> numbers5 = Enumerable.Repeat(42, 3);
IEnumerable<int> numbers6 = Enumerable.Empty<int>();

// Iterator method
IEnumerable<int> numbers7 = GetNumbers();

IEnumerable<int> GetNumbers()
{
    yield return 1;
    yield return 2;
    yield return 3;
}
```

### Query Syntax vs Method Syntax

LINQ supports both query syntax and method syntax:

```csharp
IEnumerable<int> numbers = Enumerable.Range(1, 10);

// Query syntax (similar to SQL)
IEnumerable<int> query1 = 
    from n in numbers
    where n % 2 == 0
    orderby n descending
    select n * 2;

// Method syntax (fluent API)
IEnumerable<int> query2 = numbers
    .Where(n => n % 2 == 0)
    .OrderByDescending(n => n)
    .Select(n => n * 2);

// Both produce the same result
```

Method syntax is more commonly used and supports all LINQ operators. Query syntax is limited to a subset of operators but can be more readable for complex queries with multiple from clauses.

### IEnumerable vs Concrete Types

```csharp
// Return IEnumerable<T> for flexibility
public IEnumerable<string> GetNames()
{
    return new[] { "Alice", "Bob", "Charlie" };
}

// Return List<T> when caller needs indexing or modification
public List<string> GetMutableNames()
{
    return new List<string> { "Alice", "Bob", "Charlie" };
}

// Return IReadOnlyList<T> when you want to prevent modification but allow indexing
public IReadOnlyList<string> GetReadOnlyNames()
{
    return new[] { "Alice", "Bob", "Charlie" };
}

// Return array when you need fixed size and maximum performance
public string[] GetNamesArray()
{
    return new[] { "Alice", "Bob", "Charlie" };
}
```

### Non-Generic IEnumerable

The non-generic `IEnumerable` interface is used for legacy collections and untyped scenarios:

```csharp
using System.Collections;

// Non-generic IEnumerable
IEnumerable untypedCollection = new ArrayList { 1, 2, 3 };

foreach (object item in untypedCollection)
{
    // Need to cast
    int number = (int)item;
    Console.WriteLine(number);
}

// Convert non-generic to generic
IEnumerable<int> typedCollection = untypedCollection.Cast<int>();
IEnumerable<int> filtered = untypedCollection.OfType<int>(); // Filters by type
```

Modern code should use `IEnumerable<T>` for type safety and performance.

## Best Practices

### Return IEnumerable&lt;T&gt; from Methods

Return `IEnumerable<T>` from methods to provide flexibility and enable deferred execution:

```csharp
// Good: Returns IEnumerable<T>, enables LINQ and deferred execution
public IEnumerable<Product> GetDiscountedProducts(decimal minPrice)
{
    return products
        .Where(p => p.Price >= minPrice)
        .Where(p => p.OnSale);
}

// Usage: Caller can add more filtering
var cheapElectronics = GetDiscountedProducts(50)
    .Where(p => p.Category == "Electronics")
    .Take(10);
```

### Be Aware of Multiple Enumeration

Enumerating `IEnumerable<T>` multiple times can be expensive or produce unexpected results:

```csharp
// Problematic: Enumerating multiple times
IEnumerable<int> numbers = ExpensiveOperation();

int count = numbers.Count();        // First enumeration
int sum = numbers.Sum();            // Second enumeration - ExpensiveOperation runs again!

// Better: Materialize once if you need multiple iterations
List<int> numbersList = ExpensiveOperation().ToList();

int count = numbersList.Count;
int sum = numbersList.Sum();
```

Use `.ToList()` or `.ToArray()` when you need to iterate multiple times or when the underlying source might change.

### Prefer Streaming Over Materialization

Avoid materializing sequences unnecessarily:

```csharp
// Less efficient: Creates intermediate lists
List<int> filtered = numbers.Where(n => n > 10).ToList();
List<int> doubled = filtered.Select(n => n * 2).ToList();
int sum = doubled.Sum();

// Better: Stream through the pipeline
int sum = numbers
    .Where(n => n > 10)
    .Select(n => n * 2)
    .Sum();
```

### Use Appropriate Collection Interface

Choose the interface that best matches your needs:

```csharp
// When you only need to iterate once
public void ProcessItems(IEnumerable<string> items)
{
    foreach (string item in items)
    {
        Console.WriteLine(item);
    }
}

// When you need to check counts or access by index
public void ProcessItems(IReadOnlyCollection<string> items)
{
    Console.WriteLine($"Processing {items.Count} items");
    // Can count efficiently without iteration
}

// When you need indexing
public void ProcessItems(IReadOnlyList<string> items)
{
    for (int i = 0; i < items.Count; i++)
    {
        Console.WriteLine($"{i}: {items[i]}");
    }
}
```

### Consider IAsyncEnumerable for I/O Operations

Use `IAsyncEnumerable<T>` when iterating over async data sources:

```csharp
// Synchronous IEnumerable blocks on each item
public IEnumerable<string> ReadLines(string path)
{
    using var reader = new StreamReader(path);
    string line;
    while ((line = reader.ReadLine()) != null)
    {
        yield return line;
    }
}

// Better for I/O: IAsyncEnumerable doesn't block
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

### Avoid IEnumerable for Large Result Sets in APIs

When returning data from APIs, consider the implications:

```csharp
// Problematic: Deferred execution in API methods can cause issues
public IEnumerable<Customer> GetCustomers()
{
    using var context = new DbContext();
    return context.Customers.Where(c => c.Active);
    // DbContext disposed before enumeration!
}

// Better: Materialize before returning
public List<Customer> GetCustomers()
{
    using var context = new DbContext();
    return context.Customers
        .Where(c => c.Active)
        .ToList();
}

// Or: Return IAsyncEnumerable and stream results
public async IAsyncEnumerable<Customer> GetCustomersAsync()
{
    using var context = new DbContext();
    await foreach (var customer in context.Customers.Where(c => c.Active).AsAsyncEnumerable())
    {
        yield return customer;
    }
}
```

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

### Memory Implications with Large Sequences

Deferred execution keeps the entire chain in memory as a series of iterators:

```csharp
// This creates a chain of iterators, not intermediate collections
IEnumerable<string> results = hugeDataset
    .Where(x => x.IsActive)
    .Select(x => x.Transform())
    .OrderBy(x => x.Priority)
    .Where(x => x.Score > 100)
    .Select(x => x.ToString());

// OrderBy must materialize the sequence internally
// Other operations stream through
```

Operations like `OrderBy`, `Reverse`, `GroupBy` require materialization. Be aware of memory usage with large sequences.

### IEnumerable Doesn't Support Modification

`IEnumerable<T>` is read-only for iteration. It provides no methods to add, remove, or modify elements:

```csharp
IEnumerable<int> numbers = new List<int> { 1, 2, 3 };

// These don't exist on IEnumerable<T>:
// numbers.Add(4);
// numbers.Remove(2);
// numbers[0] = 10;

// Need to check the concrete type or use a different interface
if (numbers is List<int> list)
{
    list.Add(4);
}

// Or work with ICollection<T>, IList<T>, etc.
```

Use `ICollection<T>` or `IList<T>` if you need modification capabilities.

## See Also

- **IAsyncEnumerable&lt;T&gt;**: Async version for asynchronous iteration scenarios
- **IQueryable&lt;T&gt;**: Expression-based queries that can translate to other query languages (SQL, etc.)
- **LINQ**: Language Integrated Query operations that extend IEnumerable&lt;T&gt;
- **Collection Expressions**: Modern C# syntax for creating collections
- **yield return**: C# keyword for creating iterator methods
- **Task and Task&lt;T&gt;**: For async operations that complement IAsyncEnumerable&lt;T&gt;
- **ICollection&lt;T&gt; and IList&lt;T&gt;**: Collection interfaces with modification and indexing capabilities
- **System.Text.Json**: JSON serialization of enumerable sequences
