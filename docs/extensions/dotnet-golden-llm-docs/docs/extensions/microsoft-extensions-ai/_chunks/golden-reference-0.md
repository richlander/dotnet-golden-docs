# Microsoft.Extensions.AI

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
