# Microsoft.Extensions.Http.Resilience - Topic Specification

## Feature Description

Microsoft.Extensions.Http.Resilience provides resilience mechanisms for HttpClient built on the Polly framework. It offers pre-configured resilience patterns including retry policies, circuit breakers, hedging strategies, rate limiting, and timeouts to ensure reliable HTTP communication in production applications.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/extensions | src/Libraries/Microsoft.Extensions.Http.Resilience/README.md | HTTP resilience library documentation | 2025-09-21 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://www.nuget.org/packages/Microsoft.Extensions.Http.Resilience | rendered | Official NuGet package page | 2025-09-21 |
| https://www.pollydocs.org/ | rendered | Polly framework documentation | 2025-09-21 |

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

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 12996737634408334202 |
| technical | simhash | 12992238638986035580 |

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
| resilience | 25.00 |
| http | 9.00 |
| communication | 7.00 |
| standard | 7.00 |
| microsoft.extensions.http.resilience | 3.00 |
| monitoring | 6.00 |
| strategies | 6.00 |
| built | 5.00 |
| circuit | 5.00 |
| httpclient | 5.00 |
| microsoft | 5.00 |
| polly | 5.00 |

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
| libraries | libraries/system-threading-tasks-task | 0.6273 |
| dotnet | dotnet | 0.6271 |
| libraries | libraries/system-text-json | 0.6259 |
| libraries | libraries/dotnet-10-library-improvements | 0.6244 |
| libraries | libraries/system-text-json-dotnet-10 | 0.6177 |
| cli | cli/publishing-and-deployment | 0.6171 |
| libraries | libraries/json-validation-security | 0.6161 |
| csharp | csharp/csharp-14-features | 0.6045 |
| cli | cli/assembly-trimming | 0.6045 |

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

## Chunks

**Source**: `golden-reference.md`
**Count**: 6
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.727 |
| 1 | Custom Resilience Pipeline | 0.727 | 1.000 |
| 2 | Resilience with Custom Logic | 0.634 | 0.709 |
| 3 | External API Integration with Fallbacks | 0.634 | 0.669 |
| 4 | Observability and Monitoring | 0.588 | 0.598 |
| 5 | Circuit Breaker State Management | 0.615 | 0.607 |
