# Task and Task&lt;T&gt;
## Relationships & Integration
### Exception Handling

```csharp
public async Task<Data> ProcessWithErrorHandlingAsync()
{
    try
    {
        Task<Data> task = FetchDataAsync();
        return await task;
    }
    catch (HttpRequestException ex)
    {
        Console.WriteLine($"Network error: {ex.Message}");
        return null;
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Unexpected error: {ex.Message}");
        throw;
    }
}
```

## Relationships & Integration

### Async/Await Integration

Task is the return type for async methods:

```csharp
// async methods return Task or Task<T>
public async Task<string> GetDataAsync()
{
    await Task.Delay(100);
    return "data";
}

// Equivalent to:
public Task<string> GetDataAsync()
{
    return Task.Run(async () =>
    {
        await Task.Delay(100);
        return "data";
    });
}
```

### IAsyncEnumerable Integration

Tasks can be produced from async enumerables:

```csharp
public async Task<List<T>> MaterializeAsync<T>(IAsyncEnumerable<T> source)
{
    var results = new List<T>();
    
    await foreach (var item in source)
    {
        results.Add(item);
    }
    
    return results;
}

// Task<List<T>> from async enumerable
Task<List<int>> listTask = MaterializeAsync(GetNumbersAsync());
List<int> numbers = await listTask;
```

### Cancellation with CancellationToken

Tasks support cancellation through tokens:

```csharp
public async Task<Data> FetchDataAsync(CancellationToken cancellationToken)
{
    using var client = new HttpClient();
    var response = await client.GetAsync("https://api.example.com", cancellationToken);
    return await response.Content.ReadFromJsonAsync<Data>(cancellationToken: cancellationToken);
}

// Usage with timeout
var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));
try
{
    var data = await FetchDataAsync(cts.Token);
}
catch (OperationCanceledException)
{
    Console.WriteLine("Operation cancelled");
}
```

### JSON Serialization

System.Text.Json returns Tasks for async operations:

```csharp
using System.Text.Json;

// Returns Task<T>
public async Task<T> LoadFromJsonAsync<T>(string path)
{
    using var stream = File.OpenRead(path);
    Task<T> deserializeTask = JsonSerializer.DeserializeAsync<T>(stream);
    return await deserializeTask;
}

// Returns Task
public async Task SaveToJsonAsync<T>(string path, T data)
{
    using var stream = File.Create(path);
    Task serializeTask = JsonSerializer.SerializeAsync(stream, data);
    await serializeTask;
}
```
