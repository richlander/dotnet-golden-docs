# JSON Streaming and I/O - Topic Specification

## Feature Description

JSON streaming and I/O capabilities in System.Text.Json enable efficient processing of JSON data from various sources including streams, pipes, and asynchronous operations. These features allow developers to work with large JSON documents, real-time data streams, and high-throughput scenarios without loading entire documents into memory. PipeReader support enables direct deserialization from System.IO.Pipelines for high-performance pipeline scenarios, while stream-based serialization provides incremental reading and writing. Async patterns support non-blocking I/O operations, and UTF-8 direct processing eliminates string conversion overhead. These capabilities are essential for building memory-efficient, high-performance applications that process JSON at scale.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements | 2025-10-15 |
| dotnet/docs | docs/standard/serialization/system-text-json/overview.md | System.Text.Json overview | 2025-10-15 |
| dotnet/runtime | src/libraries/System.Text.Json | System.Text.Json source | 2025-10-15 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json | rendered | System.Text.Json documentation | 2025-10-15 |
| https://docs.microsoft.com/dotnet/standard/io/pipelines | rendered | System.IO.Pipelines documentation | 2025-10-15 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/runtime | rendered | .NET runtime repository | 2025-10-15 |
| https://devblogs.microsoft.com/dotnet/ | rendered | .NET Blog | 2025-10-15 |

## Metadata

| Property | Value |
| --- | --- |
| Name | JSON Streaming and I/O |
| ID | json-streaming-io |
| Category | .NET Libraries |
| Namespace | System.Text.Json, System.IO.Pipelines |
| Description | Efficient JSON processing with streams, pipes, and async operations including PipeReader support, large document handling, and memory-efficient parsing. |
| Complexity | 0.7 |
| Audience | performance engineers, API developers, backend developers |
| Priority | 2 (High - important for high-performance applications) |
| Version | Current |
| Year | N/A |
