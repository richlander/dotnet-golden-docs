# Microsoft.Extensions.AI - Q&A Pairs

## Basic Concepts

Q: What is Microsoft.Extensions.AI?
A: Microsoft.Extensions.AI is a set of libraries that provide a unified approach for .NET developers to integrate and interact with AI services. It includes standardized interfaces like IChatClient and IEmbeddingGenerator, along with middleware and utilities for building AI-powered applications.

Q: What are the two main packages in Microsoft.Extensions.AI?
A: The two main packages are Microsoft.Extensions.AI.Abstractions (containing core interfaces and types) and Microsoft.Extensions.AI (containing higher-level utilities, middleware, and extensions).

Q: Which package should library authors reference?
A: Library authors should typically reference only Microsoft.Extensions.AI.Abstractions to implement the standard interfaces without pulling in additional dependencies.

Q: Which package should application developers reference?
A: Application developers should reference Microsoft.Extensions.AI, which includes the abstractions package and provides additional middleware, utilities, and extensions for building complete AI applications.

## Core Interfaces

Q: What is IChatClient?
A: IChatClient is the primary interface for interacting with AI chat/completion services. It provides methods for sending messages and receiving responses, both streaming and non-streaming, along with support for multi-modal content and function calling.

Q: What is IEmbeddingGenerator?
A: IEmbeddingGenerator<TInput, TEmbedding> is an interface for generating embeddings from input data. It takes input values of type TInput and produces embeddings of type TEmbedding, commonly used for semantic search and similarity operations.

Q: How do you get a basic chat response?
A: Use the GetResponseAsync method: `var response = await client.GetResponseAsync("Your message here");`

Q: How do you get a streaming chat response?
A: Use GetStreamingResponseAsync with foreach: `await foreach (var update in client.GetStreamingResponseAsync("Your message")) { Console.Write(update.Text); }`

## Function Calling

Q: What is function calling in Microsoft.Extensions.AI?
A: Function calling allows AI models to invoke .NET methods as tools during conversations. The AI can request function execution with specific arguments, receive results, and incorporate them into responses.

Q: How do you create an AI function from a .NET method?
A: Use AIFunctionFactory.Create(): `var function = AIFunctionFactory.Create(myMethod);`

Q: How do you enable automatic function invocation?
A: Use the UseFunctionInvocation() extension when building a client: `new ChatClientBuilder().UseFunctionInvocation().Use(underlyingClient).Build();`

Q: What should you consider when designing functions for AI invocation?
A: Functions should be safe for AI invocation, avoid sensitive operations, have clear descriptions, and use descriptive parameter names. Avoid functions that modify critical system state.

## Middleware and Composition

Q: What is the ChatClientBuilder used for?
A: ChatClientBuilder provides a fluent API for composing middleware around AI chat clients, allowing you to layer functionality like caching, telemetry, rate limiting, and function calling.

Q: How do you add caching to a chat client?
A: Use the UseDistributedCache extension: `new ChatClientBuilder().UseDistributedCache(cache).Use(underlyingClient).Build();`

Q: How do you add telemetry to a chat client?
A: Use the UseOpenTelemetry extension: `new ChatClientBuilder().UseOpenTelemetry(loggerFactory).Use(underlyingClient).Build();`

Q: What is the recommended order for middleware composition?
A: A recommended order is: Caching -> Rate Limiting -> Telemetry -> Function Calling -> AI Provider. This ensures cache hits avoid downstream processing and telemetry captures all operations.

## Dependency Injection

Q: How do you register IChatClient in dependency injection?
A: Register as a singleton with a factory: `services.AddSingleton<IChatClient>(serviceProvider => /* build client */);`

Q: Can you register multiple IChatClient instances?
A: Yes, you can register multiple instances using keyed services or different interfaces, allowing different configurations for different scenarios.

Q: How do middleware components access other DI services?
A: Middleware extension methods can accept an IServiceProvider parameter to resolve additional services from the DI container.

## Custom Middleware

Q: How do you create custom middleware for IChatClient?
A: Inherit from DelegatingChatClient and override the methods you want to augment: `public class CustomClient : DelegatingChatClient { ... }`

Q: What is DelegatingChatClient?
A: DelegatingChatClient is a base class that forwards all operations to an inner IChatClient, allowing you to override only specific methods while delegating others.

Q: How do you create extension methods for custom middleware?
A: Create extension methods on ChatClientBuilder that return the builder with your middleware added: `public static ChatClientBuilder UseCustom(this ChatClientBuilder builder) { ... }`

## Configuration and Options

Q: How do you provide options to chat requests?
A: Pass a ChatOptions instance to GetResponseAsync or GetStreamingResponseAsync: `await client.GetResponseAsync(messages, new ChatOptions { Temperature = 0.7 });`

Q: How do you set default options for a chat client?
A: Use the ConfigureOptions extension when building: `new ChatClientBuilder().ConfigureOptions(options => options.ModelId = "gpt-4").Build();`

Q: What are strongly-typed vs weakly-typed options?
A: Strongly-typed options are properties on ChatOptions (like Temperature), while weakly-typed options use the AdditionalProperties dictionary for provider-specific settings.

## Error Handling and Resilience

Q: How do you handle errors in chat client operations?
A: Use standard try-catch blocks and consider implementing retry policies through custom middleware for transient failures.

Q: How do you implement retry logic for AI operations?
A: Create custom middleware using DelegatingChatClient and implement retry logic using libraries like Polly.

Q: What happens if a function call fails during AI interaction?
A: Function call failures are typically returned to the AI as error results, allowing the AI to handle or retry the operation.

## Performance and Caching

Q: How does caching work with Microsoft.Extensions.AI?
A: Caching middleware intercepts requests and stores responses based on message history. Identical requests return cached responses instead of calling the underlying AI service.

Q: What determines cache effectiveness?
A: Cache effectiveness depends on request similarity, deterministic serialization, and cache key generation based on message content and options.

Q: How do you handle memory management with streaming responses?
A: Process streaming updates immediately rather than accumulating them, and properly dispose of async enumerable resources.

## Provider Integration

Q: How do you switch between different AI providers?
A: Write code against IChatClient interface and change the underlying implementation based on configuration, without modifying application logic.

Q: Do all AI providers support the same features?
A: No, providers have different capabilities. Some may not support function calling, streaming, or specific options. Handle NotSupportedException for unsupported features.

Q: How do you handle provider-specific configuration?
A: Use the AdditionalProperties dictionary in ChatOptions or the RawRepresentationFactory for provider-specific settings.

## Troubleshooting

Q: Why isn't my function being called by the AI?
A: Check that: 1) The function is properly registered in Tools, 2) The AI provider supports function calling, 3) The function has clear descriptions, 4) The AI request context suggests tool usage.

Q: Why aren't my cached responses being used?
A: Verify that: 1) Cache keys are deterministic, 2) Message content is identical, 3) Cache isn't expired, 4) Serialization is consistent.

Q: How do you debug middleware composition issues?
A: Add logging middleware to trace request flow, check middleware ordering, and verify each middleware is properly delegating to the next in the pipeline.

Q: What .NET version is required for Microsoft.Extensions.AI?
A: Microsoft.Extensions.AI requires .NET 9.0 or later.

Q: Is Microsoft.Extensions.AI production-ready?
A: Microsoft.Extensions.AI is currently in preview. While it can be used, be prepared for potential API changes before the final release.