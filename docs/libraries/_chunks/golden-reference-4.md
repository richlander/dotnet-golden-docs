# .NET Libraries
## Library Ecosystem and Package Management
### Integration Testing with ASP.NET Core

```csharp
// Integration testing with WebApplicationFactory
public class ProductApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;
    private readonly HttpClient _client;

    public ProductApiTests(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task GetProducts_ReturnsSuccessAndCorrectContentType()
    {
        var response = await _client.GetAsync("/api/products");

        response.EnsureSuccessStatusCode();
        Assert.Equal("application/json",
            response.Content.Headers.ContentType.MediaType);
    }
}
```

## Cloud and Distributed System Libraries

### Azure SDK and Cloud Integration

```csharp
// Azure Service Bus messaging
using Azure.Messaging.ServiceBus;
await using var client = new ServiceBusClient(connectionString);
ServiceBusSender sender = client.CreateSender(queueName);

var message = new ServiceBusMessage(JsonSerializer.Serialize(data));
await sender.SendMessageAsync(message);

// Azure Key Vault integration
using Azure.Security.KeyVault.Secrets;
var client = new SecretClient(vaultUri, new DefaultAzureCredential());
KeyVaultSecret secret = await client.GetSecretAsync("database-connection");
```

### Distributed Caching and State Management

```csharp
// Redis distributed caching
builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = connectionString;
});

public class CacheService
{
    private readonly IDistributedCache _cache;

    public async Task<T> GetOrSetAsync<T>(string key, Func<Task<T>> factory,
        TimeSpan expiration)
    {
        string cached = await _cache.GetStringAsync(key);
        if (cached != null)
        {
            return JsonSerializer.Deserialize<T>(cached);
        }

        T result = await factory();
        await _cache.SetStringAsync(key, JsonSerializer.Serialize(result),
            new DistributedCacheEntryOptions { AbsoluteExpirationRelativeToNow = expiration });

        return result;
    }
}
```

## Library Ecosystem and Package Management

### NuGet Package Discovery and Management

```xml
<!-- Modern package management with Central Package Management -->
<PackageReference Include="Microsoft.Extensions.Hosting" />
<PackageReference Include="Microsoft.Extensions.Http" />
<PackageReference Include="System.Text.Json" />

<!-- Version management in Directory.Packages.props -->
<PackageVersion Include="Microsoft.Extensions.Hosting" Version="8.0.0" />
<PackageVersion Include="System.Text.Json" Version="8.0.0" />
```
