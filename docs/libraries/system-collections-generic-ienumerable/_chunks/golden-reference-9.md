# IEnumerable and IEnumerable&lt;T&gt;
## Best Practices
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
