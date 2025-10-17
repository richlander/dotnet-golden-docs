# IEnumerable and IEnumerable&lt;T&gt;
## Common Scenarios
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
