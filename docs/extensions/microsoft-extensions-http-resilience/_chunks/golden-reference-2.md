# Microsoft.Extensions.Http.Resilience
## Microservices Communication Reliability
### Configuration Through Options Pattern

```csharp
// Configuration through IConfiguration
services.Configure<HttpStandardResilienceOptions>("MyApiClient",
    configuration.GetSection("HttpResilience:MyApiClient"));

services.AddHttpClient("MyApiClient")
    .AddStandardResilienceHandler();

// appsettings.json
{
  "HttpResilience": {
    "MyApiClient": {
      "Retry": {
        "MaxRetryAttempts": 3,
        "BaseDelay": "00:00:01"
      },
      "CircuitBreaker": {
        "FailureRatio": 0.6,
        "MinimumThroughput": 15
      }
    }
  }
}
```

### Resilience with Custom Logic

```csharp
public class SmartResilienceHandler : DelegatingHandler
{
    private readonly ResiliencePipeline<HttpResponseMessage> _pipeline;

    public SmartResilienceHandler(ResiliencePipeline<HttpResponseMessage> pipeline)
    {
        _pipeline = pipeline;
    }

    protected override async Task<HttpResponseMessage> SendAsync(
        HttpRequestMessage request, CancellationToken cancellationToken)
    {
        return await _pipeline.ExecuteAsync(async token =>
        {
            // Add custom logic before request
            LogRequestAttempt(request);

            var response = await base.SendAsync(request, token);

            // Add custom logic after response
            LogResponseReceived(response);

            return response;
        }, cancellationToken);
    }
}
```

## Microservices Communication Reliability

```csharp
public class OrderService
{
    private readonly HttpClient _paymentClient;
    private readonly HttpClient _inventoryClient;

    public OrderService(IHttpClientFactory factory)
    {
        _paymentClient = factory.CreateClient("PaymentService");
        _inventoryClient = factory.CreateClient("InventoryService");
    }

    public async Task<OrderResult> ProcessOrderAsync(Order order)
    {
        try
        {
            // Check inventory with resilience
            var inventoryResult = await _inventoryClient.PostAsJsonAsync(
                "/api/inventory/reserve", order.Items);

            if (!inventoryResult.IsSuccessStatusCode)
            {
                return OrderResult.Failed("Inventory unavailable");
            }

            // Process payment with resilience
            var paymentResult = await _paymentClient.PostAsJsonAsync(
                "/api/payment/charge", order.Payment);

            return paymentResult.IsSuccessStatusCode
                ? OrderResult.Success()
                : OrderResult.Failed("Payment failed");
        }
        catch (HttpRequestException ex)
        {
            // Resilience patterns handle retries, but ultimate failures still surface
            return OrderResult.Failed($"Service communication failed: {ex.Message}");
        }
    }
}

// Service registration with different resilience profiles
services.AddHttpClient("PaymentService", client =>
    client.BaseAddress = new Uri("https://payment.service.com"))
    .AddStandardResilienceHandler()
    .Configure(options =>
    {
        // More conservative for payment operations
        options.Retry.MaxRetryAttempts = 2;
        options.CircuitBreaker.FailureRatio = 0.3;
    });

services.AddHttpClient("InventoryService", client =>
    client.BaseAddress = new Uri("https://inventory.service.com"))
    .AddStandardHedgingHandler() // Use hedging for faster inventory checks
    .Configure(options =>
    {
        options.Hedging.MaxHedgedAttempts = 3;
        options.TotalRequestTimeout.Timeout = TimeSpan.FromSeconds(5);
    });
```
