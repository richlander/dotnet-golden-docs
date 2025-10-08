# .NET 10 Libraries Features - Topic Specification

## Feature Description

Collection topic covering key .NET 10 library improvements including numeric string comparison, WebSocket streaming APIs, JSON security enhancements, post-quantum cryptography, performance optimizations, span-based APIs, and stable tensor operations. Each feature gets concise treatment with practical examples for common scenarios.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/whats-new/dotnet-10/libraries | rendered | Main .NET 10 library improvements documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-dotnet-10/ | rendered | Official .NET 10 announcement | 404 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements documentation | 0249c38f27 |
| dotnet/core | release-notes/10.0/preview | .NET 10.0.0 release notes | 4c489a6a |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |

## Metadata

| Property | Value |
| --- | --- |
| Name | .NET 10 Libraries Features |
| ID | dotnet-10-library-improvements |
| Category | Libraries |
| Description | Collection topic covering key .NET 10 library improvements including numeric string comparison, WebSocket streaming APIs, JSON security enhancements, post-quantum cryptography, performance optimizations, span-based APIs, and stable tensor operations. |
| Complexity | 0.8 |
| Audience | All developers |
| Priority | 2 (Common usage - multiple widely-requested features) |
| Version | 10.0 |
| Year | 2025 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 17751807734389736240 |
| technical | simhash | 17603750934576243000 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Natural string sorting, JSON security hardening, quantum-resistant cryptography, high-performance text processing |
| Neutral | Cross-platform development, native AOT compilation |
| Conflicts with | Legacy .NET Framework patterns, insecure JSON processing |
| Alternative to | Custom string comparers, third-party crypto libraries, manual normalization |
| Synergistic with | Performance-critical applications, security-focused development |
| Prerequisite | .NET 10 SDK |

## Keywords

| Keyword | Score |
|---------|-------|
| security | 9.00 |
| json | 9.00 |
| net 10 | 2.00 |
| span-based | 3.00 |
| improvements | 4.00 |
| apis | 5.00 |
| high-performance text processing | 2.00 |
| post-quantum cryptography | 2.00 |
| algorithms | 3.00 |
| comparison | 3.00 |
| cryptography | 3.00 |
| duplicate | 3.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| StringComparer.Create | method | 3 |
| WebSocketStream.Create | method | 3 |
| WebSocketStream.CreateReadableMessageStream | method | 3 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp/csharp-14-features | 0.7967 |
| libraries | libraries | 0.7945 |
| libraries | libraries/system-text-json | 0.7690 |
| dotnet | dotnet | 0.7626 |
| csharp | csharp | 0.7352 |
| libraries | libraries/string-search-operations | 0.7306 |
| libraries | libraries/system-buffers-searchvalues | 0.7137 |
| cli | cli/file-based-apps | 0.6961 |
| csharp | csharp/object-initialization | 0.6824 |
| cli | cli | 0.6809 |
| cli | cli/assembly-trimming | 0.6727 |
| extensions | extensions/microsoft-extensions-ai | 0.6650 |

## Critical limitations

- NumericOrdering: Only works with comparison operations, not IndexOf/StartsWith/EndsWith
- Post-quantum crypto: Requires specific platform support (OpenSSL 3.5+ or Windows CNG)
- JSON duplicate detection: Adds parsing overhead for security benefit
- Span APIs: Require careful lifetime management

## Key scenarios to cover

1. Natural string sorting: File names, version numbers with NumericOrdering
2. WebSocket streaming: Text protocols, JSON over WebSocket with Stream APIs
3. Secure JSON processing: Strict options and duplicate property prevention
4. High-performance text: UTF-8 hex conversion and span-based operations
5. Future-proof cryptography: Post-quantum algorithm usage
6. Tensor computing: Stable APIs with arithmetic operators and zero-copy slicing
7. Collection performance: OrderedDictionary optimizations
8. Migration patterns: Replacing custom implementations with built-in features

## Anti-patterns to avoid

- Using NumericOrdering with search operations (IndexOf, etc.)
- Ignoring security implications of duplicate JSON properties
- Manual span lifetime management errors
- Platform assumptions for post-quantum crypto availability
