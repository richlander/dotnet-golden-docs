# Microsoft.Extensions.Http.Resilience
## Limitations and Considerations
### Configuration Management

Use environment-specific configuration for resilience settings:

```csharp
public class ResilienceConfigurationService
{
    public static void ConfigureEnvironmentSpecificResilience(
        IServiceCollection services,
        IConfiguration configuration,
        IWebHostEnvironment environment)
    {
        if (environment.IsDevelopment())
        {
            // Relaxed settings for development
            services.Configure<HttpStandardResilienceOptions>("default", options =>
            {
                options.Retry.MaxRetryAttempts = 1;
                options.CircuitBreaker.FailureRatio = 0.9;
            });
        }
        else if (environment.IsProduction())
        {
            // Robust settings for production
            services.Configure<HttpStandardResilienceOptions>("default", options =>
            {
                options.Retry.MaxRetryAttempts = 3;
                options.Retry.BackoffType = DelayBackoffType.Exponential;
                options.CircuitBreaker.FailureRatio = 0.5;
                options.CircuitBreaker.MinimumThroughput = 20;
            });
        }

        // Service-specific overrides from configuration
        services.Configure<HttpStandardResilienceOptions>("PaymentService",
            configuration.GetSection("Resilience:PaymentService"));
    }
}
```

## Limitations and Considerations

### Performance Impact

Resilience mechanisms add overhead that must be considered:

```csharp
// Monitor resilience overhead
public class PerformanceAwareResilienceService
{
    private readonly HttpClient _client;
    private readonly IMetrics _metrics;

    public async Task<T> ExecuteWithMetricsAsync<T>(
        Func<HttpClient, Task<T>> operation,
        string operationName)
    {
        using var timer = _metrics.StartTimer("http_request_duration",
            ("operation", operationName));

        try
        {
            var result = await operation(_client);
            _metrics.IncrementCounter("http_requests_total",
                ("operation", operationName), ("result", "success"));
            return result;
        }
        catch (Exception ex)
        {
            _metrics.IncrementCounter("http_requests_total",
                ("operation", operationName), ("result", "failure"));
            throw;
        }
    }
}
```

### Circuit Breaker State Management

Circuit breakers require careful monitoring and state management:

```csharp
public class CircuitBreakerManagementService
{
    private readonly ICircuitBreakerRegistry _registry;

    public async Task<bool> IsServiceHealthyAsync(string serviceName)
    {
        var circuitBreaker = _registry.GetCircuitBreaker(serviceName);
        return circuitBreaker?.State != CircuitBreakerState.Open;
    }

    public async Task ManuallyOpenCircuitBreakerAsync(string serviceName, string reason)
    {
        var circuitBreaker = _registry.GetCircuitBreaker(serviceName);
        if (circuitBreaker != null)
        {
            // Manual intervention for known issues
            await circuitBreaker.IsolateAsync();
            LogCircuitBreakerAction(serviceName, "manually_opened", reason);
        }
    }
}
```
