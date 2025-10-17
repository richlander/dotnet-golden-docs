# Microsoft.Extensions.Http.Resilience
## Relationships & Integration

Ecosystem positioning: Microsoft.Extensions.Http.Resilience sits at the intersection of HTTP communication and fault tolerance, providing the reliability layer essential for distributed .NET applications built with HttpClient.

Polly framework foundation: Built directly on Polly, leveraging its mature resilience algorithms while providing opinionated defaults and simplified configuration for common HTTP scenarios.

HttpClient factory integration: Designed to work seamlessly with Microsoft.Extensions.Http's HttpClient factory, enabling resilience configuration through standard dependency injection patterns.

Observability integration: Provides built-in telemetry that integrates with .NET's logging, metrics, and distributed tracing infrastructure for comprehensive resilience monitoring.

Microservices architecture: Essential component for microservices communication, providing the fault tolerance necessary for reliable service-to-service communication in distributed systems.

## Essential Syntax & Examples

### Standard Resilience Handler

```csharp
// Basic resilience configuration
services.AddHttpClient("MyApiClient", client =>
{
    client.BaseAddress = new Uri("https://api.example.com");
})
.AddStandardResilienceHandler()
.Configure(options =>
{
    options.Retry.MaxRetryAttempts = 3;
    options.CircuitBreaker.MinimumThroughput = 10;
    options.AttemptTimeout.Timeout = TimeSpan.FromSeconds(30);
});

// Usage
public class ApiService
{
    private readonly HttpClient _httpClient;

    public ApiService(IHttpClientFactory factory)
    {
        _httpClient = factory.CreateClient("MyApiClient");
    }

    public async Task<ApiResponse> GetDataAsync()
    {
        var response = await _httpClient.GetAsync("/api/data");
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadFromJsonAsync<ApiResponse>();
    }
}
```

### Standard Hedging Handler

```csharp
// Hedging configuration for parallel requests
services.AddHttpClient("FastApiClient")
    .AddStandardHedgingHandler()
    .Configure(options =>
    {
        options.TotalRequestTimeout.Timeout = TimeSpan.FromSeconds(10);
        options.Hedging.MaxHedgedAttempts = 2;
        options.Hedging.Delay = TimeSpan.FromMilliseconds(500);
    });
```

### Custom Resilience Pipeline

```csharp
// Custom resilience strategy composition
services.AddHttpClient("CustomClient")
    .AddResilienceHandler("customPipeline", builder =>
    {
        builder
            .AddFallback(new FallbackStrategyOptions<HttpResponseMessage>
            {
                FallbackAction = _ => Outcome.FromResultAsValueTask(
                    new HttpResponseMessage(HttpStatusCode.ServiceUnavailable))
            })
            .AddConcurrencyLimiter(maxConcurrency: 100)
            .AddRetry(new HttpRetryStrategyOptions
            {
                MaxRetryAttempts = 5,
                BackoffType = DelayBackoffType.Exponential,
                BaseDelay = TimeSpan.FromSeconds(1)
            })
            .AddCircuitBreaker(new HttpCircuitBreakerStrategyOptions
            {
                FailureRatio = 0.5,
                SamplingDuration = TimeSpan.FromMinutes(1),
                MinimumThroughput = 20
            })
            .AddTimeout(TimeSpan.FromSeconds(60));
    });
```
