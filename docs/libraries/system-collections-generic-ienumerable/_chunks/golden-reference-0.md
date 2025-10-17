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
