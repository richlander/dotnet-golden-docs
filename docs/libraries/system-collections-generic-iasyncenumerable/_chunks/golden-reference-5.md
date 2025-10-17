# IAsyncEnumerable&lt;T&gt;
## Common Scenarios

### Paginated API Consumption

**When to use**: Fetching large datasets from paginated REST APIs.

```csharp
public async IAsyncEnumerable<User> GetAllUsersAsync(
    HttpClient client,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    int page = 1;
    bool hasMore = true;
    
    while (hasMore)
    {
        var response = await client.GetFromJsonAsync<PagedResponse<User>>(
            $"/api/users?page={page}",
            cancellationToken);
        
        foreach (var user in response.Items)
        {
            yield return user;
        }
        
        hasMore = response.HasNextPage;
        page++;
    }
}

// Usage
await foreach (var user in GetAllUsersAsync(httpClient))
{
    Console.WriteLine(user.Name);
}
```

**Considerations**: Each page requires a network call. The iterator naturally handles paging logic and backpressure.

### Streaming File Processing

**When to use**: Processing large files line-by-line without loading into memory.

```csharp
public async IAsyncEnumerable<LogEntry> ParseLogFileAsync(
    string path,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    using var reader = new StreamReader(path);
    
    string line;
    while ((line = await reader.ReadLineAsync()) != null)
    {
        cancellationToken.ThrowIfCancellationRequested();
        
        if (TryParseLogEntry(line, out var entry))
        {
            yield return entry;
        }
    }
}

// Process with filtering
await foreach (var entry in ParseLogFileAsync("app.log")
    .Where(e => e.Level == LogLevel.Error))
{
    await ReportErrorAsync(entry);
}
```

**Considerations**: File remains open during iteration. Use cancellation tokens for long-running operations.

### Database Streaming

**When to use**: Processing large database result sets without loading all rows into memory.

```csharp
public async IAsyncEnumerable<Customer> GetActiveCustomersAsync(
    MyDbContext context,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    await foreach (var customer in context.Customers
        .Where(c => c.IsActive)
        .OrderBy(c => c.Name)
        .AsAsyncEnumerable()
        .WithCancellation(cancellationToken))
    {
        yield return customer;
    }
}

// Batch processing
await foreach (var customer in GetActiveCustomersAsync(dbContext))
{
    await SendWelcomeEmailAsync(customer);
}
```

**Considerations**: Keep DbContext alive during iteration. Consider batching for better performance.
