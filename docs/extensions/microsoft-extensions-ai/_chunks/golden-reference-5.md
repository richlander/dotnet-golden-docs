# Microsoft.Extensions.AI
## Best Practices
### Middleware Composition Strategy

Order middleware thoughtfully to ensure proper request/response flow:

```csharp
// Recommended order: Caching -> Rate Limiting -> Telemetry -> Function Calling -> Provider
var client = new ChatClientBuilder()
    .UseDistributedCache(cache)           // Cache hits avoid downstream processing
    .UseRateLimiting(rateLimiter)        // Limit requests before expensive operations
    .UseOpenTelemetry(loggerFactory)     // Trace all operations including function calls
    .UseFunctionInvocation()             // Handle tool calls before reaching provider
    .Use(providerClient)                 // Actual AI service
    .Build();
```

### Error Handling and Resilience

Implement proper error handling and resilience patterns:

```csharp
public class ResilientChatClient : DelegatingChatClient
{
    private readonly IAsyncPolicy _retryPolicy;

    public override async Task<ChatResponse> GetResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        return await _retryPolicy.ExecuteAsync(async () =>
        {
            try
            {
                return await base.GetResponseAsync(messages, options, cancellationToken);
            }
            catch (HttpRequestException ex) when (IsTransientError(ex))
            {
                // Log and rethrow for retry
                throw;
            }
        });
    }
}
```

### Configuration Management

Use strongly-typed configuration for AI service settings:

```csharp
public class AIServiceOptions
{
    public string Provider { get; set; } = "OpenAI";
    public string ApiKey { get; set; } = "";
    public string ModelId { get; set; } = "gpt-4";
    public bool EnableCaching { get; set; } = true;
    public bool EnableTelemetry { get; set; } = true;
}

services.Configure<AIServiceOptions>(configuration.GetSection("AIService"));
services.AddSingleton<IChatClient>(serviceProvider =>
{
    var options = serviceProvider.GetRequiredService<IOptions<AIServiceOptions>>().Value;
    var builder = new ChatClientBuilder();

    if (options.EnableCaching)
        builder.UseDistributedCache(serviceProvider.GetRequiredService<IDistributedCache>());

    if (options.EnableTelemetry)
        builder.UseOpenTelemetry(serviceProvider.GetRequiredService<ILoggerFactory>());

    return builder.Use(CreateProviderClient(options)).Build();
});
```
