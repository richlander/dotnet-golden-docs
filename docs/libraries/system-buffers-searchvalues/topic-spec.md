# System.Buffers.SearchValues

## Feature Description

SearchValues<T> is a performance-focused type that provides optimized searching for specific sets of values within spans. It creates an immutable, pre-computed data structure that accelerates repeated searches for the same set of values using SIMD acceleration when possible, making it ideal for high-performance scenarios.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/runtime | src/libraries/System.Private.CoreLib/src/System/SearchValues/SearchValues.T.cs | SearchValues<T> implementation | - |
| dotnet/docs | docs/core/whats-new/dotnet-8/runtime.md | .NET 8 runtime features including SearchValues | - |
| dotnet/docs | docs/core/whats-new/dotnet-9/libraries.md | .NET 9 SearchValues enhancements (substring search) | - |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/api/system.buffers.searchvalues-1 | rendered | Official API documentation for SearchValues<T> | - |
| https://devblogs.microsoft.com/dotnet/performance-improvements-in-net-8/ | rendered | Performance improvements in .NET 8 (includes SearchValues) | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/runtime/issues/27229 | rendered | Original SearchValues proposal discussion | - |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Buffers.SearchValues |
| ID | system-buffers-searchvalues |
| Category | Libraries |
| Namespace | System.Buffers |
| Description | SearchValues provides an immutable, read-only set of values optimized for efficient searching within spans using SIMD acceleration. |
| Complexity | 0.6 |
| Audience | Performance-focused developers, library authors, high-throughput application developers |
| Priority | 2 (Important) |
| Version | 8.0 (char/byte), 9.0 (string) |
| Year | 2023 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 13140681365376533304 |
| technical | simhash | 12992238638986035580 |

## Relationships

| Type | Target |
| --- | --- |
| Optimizes | String.IndexOfAny, Span<T>.IndexOfAny, String.ContainsAny, IndexOfAnyExcept |
| Prerequisite | Understanding of Span<T> and ReadOnlySpan<T> |
| Synergistic with | MemoryExtensions, SIMD operations, high-performance string processing |
| Alternative to | Multiple sequential IndexOf/Contains calls, IndexOfAny with char[] arrays |
| Used by | .NET runtime libraries, ASP.NET Core, high-performance parsing libraries |

## Keywords

| Keyword | Score |
|---------|-------|
| searchvalues | 16.00 |
| searches | 7.00 |
| allocation-free | 4.00 |
| characters | 4.00 |
| values | 5.00 |
| creating searchvalues | 2.00 |
| character | 3.00 |
| once | 3.00 |
| pre-computed | 2.00 |
| searching | 3.00 |
| set | 3.00 |
| span-based | 2.00 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/string-search-operations | 0.7956 |
| libraries | libraries/span-based-string-processing | 0.7916 |
| libraries | libraries/collections-performance | 0.7535 |
| csharp | csharp/csharp-14-features | 0.7328 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.7235 |
| libraries | libraries/dotnet-10-library-improvements | 0.7137 |
| libraries | libraries/system-collections-generic-ienumerable | 0.7075 |
| libraries | libraries/system-collections-generic-iasyncenumerable | 0.7026 |
| libraries | libraries/system-text-json | 0.6987 |
| csharp | csharp/collection-initialization | 0.6978 |
| libraries | libraries/system-text-json-jsonserializer | 0.6797 |
| libraries | libraries/system-text-json-nodes | 0.6792 |

## APIs

| API | Type | Count |
|-----|------|-------|
| SearchValues.Create | method | 12 |
| AsSpan | method | 8 |
| ContainsAny | method | 8 |
| Contains | method | 7 |
| IndexOfAny | method | 7 |
| IndexOf | method | 4 |
| Slice | method | 3 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| csharp/collection-initialization | values | 1.500 |
| libraries/string-search-operations | searchvalues | 2.600 |
| libraries/string-search-operations | searches | 1.700 |
| libraries/string-search-operations | allocation-free | 1.400 |
| libraries/string-search-operations | character | 1.300 |
| libraries/string-search-operations | searching | 1.300 |
| libraries/system-text-json-utf8jsonreader | values | 1.500 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 4
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.573 |
| 1 | Path Validation | 0.573 | 1.000 |
| 2 | Protocol Parsing with SearchValues | 0.622 | 0.678 |
| 3 | Migration & Compatibility | 0.665 | 0.674 |
