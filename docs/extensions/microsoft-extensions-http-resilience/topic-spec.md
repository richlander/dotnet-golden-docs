# Microsoft.Extensions.Http.Resilience - Topic Specification

## Feature Description

Microsoft.Extensions.Http.Resilience provides resilience mechanisms for HttpClient built on the Polly framework. It offers pre-configured resilience patterns including retry policies, circuit breakers, hedging strategies, rate limiting, and timeouts to ensure reliable HTTP communication in production applications.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://www.nuget.org/packages/Microsoft.Extensions.Http.Resilience | rendered | Official NuGet package page | 2025-09-21 |
| https://www.pollydocs.org/ | rendered | Polly framework documentation | 2025-09-21 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/extensions | src/Libraries/Microsoft.Extensions.Http.Resilience/README.md | HTTP resilience library documentation | 2025-09-21 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |

## Metadata

| Property | Value |
| --- | --- |
| Name | Microsoft.Extensions.Http.Resilience |
| ID | microsoft-extensions-http-resilience |
| Category | Extensions |
| Namespace | Microsoft.Extensions.Http.Resilience |
| Description | Resilience mechanisms for HttpClient built on Polly framework with pre-configured patterns for retry, circuit breaking, hedging, and rate limiting. |
| Complexity | 0.7 |
| Audience | developers building HTTP clients, API consumers, microservice developers |
| Priority | 1 (High priority - essential for production HTTP reliability) |
| Version | 9.0 |
| Year | 2024 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | reliable HTTP communication, fault tolerance, production resilience |
| Neutral | specific HTTP APIs, cloud providers |
| Conflicts with | none |
| Alternative to | custom retry logic, manual circuit breaker implementation |
| Synergistic with | HttpClient factory, Polly, Microsoft.Extensions.DependencyInjection |
| Prerequisite | .NET 8+, Microsoft.Extensions.Http |

## Keywords

| Keyword | Score |
|---------|-------|
| circuit breaker | 4.68 |
| microsoft.extensions.http.resilience | 4.68 |
| pre-configured | 4.68 |
| custom resilience | 4.67 |
| resource management | 4.67 |
| resilience | 3.34 |
| http | 3.18 |
| communication | 3.16 |
| httpclient | 3.16 |
| monitoring | 3.15 |
| strategies | 3.15 |
| built | 3.14 |

## APIs

| API | Type | Count |
|-----|------|-------|
| TimeSpan.FromSeconds | method | 9 |
| GetAsync | method | 7 |
| AddHttpClient | method | 6 |
| CreateClient | method | 6 |
| AddStandardResilienceHandler | method | 4 |
| Configure | method | 4 |
| IncrementCounter | method | 3 |
| OrderResult.Failed | method | 3 |
| TimeSpan.FromMinutes | method | 3 |
| Uri | method | 3 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| extensions | extensions/microsoft-extensions-ai | 0.6811 |
| libraries | libraries | 0.6457 |
| extensions | extensions/microsoft-extensions-ai-evaluation | 0.6424 |
| dotnet | dotnet | 0.6271 |
| libraries | libraries/dotnet-10-library-improvements | 0.6244 |
| cli | cli/publishing-and-deployment | 0.6171 |
| csharp | csharp/csharp-14-features | 0.6045 |
| cli | cli/assembly-trimming | 0.6045 |
| libraries | libraries/system-text-json | 0.6027 |
| cli | cli/build-and-compilation | 0.5987 |
| cli | cli | 0.5916 |
| csharp | csharp | 0.5520 |

## Critical limitations

- Adds latency overhead due to resilience mechanisms
- Requires careful configuration to avoid masking underlying issues
- Circuit breaker state shared across HttpClient instances by default
- Hedging increases resource consumption by making parallel requests
- Compatibility considerations with specific frameworks (gRPC, Application Insights)

## Key scenarios to cover

1. Standard resilience handler configuration and usage
2. Standard hedging handler setup for parallel requests
3. Custom resilience pipeline construction
4. Circuit breaker configuration and monitoring
5. Retry policy customization and exponential backoff
6. Rate limiting configuration for outbound requests
7. Timeout configuration at multiple levels
8. Integration with HttpClient factory and dependency injection
9. Monitoring and observability of resilience events
10. Troubleshooting common resilience issues and anti-patterns

## Anti-patterns to avoid

- Using resilience mechanisms to hide underlying service issues
- Configuring overly aggressive retry policies that amplify problems
- Not monitoring circuit breaker state and resilience metrics
- Applying same resilience configuration to all HTTP clients regardless of characteristics
- Ignoring compatibility requirements with other frameworks
