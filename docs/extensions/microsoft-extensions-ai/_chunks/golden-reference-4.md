# Microsoft.Extensions.AI
## Alternative Syntax Options

Microsoft.Extensions.AI provides multiple approaches for different architectural needs:

### Direct Implementation vs Abstraction

```csharp
// Direct AI service usage (tightly coupled)
var openAIClient = new OpenAIClient(apiKey);
var response = await openAIClient.Chat.CompleteAsync("Hello");

// Using abstractions (loosely coupled)
IChatClient client = GetChatClient(); // Could be any provider
var response = await client.GetResponseAsync("Hello");
```

### Builder Pattern vs Direct Construction

```csharp
// Using ChatClientBuilder (recommended)
var client = new ChatClientBuilder()
    .UseDistributedCache(cache)
    .UseFunctionInvocation()
    .Use(underlyingClient)
    .Build();

// Direct construction (more verbose)
var cachingClient = new DistributedCachingChatClient(underlyingClient, cache);
var functionClient = new FunctionInvokingChatClient(cachingClient);
```

### Extension Method vs Explicit Middleware

```csharp
// Using extension methods (concise)
var client = new ChatClientBuilder()
    .UseRateLimiting(rateLimiter)
    .Use(underlyingClient)
    .Build();

// Explicit middleware construction
var client = new RateLimitingChatClient(underlyingClient, rateLimiter);
```

### Package Reference Strategy

```csharp
// Library authors - reference abstractions only
// <PackageReference Include="Microsoft.Extensions.AI.Abstractions" Version="9.0.0" />

public class MyAILibrary
{
    public MyAILibrary(IChatClient chatClient) { }
}

// Application developers - reference full package
// <PackageReference Include="Microsoft.Extensions.AI" Version="9.0.0" />
// <PackageReference Include="OpenAI" Version="2.0.0" />

services.AddSingleton<IChatClient, OpenAIChatClient>();
```

## Best Practices

### Interface Implementation Guidelines

Implement `IChatClient` or `IEmbeddingGenerator` when creating AI service adapters rather than exposing provider-specific APIs directly:

```csharp
// Good - implements standard interface
public class CustomAIChatClient : IChatClient
{
    public async Task<ChatResponse> GetResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        // Implementation details
    }
}

// Avoid - provider-specific surface area
public class CustomAIClient
{
    public async Task<CustomResponse> ChatAsync(CustomRequest request) { }
}
```
