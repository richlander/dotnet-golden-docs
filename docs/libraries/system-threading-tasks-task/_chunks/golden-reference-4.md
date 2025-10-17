# Task and Task&lt;T&gt;
## Relationships & Integration
### Entity Framework Core

EF Core query methods return Tasks:

```csharp
using Microsoft.EntityFrameworkCore;

public async Task<Customer> GetCustomerAsync(MyDbContext context, int id)
{
    Task<Customer> findTask = context.Customers.FindAsync(id).AsTask();
    return await findTask;
}

public async Task<List<Customer>> GetActiveCustomersAsync(MyDbContext context)
{
    Task<List<Customer>> queryTask = context.Customers
        .Where(c => c.IsActive)
        .ToListAsync();
    
    return await queryTask;
}
```

### ASP.NET Core

ASP.NET Core controllers work with Tasks:

```csharp
[ApiController]
[Route("api/[controller]")]
public class DataController : ControllerBase
{
    [HttpGet("{id}")]
    public async Task<ActionResult<Data>> GetData(int id)
    {
        Task<Data> fetchTask = _repository.GetByIdAsync(id);
        Data data = await fetchTask;
        
        if (data == null)
            return NotFound();
        
        return data;
    }
    
    [HttpPost]
    public async Task<ActionResult> CreateData(Data data)
    {
        Task saveTask = _repository.SaveAsync(data);
        await saveTask;
        
        return CreatedAtAction(nameof(GetData), new { id = data.Id }, data);
    }
}
```

### HttpClient Integration

HttpClient methods return Tasks:

```csharp
public async Task<Product> GetProductAsync(int id)
{
    using var client = new HttpClient();
    
    Task<Product> getTask = client.GetFromJsonAsync<Product>(
        $"https://api.example.com/products/{id}");
    
    return await getTask;
}

public async Task<HttpResponseMessage> PostDataAsync(string url, object data)
{
    using var client = new HttpClient();
    
    Task<HttpResponseMessage> postTask = client.PostAsJsonAsync(url, data);
    HttpResponseMessage response = await postTask;
    
    response.EnsureSuccessStatusCode();
    return response;
}
```

### Parallel Processing

Task.Run enables parallel execution:

```csharp
public async Task ProcessInParallelAsync(List<Item> items)
{
    var tasks = items.Select(item => Task.Run(() => ProcessItem(item)));
    
    await Task.WhenAll(tasks);
}

// Batch processing with controlled concurrency
public async Task ProcessInBatchesAsync(List<Item> items, int batchSize)
{
    foreach (var batch in items.Chunk(batchSize))
    {
        var tasks = batch.Select(item => ProcessItemAsync(item));
        await Task.WhenAll(tasks);
    }
}
```
