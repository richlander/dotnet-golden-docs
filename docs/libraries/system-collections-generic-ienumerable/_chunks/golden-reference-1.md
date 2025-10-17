# IEnumerable and IEnumerable&lt;T&gt;
## Essential Syntax & Examples
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
