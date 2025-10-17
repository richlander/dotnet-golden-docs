# IEnumerable and IEnumerable&lt;T&gt;
## Common Scenarios
### Lazy Data Generation

**When to use**: Computing sequences on-demand to save memory or defer expensive operations.

```csharp
// Generate Fibonacci sequence lazily
public IEnumerable<long> GenerateFibonacci()
{
    long a = 0, b = 1;
    
    while (true)
    {
        yield return a;
        (a, b) = (b, a + b);
    }
}

// Take only what you need
IEnumerable<long> first20 = GenerateFibonacci().Take(20);
foreach (long fib in first20)
{
    Console.WriteLine(fib);
}
```

**Considerations**: Infinite sequences work well with limiting operators (Take, TakeWhile). The sequence resets on each iteration unless materialized.

### Processing Large Files

**When to use**: Reading large files without loading everything into memory.

```csharp
public IEnumerable<string> ReadLargeFile(string path)
{
    using var reader = new StreamReader(path);
    string line;
    while ((line = reader.ReadLine()) != null)
    {
        yield return line;
    }
}

// Process one line at a time
IEnumerable<string> importantLines = ReadLargeFile("large.txt")
    .Where(line => line.Contains("ERROR"))
    .Select(line => line.Trim());

foreach (string line in importantLines)
{
    ProcessError(line);
}
```

**Considerations**: The file handle stays open during iteration when using `using` in an iterator method. Consider using `IEnumerable<T>` for streaming scenarios.

### Chaining API Results

**When to use**: Combining data from multiple sources or API calls.

```csharp
public IEnumerable<User> GetAllUsers(IEnumerable<int> userIds)
{
    foreach (int id in userIds)
    {
        User user = FetchUserFromApi(id);
        if (user != null)
        {
            yield return user;
        }
    }
}

// Use with LINQ
IEnumerable<int> activeUserIds = GetActiveUserIds();
IEnumerable<string> userNames = GetAllUsers(activeUserIds)
    .Select(u => u.Name);
```

**Considerations**: Each iteration triggers an API call. Consider materializing with ToList() if you need to iterate multiple times.
