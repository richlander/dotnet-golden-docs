# IEnumerable and IEnumerable&lt;T&gt;
## Alternative Syntax Options
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
