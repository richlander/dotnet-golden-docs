# Type Extensions
## Real-World Patterns

### Domain-Specific Extensions

Create fluent APIs for your domain.

```csharp
public static class DateTimeExtensions
{
    extension (DateTime date)
    {
        public bool IsWeekend => 
            date.DayOfWeek == DayOfWeek.Saturday || 
            date.DayOfWeek == DayOfWeek.Sunday;
        
        public bool IsBusinessDay => !IsWeekend;
        
        public DateTime NextBusinessDay()
        {
            var next = date.AddDays(1);
            while (!next.IsBusinessDay)
                next = next.AddDays(1);
            return next;
        }
        
        public DateTime StartOfWeek() =>
            date.AddDays(-(int)date.DayOfWeek);
        
        public DateTime EndOfMonth() =>
            new DateTime(date.Year, date.Month, 
                DateTime.DaysInMonth(date.Year, date.Month));
    }
}

// Natural domain language
DateTime today = DateTime.Today;
if (today.IsBusinessDay)
{
    DateTime deadline = today.NextBusinessDay().EndOfMonth();
}
```

### LINQ-Style Query Extensions

Extend collections with custom query operators.

```csharp
public static class QueryExtensions
{
    extension<T> (IEnumerable<T> source)
    {
        public IEnumerable<T> DistinctBy<TKey>(Func<T, TKey> keySelector)
        {
            var seen = new HashSet<TKey>();
            foreach (var item in source)
            {
                if (seen.Add(keySelector(item)))
                    yield return item;
            }
        }
        
        public IEnumerable<IEnumerable<T>> Batch(int size)
        {
            var batch = new List<T>(size);
            foreach (var item in source)
            {
                batch.Add(item);
                if (batch.Count == size)
                {
                    yield return batch;
                    batch = new List<T>(size);
                }
            }
            if (batch.Count > 0)
                yield return batch;
        }
        
        public T? MaxBy<TKey>(Func<T, TKey> keySelector) 
            where TKey : IComparable<TKey>
        {
            return source.OrderByDescending(keySelector).FirstOrDefault();
        }
    }
}

// Chainable query operations
var people = GetPeople();
var batches = people
    .DistinctBy(p => p.Email)
    .Batch(100)
    .ToList();
```

### Adapter Pattern Implementation

Adapt existing types to required interfaces.

```csharp
public static class StreamExtensions
{
    extension (Stream stream)
    {
        public async Task<string> ReadAllTextAsync()
        {
            using var reader = new StreamReader(stream);
            return await reader.ReadToEndAsync();
        }
        
        public async Task WriteAllTextAsync(string content)
        {
            using var writer = new StreamWriter(stream);
            await writer.WriteAsync(content);
            await writer.FlushAsync();
        }
        
        public void CopyToFile(string path)
        {
            using var file = File.Create(path);
            stream.CopyTo(file);
        }
    }
}
```
