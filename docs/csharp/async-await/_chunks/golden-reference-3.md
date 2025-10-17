# Async and Await
## Relationships & Integration
### IAsyncEnumerable Integration

Async/await enables asynchronous iteration with `IAsyncEnumerable<T>`:

```csharp
// Produce async sequence
public async IAsyncEnumerable<int> GetNumbersAsync()
{
    for (int i = 0; i < 10; i++)
    {
        await Task.Delay(100);
        yield return i;
    }
}

// Consume with await foreach
await foreach (int num in GetNumbersAsync())
{
    Console.WriteLine(num);
}
```

### JSON Serialization with System.Text.Json

System.Text.Json provides async serialization methods:

```csharp
using System.Text.Json;

// Async serialization
public async Task SaveToJsonAsync<T>(string path, T data)
{
    using var stream = File.Create(path);
    await JsonSerializer.SerializeAsync(stream, data);
}

// Async deserialization
public async Task<T> LoadFromJsonAsync<T>(string path)
{
    using var stream = File.OpenRead(path);
    return await JsonSerializer.DeserializeAsync<T>(stream);
}

// Stream large JSON arrays
public async Task ProcessLargeJsonAsync(string path)
{
    using var stream = File.OpenRead(path);
    
    await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream))
    {
        await ProcessItemAsync(item);
    }
}
```

### Entity Framework Core Integration

Entity Framework Core provides async query methods:

```csharp
using Microsoft.EntityFrameworkCore;

public async Task<List<Customer>> GetActiveCustomersAsync(MyDbContext context)
{
    return await context.Customers
        .Where(c => c.IsActive)
        .OrderBy(c => c.Name)
        .ToListAsync();
}

public async Task<Customer> FindCustomerAsync(MyDbContext context, int id)
{
    return await context.Customers.FindAsync(id);
}

public async Task SaveChangesAsync(MyDbContext context)
{
    await context.SaveChangesAsync();
}
```

### ASP.NET Core Integration

ASP.NET Core is built on async/await throughout:

```csharp
[ApiController]
[Route("api/[controller]")]
public class CustomersController : ControllerBase
{
    private readonly MyDbContext _context;
    
    public CustomersController(MyDbContext context)
    {
        _context = context;
    }
    
    [HttpGet("{id}")]
    public async Task<ActionResult<Customer>> GetCustomer(int id)
    {
        var customer = await _context.Customers.FindAsync(id);
        
        if (customer == null)
            return NotFound();
        
        return customer;
    }
    
    [HttpPost]
    public async Task<ActionResult<Customer>> CreateCustomer(Customer customer)
    {
        _context.Customers.Add(customer);
        await _context.SaveChangesAsync();
        
        return CreatedAtAction(nameof(GetCustomer), new { id = customer.Id }, customer);
    }
}
```
