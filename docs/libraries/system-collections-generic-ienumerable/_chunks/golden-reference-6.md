# IEnumerable and IEnumerable&lt;T&gt;
## Alternative Syntax Options
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
