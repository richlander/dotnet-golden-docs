# Microsoft.Extensions.AI - Golden Reference

## Overview

Microsoft.Extensions.AI provides a unified approach for .NET developers to integrate and interact with artificial intelligence (AI) services in their applications. This library enables seamless integration and interoperability across different AI components through standardized interfaces, familiar dependency injection patterns, and composable middleware architecture.

What it is: A set of abstractions and utilities that standardize how .NET applications interact with AI services. The library defines core interfaces like `IChatClient` and `IEmbeddingGenerator` that any AI service can implement, allowing applications to switch between providers without code changes. Built on familiar .NET patterns like dependency injection and middleware composition.

Core capabilities:

- Standardized interfaces: `IChatClient` for chat/completion services and `IEmbeddingGenerator` for embedding generation
- Middleware composition: Layer functionality like caching, telemetry, and rate limiting around AI services
- Dependency injection integration: Register and configure AI services using standard .NET DI patterns
- Function calling support: Automatic tool invocation with strongly-typed .NET method binding
- Observability: Built-in OpenTelemetry support following semantic conventions for AI systems
- Cross-provider portability: Switch between AI providers without changing application code

When to use:

- Building applications that consume multiple AI services
- Creating libraries that provide AI functionality without vendor lock-in
- Adding observability and middleware to AI service calls
- Implementing function/tool calling scenarios
- Requiring caching, rate limiting, or other cross-cutting concerns for AI operations
- Developing applications that need AI provider flexibility

Key benefits:

- Provider independence: Write code against abstractions, not specific AI service SDKs
- Middleware ecosystem: Compose functionality like caching and telemetry declaratively
- Familiar patterns: Uses standard .NET dependency injection and middleware concepts
- Testing support: Mock and test AI interactions using standard interfaces
- Ecosystem interoperability: Libraries implementing these interfaces work together seamlessly
- Future-proof architecture: Add new AI providers or middleware without breaking changes

## Relationships & Integration

Ecosystem positioning: Microsoft.Extensions.AI sits at the intersection of AI services and .NET applications, providing the abstraction layer that enables AI provider independence while maintaining familiar .NET development patterns.

Package architecture: The library follows a two-package design where `Microsoft.Extensions.AI.Abstractions` contains only the core interfaces and types, while `Microsoft.Extensions.AI` adds higher-level utilities and middleware implementations.

Dependency injection integration: Seamlessly integrates with `Microsoft.Extensions.DependencyInjection`, allowing AI services to be registered, configured, and injected like any other .NET service with support for named registrations and configuration.

OpenTelemetry integration: Provides built-in observability through OpenTelemetry following the semantic conventions for generative AI systems, enabling comprehensive monitoring and tracing of AI operations.

Middleware composition: Uses a builder pattern similar to ASP.NET Core middleware, allowing functionality to be layered around AI services in a declarative, configurable manner.

Function calling ecosystem: Integrates with the broader .NET ecosystem by enabling AI services to call arbitrary .NET methods as tools, bridging AI capabilities with existing business logic.

## Essential Syntax & Examples

### Basic Chat Client Usage

```csharp
// Simple chat interaction
IChatClient client = GetChatClient();

var response = await client.GetResponseAsync("What is the capital of France?");
Console.WriteLine(response.Message.Text);
```

### Streaming Chat Responses

```csharp
// Stream responses for real-time UI updates
await foreach (var update in client.GetStreamingResponseAsync("Tell me a story"))
{
    Console.Write(update.Text);
}
```

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

## Common Scenarios

### Multi-Turn Conversation Management

```csharp
var messages = new List<ChatMessage>();

while (true)
{
    Console.Write("You: ");
    string userInput = Console.ReadLine();
    if (string.IsNullOrEmpty(userInput)) break;

    messages.Add(new ChatMessage(ChatRole.User, userInput));

    var response = await client.GetResponseAsync(messages);
    Console.WriteLine($"AI: {response.Message.Text}");

    // Add response to conversation history
    messages.AddRange(response.Messages);
}
```

### Structured Output with Function Calling

```csharp
public record WeatherInfo(string Location, int Temperature, string Conditions);

WeatherInfo GetWeatherData(string location)
{
    // Simulate weather API call
    return new WeatherInfo(location, 75, "Sunny");
}

var tools = new List<AIFunction>
{
    AIFunctionFactory.Create(GetWeatherData)
};

var response = await client.GetResponseAsync(
    "Get me weather data for New York in a structured format",
    new ChatOptions { Tools = tools }
);
```

### Caching AI Responses

```csharp
services.AddMemoryCache();
services.AddSingleton<IChatClient>(serviceProvider =>
{
    var underlyingClient = new OpenAIChatClient();
    var cache = serviceProvider.GetRequiredService<IMemoryCache>();

    return new ChatClientBuilder()
        .UseDistributedCache(new MemoryDistributedCache(Options.Create(new MemoryDistributedCacheOptions())))
        .Use(underlyingClient)
        .Build();
});
```

### Cross-Provider Switching

```csharp
// Configuration-driven provider selection
IChatClient client = configuration["AIProvider"] switch
{
    "OpenAI" => new OpenAIChatClient(apiKey),
    "Azure" => new AzureOpenAIChatClient(endpoint, apiKey),
    "Local" => new OllamaChatClient(baseUri),
    _ => throw new InvalidOperationException("Unknown AI provider")
};

// Application code remains the same regardless of provider
var response = await client.GetResponseAsync("Hello, world!");
```

### Telemetry and Observability

```csharp
services.AddOpenTelemetry()
    .WithTracing(builder => builder.AddSource("Microsoft.Extensions.AI"));

var client = new ChatClientBuilder()
    .UseOpenTelemetry(loggerFactory, "MyApp")
    .Use(underlyingClient)
    .Build();

// All AI interactions are automatically traced
var response = await client.GetResponseAsync("Analyze this data");
```

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

### Memory Management

Streaming scenarios require careful memory management:

```csharp
// Properly dispose of streaming resources
await using var responseStream = client.GetStreamingResponseAsync(messages);
await foreach (var update in responseStream)
{
    // Process updates immediately rather than accumulating
    ProcessUpdate(update);
}
```

### Caching Key Sensitivity

Caching effectiveness depends on message similarity and deterministic serialization:

```csharp
// Cache keys are based on message content
// Small variations prevent cache hits
var messages1 = new[] { new ChatMessage(ChatRole.User, "Hello") };
var messages2 = new[] { new ChatMessage(ChatRole.User, "hello") }; // Different cache key
```

### Function Calling Security

AI-invoked functions execute with application permissions:

```csharp
// Ensure functions are safe for AI invocation
// Avoid functions that modify critical system state
[Description("Gets read-only information about system status")]
public SystemInfo GetSystemInfo() => new(); // Safe

// Avoid exposing dangerous operations
// public void DeleteAllFiles() => ...; // Dangerous for AI invocation
```