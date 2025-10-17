# Microsoft.Extensions.AI
## Limitations and Considerations
### Function Definition Best Practices

Design AI functions with clear, descriptive signatures and documentation:

```csharp
/// <summary>
/// Gets the current weather conditions for a specified location.
/// </summary>
/// <param name="location">The city and state/country for the weather query</param>
/// <param name="unit">Temperature unit (celsius or fahrenheit)</param>
/// <returns>Current weather conditions including temperature and description</returns>
[Description("Gets current weather conditions for any location worldwide")]
public async Task<WeatherInfo> GetCurrentWeatherAsync(
    [Description("City name with optional state/country (e.g., 'Seattle, WA' or 'London, UK')")]
    string location,
    [Description("Temperature unit preference")]
    TemperatureUnit unit = TemperatureUnit.Fahrenheit)
{
    // Implementation
}
```

## Limitations and Considerations

### Preview Technology Constraints

Microsoft.Extensions.AI is currently in preview with potential API changes:

```csharp
// APIs may change before final release
// Pin to specific preview versions in production scenarios
<PackageReference Include="Microsoft.Extensions.AI" Version="9.0.0-preview.2" />
```

### Provider Capability Variations

Not all AI providers support identical capabilities:

```csharp
// Function calling may not be supported by all providers
try
{
    var response = await client.GetResponseAsync(messages, new ChatOptions { Tools = tools });
}
catch (NotSupportedException ex)
{
    // Fallback to non-function-calling approach
    var fallbackResponse = await client.GetResponseAsync(messages);
}
```

### Performance Considerations

Middleware composition adds layers that may impact performance:

```csharp
// Heavy middleware stacks may add latency
// Profile and measure in performance-critical scenarios
var client = new ChatClientBuilder()
    .UseLogging(logger)
    .UseDistributedCache(cache)
    .UseRateLimiting(rateLimiter)
    .UseRetry(retryPolicy)
    .UseOpenTelemetry(telemetry)
    .Use(providerClient)
    .Build(); // Each layer adds overhead
```
