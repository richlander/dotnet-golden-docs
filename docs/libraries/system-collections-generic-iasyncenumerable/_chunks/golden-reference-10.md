# IAsyncEnumerable&lt;T&gt;
## Limitations and Considerations
### Prefer IAsyncEnumerable Over Task&lt;IEnumerable&lt;T&gt;&gt; for Streaming

```csharp
// Less efficient: Loads all data before returning
public async Task<IEnumerable<Customer>> GetCustomersOldWayAsync()
{
    var customers = new List<Customer>();
    
    for (int i = 0; i < 1000; i++)
    {
        var customer = await FetchCustomerAsync(i);
        customers.Add(customer);
    }
    
    return customers; // Must wait for all 1000
}

// Better: Stream results as they arrive
public async IAsyncEnumerable<Customer> GetCustomersNewWayAsync()
{
    for (int i = 0; i < 1000; i++)
    {
        var customer = await FetchCustomerAsync(i);
        yield return customer; // Yield as soon as available
    }
}
```

## Limitations and Considerations

### No Synchronous LINQ Methods

Standard LINQ methods don't work directly on `IAsyncEnumerable<T>`:

```csharp
IAsyncEnumerable<int> numbers = GetNumbersAsync();

// These don't compile:
// var filtered = numbers.Where(n => n > 5);
// int count = numbers.Count();

// Solution: Use System.Linq.Async
var filtered = numbers.Where(n => n > 5);      // Async version
int count = await numbers.CountAsync();         // Async version

// Or materialize first (loses streaming benefits)
var list = await numbers.ToListAsync();
var filteredList = list.Where(n => n > 5);
int listCount = list.Count;
```

### Multiple Enumeration Can Be Expensive

Each enumeration re-executes the async sequence:

```csharp
IAsyncEnumerable<int> numbers = FetchFromApiAsync();

// Each of these enumerates the entire sequence
int count = await numbers.CountAsync();    // First API call
int sum = await numbers.SumAsync();        // Second API call
var list = await numbers.ToListAsync();    // Third API call

// Better: Materialize once
var materializedList = await numbers.ToListAsync();
int count = materializedList.Count;
int sum = materializedList.Sum();
```
