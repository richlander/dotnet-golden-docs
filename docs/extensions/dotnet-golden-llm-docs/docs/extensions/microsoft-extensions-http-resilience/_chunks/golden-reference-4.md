# Microsoft.Extensions.Http.Resilience
## Best Practices
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
