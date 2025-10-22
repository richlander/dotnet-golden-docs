# Collections Performance - Topic Specification

## Feature Description

Collections Performance encompasses both runtime-delivered optimizations and code patterns that enable efficient use of arrays, lists, and other collection types in .NET. The runtime has continuously evolved to optimize collection operations through techniques like stack allocation, devirtualization, and improved code generation. Recent improvements include stack allocation for small arrays of reference types, array interface devirtualization that eliminates abstraction overhead, and OrderedDictionary<TKey, TValue> for insertion-order collections with fast indexed access. These optimizations work together to reduce memory allocations, eliminate virtual call overhead, and provide predictable high performance for common collection scenarios, with many improvements applied automatically by the runtime.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/whats-new/dotnet-10/runtime.md | .NET 10 runtime improvements | 2025-10-15 |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements | 2025-10-15 |
| dotnet/core | release-notes/10.0/preview/*/runtime.md | .NET 10 preview release notes | 2025-10-15 |
| dotnet/core | release-notes/10.0/preview/*/libraries.md | .NET 10 preview release notes | 2025-10-15 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/whats-new/dotnet-10 | rendered | .NET 10 what's new documentation | 2025-10-15 |
| https://devblogs.microsoft.com/dotnet/ | rendered | .NET Blog announcements | 2025-10-15 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/runtime | rendered | .NET runtime implementation repository | 2025-10-15 |
| https://github.com/dotnet/runtime/issues/108913 | rendered | De-abstraction improvements tracking issue | 2025-10-15 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Collections Performance |
| ID | collections-performance |
| Category | .NET Libraries |
| Namespace | System.Collections.Generic |
| Description | Runtime optimizations and code patterns for efficient use of arrays, lists, and collection types, including automatic stack allocation, array interface devirtualization, and OrderedDictionary with indexed access. |
| Complexity | 0.7 |
| Audience | all developers, performance engineers, library authors |
| Priority | 2 (High - important for performance-conscious applications) |
| Version | Current |
| Year | N/A |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 2764390160376595248 |
| technical | simhash | 17603927406192492924 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-collections-generic-ienumerable | 0.7989 |
| csharp | csharp/collection-initialization | 0.7736 |
| libraries | libraries/system-collections-generic-iasyncenumerable | 0.7558 |
| libraries | libraries/dotnet-10-library-improvements | 0.7552 |
| libraries | libraries/system-buffers-searchvalues | 0.7535 |
| csharp | csharp/collection-expressions | 0.7510 |
| csharp | csharp/csharp-14-features | 0.7482 |
| libraries | libraries | 0.7445 |
| dotnet | dotnet | 0.7286 |
| csharp | csharp/async-await | 0.7065 |
| libraries | libraries/system-text-json | 0.7041 |
| libraries | libraries/system-threading-tasks-task | 0.6963 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| libraries/system-collections-generic-iasyncenumerable | enumeration | 1.500 |
| libraries/system-collections-generic-ienumerable | enumeration | 1.500 |
| libraries/system-threading-tasks-task | don't | 1.700 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Console.WriteLine | method | 9 |
| GetAt | method | 4 |
| Process | method | 4 |
| Add | method | 3 |
| Contains | method | 3 |
| O | method | 3 |
| ToArray | method | 3 |
| Where | method | 3 |

## Keywords

| Keyword | Score |
|---------|-------|
| stack allocation | 7.00 |
| array interface devirtualization | 6.00 |
| small arrays | 5.00 |
| collections performance | 4.00 |
| both | 7.00 |
| escape | 6.00 |
| optimizations | 6.00 |
| don't | 7.00 |
| through | 7.00 |
| benefit | 5.00 |
| enumeration | 5.00 |
| interfaces | 5.00 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 7
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.687 |
| 1 | Array Interface Performance Parity | 0.687 | 1.000 |
| 2 | Relationships & Integration | 0.676 | 0.611 |
| 3 | Escape Analysis for Struct Fields | 0.629 | 0.725 |
| 4 | Efficient Updates with Index Caching | 0.648 | 0.595 |
| 5 | Array Interface Devirtualization | 0.686 | 0.702 |
| 6 | Leveraging Automatic Optimizations | 0.687 | 0.630 |
