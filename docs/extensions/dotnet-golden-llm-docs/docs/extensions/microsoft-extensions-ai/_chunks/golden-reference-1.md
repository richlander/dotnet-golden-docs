# Microsoft.Extensions.AI
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
