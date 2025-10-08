# System.Buffers.SearchValues

## Feature Description

SearchValues<T> is a performance-focused type that provides optimized searching for specific sets of values within spans. It creates an immutable, pre-computed data structure that accelerates repeated searches for the same set of values using SIMD acceleration when possible, making it ideal for high-performance scenarios.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/api/system.buffers.searchvalues-1 | rendered | Official API documentation for SearchValues<T> | - |
| https://devblogs.microsoft.com/dotnet/performance-improvements-in-net-8/ | rendered | Performance improvements in .NET 8 (includes SearchValues) | - |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/runtime | src/libraries/System.Private.CoreLib/src/System/SearchValues/SearchValues.T.cs | SearchValues<T> implementation | - |
| dotnet/docs | docs/core/whats-new/dotnet-8/runtime.md | .NET 8 runtime features including SearchValues | - |
| dotnet/docs | docs/core/whats-new/dotnet-9/libraries.md | .NET 9 SearchValues enhancements (substring search) | - |

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
| overview | simhash | 13140716481029145400 |
| technical | simhash | 12992239188741849468 |

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
| searchvalues | 12.00 |
| searches | 7.00 |
| allocation-free | 4.00 |
| search | 6.00 |
| values | 7.00 |
| characters | 4.00 |
| operations | 4.00 |
| multiple | 5.00 |
| creating searchvalues | 2.00 |
| character | 3.00 |
| once | 3.00 |
| pre-computed | 2.00 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/string-search-operations | 0.7956 |
| csharp | csharp/csharp-14-features | 0.7328 |
| libraries | libraries/dotnet-10-library-improvements | 0.7137 |
| csharp | csharp/collection-initialization | 0.6978 |
| libraries | libraries/system-text-json | 0.6862 |
| csharp | csharp/collection-expressions | 0.6790 |
| libraries | libraries | 0.6616 |
| dotnet | dotnet | 0.6581 |
| cli | cli/file-based-apps | 0.5889 |
| cli | cli/assembly-trimming | 0.5803 |
| cli | cli/native-aot | 0.5636 |
| extensions | extensions/microsoft-extensions-ai-evaluation | 0.5520 |

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
| libraries | searchvalues | 2.145 |
| libraries | simd acceleration | 1.523 |
| libraries | pre-computed optimization | 1.412 |
