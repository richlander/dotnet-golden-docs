# IEnumerable and IEnumerable&lt;T&gt;
## Essential Syntax & Examples
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
