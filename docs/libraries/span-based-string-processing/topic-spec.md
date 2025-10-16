# Span-Based String Processing - Topic Specification

## Feature Description

Span-based string processing enables high-performance text operations without heap allocations by using `Span<char>`, `ReadOnlySpan<char>`, and related types. This approach allows developers to process strings, perform conversions, and manipulate text data with minimal memory overhead. The .NET runtime and libraries provide extensive support for span-based operations including UTF-8 processing without string conversions, span-based Unicode normalization, hex string conversion using UTF-8 spans, and pattern matching directly on `ReadOnlySpan<char>`. These techniques eliminate temporary string allocations, reduce garbage collection pressure, and enable efficient text processing in performance-critical scenarios while maintaining type safety and readability.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements | 2025-10-15 |
| dotnet/docs | docs/standard/base-types/memory-and-spans.md | Span and Memory documentation | 2025-10-15 |
| dotnet/docs | docs/csharp/whats-new/csharp-14.md | C# 14 span features | 2025-10-15 |
| dotnet/docs | docs/csharp/whats-new/csharp-11.md | C# 11 UTF-8 literals and span patterns | 2025-10-15 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/whats-new/dotnet-10 | rendered | .NET 10 what's new documentation | 2025-10-15 |
| https://docs.microsoft.com/dotnet/api/system.span-1 | rendered | `Span<T>` API documentation | 2025-10-15 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/runtime | rendered | .NET runtime implementation repository | 2025-10-15 |
| https://devblogs.microsoft.com/dotnet/ | rendered | .NET Blog for performance discussions | 2025-10-15 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Span-Based String Processing |
| ID | span-based-string-processing |
| Category | .NET Libraries |
| Namespace | System, System.Text |
| Description | High-performance text operations using `Span<char>` and `ReadOnlySpan<char>` including UTF-8 processing, string normalization, hex conversion, and pattern matching without allocations. |
| Complexity | 0.8 |
| Audience | performance engineers, library authors, advanced developers |
| Priority | 2 (High - important for performance-critical applications) |
| Version | Current |
| Year | N/A |
