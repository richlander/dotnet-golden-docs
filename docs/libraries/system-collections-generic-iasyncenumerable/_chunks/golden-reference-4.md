# IAsyncEnumerable&lt;T&gt;
## Relationships & Integration
### Entity Framework Core Integration

Entity Framework Core returns `IAsyncEnumerable<T>` for streaming query results:

```csharp
using Microsoft.EntityFrameworkCore;

public async Task ProcessLargeDatasetAsync(MyDbContext context)
{
    // AsAsyncEnumerable returns IAsyncEnumerable<T>
    IAsyncEnumerable<Customer> customers = context.Customers
        .Where(c => c.IsActive)
        .AsAsyncEnumerable();
    
    await foreach (var customer in customers)
    {
        // Process one at a time without loading all into memory
        await UpdateCustomerAsync(customer);
        
        // Save changes periodically
        if (customer.Id % 100 == 0)
        {
            await context.SaveChangesAsync();
        }
    }
}
```

### ASP.NET Core Integration

ASP.NET Core supports returning `IAsyncEnumerable<T>` from API endpoints:

```csharp
[ApiController]
[Route("api/[controller]")]
public class DataController : ControllerBase
{
    // Return IAsyncEnumerable directly - ASP.NET Core streams the response
    [HttpGet("stream")]
    public async IAsyncEnumerable<WeatherForecast> GetWeatherStream(
        [EnumeratorCancellation] CancellationToken cancellationToken)
    {
        for (int i = 0; i < 100; i++)
        {
            cancellationToken.ThrowIfCancellationRequested();
            
            await Task.Delay(100, cancellationToken);
            
            yield return new WeatherForecast
            {
                Date = DateTime.Now.AddDays(i),
                TemperatureC = Random.Shared.Next(-20, 55)
            };
        }
    }
}

// Client consumption
public async Task ConsumeStreamingApiAsync(HttpClient client)
{
    var stream = await client.GetStreamAsync("api/data/stream");
    
    await foreach (var forecast in JsonSerializer.DeserializeAsyncEnumerable<WeatherForecast>(stream))
    {
        Console.WriteLine($"{forecast.Date}: {forecast.TemperatureC}°C");
    }
}
```

### Channels Integration

`System.Threading.Channels` works well with `IAsyncEnumerable<T>`:

```csharp
using System.Threading.Channels;

// Convert Channel to IAsyncEnumerable
public async IAsyncEnumerable<T> ReadAllAsync<T>(ChannelReader<T> reader)
{
    await foreach (var item in reader.ReadAllAsync())
    {
        yield return item;
    }
}

// Producer-consumer pattern
public async Task ProducerConsumerAsync()
{
    var channel = Channel.CreateUnbounded<int>();
    
    // Producer
    _ = Task.Run(async () =>
    {
        for (int i = 0; i < 100; i++)
        {
            await channel.Writer.WriteAsync(i);
            await Task.Delay(10);
        }
        channel.Writer.Complete();
    });
    
    // Consumer using IAsyncEnumerable
    await foreach (int item in channel.Reader.ReadAllAsync())
    {
        Console.WriteLine($"Consumed: {item}");
    }
}
```
