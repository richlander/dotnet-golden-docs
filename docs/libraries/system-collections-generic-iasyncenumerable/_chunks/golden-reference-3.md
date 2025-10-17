# IAsyncEnumerable&lt;T&gt;
## Relationships & Integration

### Relationship to IEnumerable&lt;T&gt;

`IAsyncEnumerable<T>` is the async counterpart to `IEnumerable<T>`:

```csharp
// Synchronous enumeration
IEnumerable<int> SyncNumbers()
{
    for (int i = 0; i < 5; i++)
    {
        Thread.Sleep(100); // Blocks thread
        yield return i;
    }
}

foreach (int n in SyncNumbers()) // Synchronous
{
    Console.WriteLine(n);
}

// Asynchronous enumeration
async IAsyncEnumerable<int> AsyncNumbers()
{
    for (int i = 0; i < 5; i++)
    {
        await Task.Delay(100); // Doesn't block
        yield return i;
    }
}

await foreach (int n in AsyncNumbers()) // Asynchronous
{
    Console.WriteLine(n);
}
```

### Task Integration

`IAsyncEnumerable<T>` works seamlessly with `Task` and `Task<T>`:

```csharp
// Combining Task<T> with IAsyncEnumerable<T>
public async IAsyncEnumerable<Customer> GetCustomersAsync()
{
    // Await a Task before yielding
    string[] customerIds = await FetchCustomerIdsAsync();
    
    foreach (string id in customerIds)
    {
        // Await for each element
        Customer customer = await FetchCustomerAsync(id);
        yield return customer;
    }
}

// Returns Task when consuming the entire sequence
public async Task<List<Customer>> GetAllCustomersAsync()
{
    var customers = new List<Customer>();
    
    await foreach (var customer in GetCustomersAsync())
    {
        customers.Add(customer);
    }
    
    return customers;
}
```

### JSON Serialization with System.Text.Json

System.Text.Json supports streaming JSON arrays with `IAsyncEnumerable<T>`:

```csharp
using System.Text.Json;

// Deserialize large JSON arrays as async streams
public async IAsyncEnumerable<WeatherForecast> DeserializeJsonStreamAsync(
    Stream utf8Json)
{
    await foreach (var forecast in JsonSerializer.DeserializeAsyncEnumerable<WeatherForecast>(utf8Json))
    {
        yield return forecast;
    }
}

// Serialize IAsyncEnumerable to JSON stream
public async Task SerializeToJsonAsync(
    IAsyncEnumerable<WeatherForecast> forecasts,
    Stream utf8Json)
{
    await JsonSerializer.SerializeAsync(utf8Json, forecasts);
}

// Usage with HTTP
public async Task ProcessApiResponseAsync(HttpResponseMessage response)
{
    using var stream = await response.Content.ReadAsStreamAsync();
    
    await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream))
    {
        Console.WriteLine($"Received: {item.Name}");
        await ProcessItemAsync(item);
    }
}
```
