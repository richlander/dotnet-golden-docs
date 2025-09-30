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
| span-based | 4.54 |
| high-performance text processing | 4.52 |
| net 10 | 4.52 |
| post-quantum cryptography | 4.52 |
| quantum-resistant | 4.52 |
| string | 3.05 |
| improvements | 3.04 |
| algorithms | 3.03 |
| comparison | 3.03 |
| cryptography | 3.03 |
| duplicate | 3.03 |
| hex | 3.03 |

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
