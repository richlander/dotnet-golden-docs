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
