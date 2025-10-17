# Microsoft.Extensions.AI
## Essential Syntax & Examples
### Function Calling with Tool Invocation

```csharp
// Define a function that AI can call
string GetCurrentWeather(string location)
{
    return $"The weather in {location} is sunny and 72°F";
}

// Register function and use with chat client
var tools = new List<AIFunction>
{
    AIFunctionFactory.Create(GetCurrentWeather)
};

var response = await client.GetResponseAsync(
    "What's the weather like in Seattle?",
    new ChatOptions { Tools = tools }
);
```

### Embedding Generation

```csharp
// Generate embeddings for text
IEmbeddingGenerator<string, Embedding<float>> generator = GetEmbeddingGenerator();

var embeddings = await generator.GenerateAsync(new[]
{
    "Machine learning is fascinating",
    "I love programming in C#",
    "The weather is nice today"
});

foreach (var embedding in embeddings)
{
    Console.WriteLine($"Vector length: {embedding.Vector.Length}");
}
```

### Middleware Composition with ChatClientBuilder

```csharp
var client = new ChatClientBuilder()
    .UseDistributedCache(serviceProvider.GetRequiredService<IDistributedCache>())
    .UseFunctionInvocation()
    .UseOpenTelemetry(serviceProvider.GetRequiredService<ILoggerFactory>())
    .Use(underlyingChatClient)
    .Build();
```

### Dependency Injection Registration

```csharp
// Register in DI container
services.AddSingleton<IDistributedCache, MemoryDistributedCache>();
services.AddSingleton<IChatClient>(serviceProvider =>
{
    var underlyingClient = new SampleChatClient();

    return new ChatClientBuilder()
        .UseDistributedCache(serviceProvider.GetRequiredService<IDistributedCache>())
        .UseFunctionInvocation()
        .Use(underlyingClient)
        .Build();
});
```

### Custom Middleware Development

```csharp
public class RateLimitingChatClient : DelegatingChatClient
{
    private readonly RateLimiter _rateLimiter;

    public RateLimitingChatClient(IChatClient innerClient, RateLimiter rateLimiter)
        : base(innerClient)
    {
        _rateLimiter = rateLimiter;
    }

    public override async Task<ChatResponse> GetResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        using var lease = await _rateLimiter.AcquireAsync(cancellationToken: cancellationToken);
        if (!lease.IsAcquired)
        {
            throw new InvalidOperationException("Rate limit exceeded");
        }

        return await base.GetResponseAsync(messages, options, cancellationToken);
    }
}
```
