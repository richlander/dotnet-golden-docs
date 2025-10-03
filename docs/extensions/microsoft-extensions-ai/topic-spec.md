# Microsoft.Extensions.AI - Topic Specification

## Feature Description

Microsoft.Extensions.AI provides a unified approach for .NET developers to integrate and interact with artificial intelligence (AI) services in their applications. It offers standardized interfaces and higher-level utilities for working with generative AI components, enabling seamless integration and interoperability with various AI services through familiar dependency injection and middleware patterns.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/ai/microsoft-extensions-ai | rendered | Official Microsoft Learn documentation | 2025-09-21 |
| https://www.nuget.org/packages/Microsoft.Extensions.AI | rendered | Official NuGet package page | 2025-09-21 |
| https://devblogs.microsoft.com/dotnet/introducing-microsoft-extensions-ai-preview/ | rendered | Introducing Microsoft.Extensions.AI Preview blog post | 2025-09-21 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/ai/microsoft-extensions-ai.md | Microsoft.Extensions.AI libraries documentation | 2025-09-21 |
| dotnet/extensions | src/Libraries/Microsoft.Extensions.AI/README.md | Official repository README | 2025-09-21 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |

## Metadata

| Property | Value |
| --- | --- |
| Name | Microsoft.Extensions.AI |
| ID | microsoft-extensions-ai |
| Category | Extensions |
| Namespace | Microsoft.Extensions.AI |
| Description | Unified approach for .NET developers to integrate and interact with AI services through standardized interfaces and middleware patterns. |
| Complexity | 0.6 |
| Audience | developers working with AI services, library authors implementing AI clients |
| Priority | 1 (High priority - emerging core technology) |
| Version | 9.0 |
| Year | 2024 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | AI service integration, cross-provider portability, AI middleware composition |
| Neutral | specific AI providers, machine learning frameworks |
| Conflicts with | tightly coupled AI implementations |
| Alternative to | direct AI service SDKs, custom AI abstractions |
| Synergistic with | dependency injection, OpenTelemetry, Microsoft.Extensions.Caching |
| Prerequisite | .NET 9+ |

## Keywords

| Keyword | Score |
|---------|-------|
| microsoft.extensions.ai | 4.57 |
| middleware composition | 4.57 |
| function calling | 4.55 |
| embedding generation | 4.52 |
| strongly-typed | 4.52 |
| tool invocation | 4.52 |
| dependency injection | 3.57 |
| middleware | 3.11 |
| services | 3.10 |
| interfaces | 3.06 |
| observability | 3.04 |
| provider | 3.04 |

## APIs

| API | Type | Count |
|-----|------|-------|
| GetResponseAsync | method | 16 |
| ChatClientBuilder | method | 14 |
| Build | method | 13 |
| Use | method | 12 |
| UseDistributedCache | method | 8 |
| Microsoft.Extensions | namespace | 6 |
| Microsoft.Extensions.AI | type | 6 |
| UseOpenTelemetry | method | 6 |
| UseFunctionInvocation | method | 5 |
| Description | attribute | 4 |
| AIFunctionFactory.Create | method | 3 |
| ChatMessage | method | 3 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| extensions | extensions/microsoft-extensions-ai-evaluation | 0.8279 |
| libraries | libraries | 0.7133 |
| dotnet | dotnet | 0.7043 |
| extensions | extensions/microsoft-extensions-http-resilience | 0.6811 |
| libraries | libraries/dotnet-10-library-improvements | 0.6650 |
| cli | cli | 0.6615 |
| csharp | csharp/csharp-14-features | 0.6469 |
| cli | cli/file-based-apps | 0.6440 |
| cli | cli/native-aot | 0.6401 |
| libraries | libraries/system-commandline | 0.6293 |
| csharp | csharp | 0.6054 |
| cli | cli/assembly-trimming | 0.5959 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| libraries | dependency injection | 1.357 |

## Critical limitations

- Preview/early stage technology with potential API changes
- Requires .NET 9 or later
- Abstract interfaces require concrete AI service implementations
- Function calling requires AI service support for tools
- Caching effectiveness depends on request similarity

## Key scenarios to cover

1. Basic chat client usage with IChatClient interface
2. Streaming responses with IAsyncEnumerable patterns
3. Function/tool calling with automatic invocation
4. Embedding generation with IEmbeddingGenerator
5. Middleware composition (caching, telemetry, rate limiting)
6. Dependency injection registration and configuration
7. Custom middleware development with DelegatingChatClient
8. Cross-provider portability scenarios
9. OpenTelemetry integration for observability
10. Stateless vs stateful conversation handling

## Anti-patterns to avoid

- Directly implementing interfaces instead of using provided abstractions
- Ignoring middleware composition capabilities
- Not leveraging dependency injection patterns
- Mixing multiple AI providers without abstraction layer
- Missing telemetry and observability integration
