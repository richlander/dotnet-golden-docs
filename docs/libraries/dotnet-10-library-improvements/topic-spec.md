# .NET 10 Libraries Features - Topic Specification

## Feature Description
Collection topic covering key .NET 10 library improvements including numeric string comparison, WebSocket streaming APIs, JSON security enhancements, post-quantum cryptography, performance optimizations, span-based APIs, and stable tensor operations. Each feature gets concise treatment with practical examples for common scenarios.

## Metadata
Name: .NET 10 Libraries Features
ID: dotnet-10-library-improvements
Category: Libraries
Description: Collection topic covering key .NET 10 library improvements including numeric string comparison, WebSocket streaming APIs, JSON security enhancements, post-quantum cryptography, performance optimizations, span-based APIs, and stable tensor operations.
Complexity: 0.5
Audience: All developers
Priority: 2 (Common usage - multiple widely-requested features)
Introduced-Version: 10.0
Introduced-Year: 2025

## Relationships
Enables: Natural string sorting, JSON security hardening, quantum-resistant cryptography, high-performance text processing
Neutral: Cross-platform development, native AOT compilation
Conflicts with: Legacy .NET Framework patterns, insecure JSON processing
Alternative to: Custom string comparers, third-party crypto libraries, manual normalization
Synergistic with: Performance-critical applications, security-focused development
Prerequisite: .NET 10 SDK

## Official Sources
Documentation: https://docs.microsoft.com/dotnet/core/whats-new/dotnet-10/libraries
Announcement: https://devblogs.microsoft.com/dotnet/announcing-dotnet-10/

## Primary Sources
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/whats-new/dotnet-10/libraries.md
- https://raw.githubusercontent.com/dotnet/core/main/release-notes/10.0/10.0.0/10.0.0.md

## Secondary Sources
- https://github.com/dotnet/runtime/releases/tag/v10.0.0
- Community migration guides and performance benchmarks
- Stack Overflow discussions on .NET 10 features

## Hints
Flexible: Features range from simple API additions to major security enhancements
Emphasize: Practical usage patterns, security improvements, performance benefits, migration from older approaches
Avoid: Deep cryptographic theory, complex enterprise scenarios, edge cases

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
