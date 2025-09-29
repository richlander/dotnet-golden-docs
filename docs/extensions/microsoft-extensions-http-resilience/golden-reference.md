# Microsoft.Extensions.Http.Resilience

## Overview

Microsoft.Extensions.Http.Resilience provides production-ready resilience mechanisms for HttpClient built on the proven Polly framework. It offers pre-configured resilience patterns that combine multiple strategies including retry policies, circuit breakers, hedging, rate limiting, and timeouts to ensure reliable HTTP communication in distributed applications.

What it is: A comprehensive resilience library that integrates with HttpClient factory to provide fault tolerance patterns through declarative configuration. Built on Polly, it offers both standard pre-configured pipelines and custom resilience strategy composition for HTTP-based communication reliability.

Core capabilities:

- Standard resilience pipeline: Pre-configured combination of retry, circuit breaker, rate limiter, and timeout strategies
- Standard hedging pipeline: Parallel request execution with circuit breaker pools for endpoint health awareness
- Custom pipeline construction: Flexible composition of resilience strategies for specific requirements
- HttpClient factory integration: Seamless integration with Microsoft.Extensions.Http for dependency injection
- Polly framework foundation: Built on mature, battle-tested resilience patterns and algorithms
- Configurable strategies: Fine-grained control over retry behavior, circuit breaker thresholds, and timeout values

When to use:

- Building production applications that consume external HTTP APIs
- Implementing microservices that require reliable inter-service communication
- Developing applications that need fault tolerance for network operations
- Creating HTTP clients that must handle transient failures gracefully
- Building systems that require protection against cascading failures
- Implementing applications with strict availability and reliability requirements

Key benefits:

- Production reliability: Proven resilience patterns reduce application failures
- Declarative configuration: Simple, readable resilience policy setup through fluent APIs
- Performance optimization: Intelligent request handling through hedging and circuit breaking
- Operational visibility: Built-in telemetry and monitoring for resilience events
- Framework integration: Works seamlessly with ASP.NET Core and HttpClient factory
- Flexible architecture: Supports both standard patterns and custom resilience strategies

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

## Common Scenarios

### Microservices Communication Reliability

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

### API Gateway Resilience Pattern

```csharp
public class ApiGatewayService
{
    private readonly Dictionary<string, HttpClient> _serviceClients;

    public ApiGatewayService(IHttpClientFactory factory)
    {
        _serviceClients = new Dictionary<string, HttpClient>
        {
            ["users"] = factory.CreateClient("UserService"),
            ["orders"] = factory.CreateClient("OrderService"),
            ["catalog"] = factory.CreateClient("CatalogService")
        };
    }

    public async Task<AggregatedResponse> GetDashboardDataAsync(string userId)
    {
        // Execute multiple service calls with resilience
        var tasks = new Dictionary<string, Task<HttpResponseMessage>>
        {
            ["user"] = _serviceClients["users"].GetAsync($"/api/users/{userId}"),
            ["orders"] = _serviceClients["orders"].GetAsync($"/api/orders/user/{userId}"),
            ["recommendations"] = _serviceClients["catalog"].GetAsync($"/api/recommendations/{userId}")
        };

        // Wait for all with timeout
        await Task.WhenAll(tasks.Values);

        var result = new AggregatedResponse();

        foreach (var task in tasks)
        {
            try
            {
                var response = await task.Value;
                if (response.IsSuccessStatusCode)
                {
                    result.Data[task.Key] = await response.Content.ReadAsStringAsync();
                }
                else
                {
                    result.Failures[task.Key] = $"HTTP {response.StatusCode}";
                }
            }
            catch (Exception ex)
            {
                result.Failures[task.Key] = ex.Message;
            }
        }

        return result;
    }
}
```

### External API Integration with Fallbacks

```csharp
public class WeatherService
{
    private readonly HttpClient _primaryWeatherClient;
    private readonly HttpClient _fallbackWeatherClient;
    private readonly IMemoryCache _cache;

    public async Task<WeatherData> GetWeatherAsync(string location)
    {
        // Try primary service with resilience
        try
        {
            var response = await _primaryWeatherClient.GetAsync($"/api/weather/{location}");
            if (response.IsSuccessStatusCode)
            {
                var data = await response.Content.ReadFromJsonAsync<WeatherData>();
                _cache.Set($"weather:{location}", data, TimeSpan.FromMinutes(30));
                return data;
            }
        }
        catch (Exception ex) when (IsRetryableException(ex))
        {
            // Primary service failed after retries, try fallback
        }

        // Try fallback service
        try
        {
            var response = await _fallbackWeatherClient.GetAsync($"/weather?q={location}");
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<WeatherData>();
            }
        }
        catch
        {
            // Both services failed, return cached data if available
        }

        // Return cached data as last resort
        if (_cache.TryGetValue($"weather:{location}", out WeatherData cached))
        {
            return cached;
        }

        throw new WeatherServiceUnavailableException("All weather services are currently unavailable");
    }
}
```

### Circuit Breaker Monitoring and Health Checks

