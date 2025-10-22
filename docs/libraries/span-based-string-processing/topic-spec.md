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

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 12978237250685174064 |
| technical | simhash | 17603926856436679036 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json-utf8jsonreader | 0.8072 |
| libraries | libraries/string-search-operations | 0.7976 |
| libraries | libraries/system-buffers-searchvalues | 0.7916 |
| csharp | csharp/csharp-14-features | 0.7413 |
| libraries | libraries/system-text-json | 0.7374 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.7134 |
| libraries | libraries/system-text-json-jsonserializer | 0.7116 |
| libraries | libraries/dotnet-10-library-improvements | 0.7018 |
| libraries | libraries/system-text-json-nodes | 0.6924 |
| libraries | libraries/collections-performance | 0.6919 |
| libraries | libraries/system-text-json-jsondocument | 0.6896 |
| libraries | libraries/json-streaming-io | 0.6894 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| libraries/dotnet-10-library-improvements | span-based | 1.800 |
| libraries/json-streaming-io | utf-8 | 3.000 |
| libraries/system-text-json | text | 2.100 |
| libraries/system-text-json-utf8jsonreader | utf-8 | 3.000 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Slice | method | 16 |
| AsSpan | method | 10 |
| Console.WriteLine | method | 7 |
| System.Text | namespace | 6 |
| IsNormalized | method | 4 |
| StartsWith | method | 4 |
| Encoding.UTF8.GetBytes | method | 3 |
| File.ReadAllBytes | method | 3 |
| GetFileExtension | method | 3 |
| IndexOf | method | 3 |
| IsValidCommand | method | 3 |
| LastIndexOf | method | 3 |

## Keywords

| Keyword | Score |
|---------|-------|
| span-based | 8.00 |
| utf-8 | 20.00 |
| pattern matching | 8.00 |
| allocations | 11.00 |
| strings | 10.00 |
| string normalization | 5.00 |
| without | 12.00 |
| spans | 9.00 |
| text | 11.00 |
| span-based string processing | 3.00 |
| string | 6.00 |
| utf-8 string literals | 3.00 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 7
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.654 |
| 1 | Pattern Matching on `ReadOnlySpan<char>` | 0.654 | 1.000 |
| 2 | Relationships & Integration | 0.685 | 0.699 |
| 3 | Finding PEM Data in UTF-8 Files | 0.614 | 0.689 |
| 4 | String Normalization Patterns | 0.653 | 0.699 |
| 5 | Processing Speed | 0.625 | 0.623 |
| 6 | Adopting Span-Based String Processing | 0.681 | 0.653 |
