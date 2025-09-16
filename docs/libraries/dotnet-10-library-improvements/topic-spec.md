# .NET 10 Libraries Features - Topic Specification

## Feature Description
Collection topic covering key .NET 10 library improvements including numeric string comparison, WebSocket streaming APIs, JSON security enhancements, post-quantum cryptography, performance optimizations, span-based APIs, and stable tensor operations. Each feature gets concise treatment with practical examples for common scenarios.

## Hierarchy
**Category**: Libraries
**Complexity**: Beginner to intermediate
**Audience**: All developers
**Priority**: 2 (Common usage - multiple widely-requested features)

## Relationships
**Enables**: Natural string sorting, JSON security hardening, quantum-resistant cryptography, high-performance text processing
**Neutral**: Cross-platform development, native AOT compilation
**Conflicts with**: Legacy .NET Framework patterns, insecure JSON processing
**Alternative to**: Custom string comparers, third-party crypto libraries, manual normalization
**Synergistic with**: Performance-critical applications, security-focused development
**Prerequisite**: .NET 10 SDK

## Hints
**Flexible**: Features range from simple API additions to major security enhancements
**Emphasize**: Practical usage patterns, security improvements, performance benefits, migration from older approaches
**Avoid**: Deep cryptographic theory, complex enterprise scenarios, edge cases

## Critical limitations
- **NumericOrdering**: Only works with comparison operations, not IndexOf/StartsWith/EndsWith
- **Post-quantum crypto**: Requires specific platform support (OpenSSL 3.5+ or Windows CNG)
- **JSON duplicate detection**: Adds parsing overhead for security benefit
- **Span APIs**: Require careful lifetime management

## Key scenarios to cover
1. **Natural string sorting**: File names, version numbers with NumericOrdering
2. **WebSocket streaming**: Text protocols, JSON over WebSocket with Stream APIs
3. **Secure JSON processing**: Strict options and duplicate property prevention
4. **High-performance text**: UTF-8 hex conversion and span-based operations
5. **Future-proof cryptography**: Post-quantum algorithm usage
6. **Tensor computing**: Stable APIs with arithmetic operators and zero-copy slicing
7. **Collection performance**: OrderedDictionary optimizations
8. **Migration patterns**: Replacing custom implementations with built-in features

## Anti-patterns to avoid
- Using NumericOrdering with search operations (IndexOf, etc.)
- Ignoring security implications of duplicate JSON properties
- Manual span lifetime management errors
- Platform assumptions for post-quantum crypto availability