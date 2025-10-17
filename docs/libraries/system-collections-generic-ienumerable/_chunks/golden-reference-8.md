# IEnumerable and IEnumerable&lt;T&gt;
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