```csharp
public class ResilienceHealthService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<ResilienceHealthService> _logger;

    public async Task<HealthReport> CheckServicesHealthAsync()
    {
        var healthChecks = new Dictionary<string, HealthStatus>();

        // Get circuit breaker states for monitored services
        var circuitBreakerStates = GetCircuitBreakerStates();

        foreach (var state in circuitBreakerStates)
        {
            healthChecks[state.Key] = state.Value switch
            {
                CircuitBreakerState.Closed => HealthStatus.Healthy,
                CircuitBreakerState.HalfOpen => HealthStatus.Degraded,
                CircuitBreakerState.Open => HealthStatus.Unhealthy,
                _ => HealthStatus.Unknown
            };
        }

        return new HealthReport(healthChecks);
    }

    private Dictionary<string, CircuitBreakerState> GetCircuitBreakerStates()
    {
        // Implementation to get circuit breaker states from Polly registry
        // This would typically involve accessing the circuit breaker instances
        // through the resilience pipeline registry
        return new Dictionary<string, CircuitBreakerState>();
    }
}
```

## Best Practices

### Resilience Strategy Selection

Choose appropriate resilience strategies based on service characteristics:

```csharp
public static class ResilienceProfiles
{
    public static void ConfigureCriticalService(HttpStandardResilienceOptions options)
    {
        // Conservative settings for critical services
        options.Retry.MaxRetryAttempts = 2;
        options.Retry.BaseDelay = TimeSpan.FromSeconds(1);
        options.CircuitBreaker.FailureRatio = 0.2;
        options.CircuitBreaker.MinimumThroughput = 5;
        options.AttemptTimeout.Timeout = TimeSpan.FromSeconds(30);
    }

    public static void ConfigureFastService(HttpStandardHedgingOptions options)
    {
        // Aggressive settings for fast, stateless services
        options.TotalRequestTimeout.Timeout = TimeSpan.FromSeconds(5);
        options.Hedging.MaxHedgedAttempts = 3;
        options.Hedging.Delay = TimeSpan.FromMilliseconds(200);
    }

    public static void ConfigureBulkService(HttpStandardResilienceOptions options)
    {
        // Patient settings for bulk operations
        options.Retry.MaxRetryAttempts = 5;
        options.Retry.BaseDelay = TimeSpan.FromSeconds(2);
        options.AttemptTimeout.Timeout = TimeSpan.FromMinutes(5);
        options.CircuitBreaker.FailureRatio = 0.8;
    }
}
```

### Observability and Monitoring

Implement comprehensive monitoring for resilience events:

```csharp
public class ResilienceObserver
{
    private readonly ILogger<ResilienceObserver> _logger;
    private readonly IMetrics _metrics;

    public ResilienceObserver(ILogger<ResilienceObserver> logger, IMetrics metrics)
    {
        _logger = logger;
        _metrics = metrics;
    }

    public void OnRetryExecuted(RetryExecutedEvent args)
    {
        _logger.LogWarning("Retry attempt {Attempt} for {OperationKey}. Duration: {Duration}ms",
            args.AttemptNumber, args.Context.OperationKey, args.Duration.TotalMilliseconds);

        _metrics.IncrementCounter("http_retries_total",
            ("operation", args.Context.OperationKey),
            ("attempt", args.AttemptNumber.ToString()));
    }

    public void OnCircuitBreakerStateChanged(CircuitBreakerStateChangedEvent args)
    {
        _logger.LogError("Circuit breaker state changed from {OldState} to {NewState} for {OperationKey}",
            args.OldState, args.NewState, args.Context.OperationKey);

        _metrics.SetGauge("circuit_breaker_state",
            args.NewState == CircuitBreakerState.Open ? 1 : 0,
            ("operation", args.Context.OperationKey));
    }
}
```

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

### Framework Compatibility

Address known compatibility issues:

```csharp
// Handle gRPC compatibility
public static class GrpcResilienceExtensions
{
    public static IHttpClientBuilder AddGrpcResilientClient<T>(
        this IServiceCollection services,
        Action<GrpcClientFactoryOptions> configureClient)
        where T : class
    {
        // Check for compatible gRPC version
        var grpcVersion = typeof(T).Assembly.GetName().Version;
        if (grpcVersion < new Version(2, 64, 0))
        {
            throw new InvalidOperationException(
                "gRPC resilience requires Grpc.Net.ClientFactory 2.64.0 or later");
        }

        return services.AddGrpcClient<T>(configureClient)
            .AddStandardResilienceHandler();
    }
}
```

### Resource Management

Implement proper resource management for resilience scenarios:

```csharp
public class ResourceAwareHttpService : IDisposable
{
    private readonly HttpClient _httpClient;
    private readonly SemaphoreSlim _concurrencyLimiter;
    private bool _disposed;

    public ResourceAwareHttpService(HttpClient httpClient, int maxConcurrency = 10)
    {
        _httpClient = httpClient;
        _concurrencyLimiter = new SemaphoreSlim(maxConcurrency, maxConcurrency);
    }

    public async Task<HttpResponseMessage> GetWithConcurrencyLimitAsync(string requestUri)
    {
        await _concurrencyLimiter.WaitAsync();
        try
        {
            return await _httpClient.GetAsync(requestUri);
        }
        finally
        {
            _concurrencyLimiter.Release();
        }
    }

    public void Dispose()
    {
        if (!_disposed)
        {
            _concurrencyLimiter?.Dispose();
            _disposed = true;
        }
    }
}
```