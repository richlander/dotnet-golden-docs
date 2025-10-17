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

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 5373223288336521872 |
| technical | simhash | 12713018245211120108 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json | 0.7999 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.7854 |
| libraries | libraries/system-text-json-jsonserializer | 0.7811 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.7638 |
| libraries | libraries/system-collections-generic-iasyncenumerable | 0.7473 |
| libraries | libraries/system-text-json-jsondocument | 0.7461 |
| libraries | libraries/system-text-json-dotnet-10 | 0.7437 |
| libraries | libraries/system-text-json-nodes | 0.7200 |
| csharp | csharp/async-await | 0.7119 |
| libraries | libraries/system-threading-tasks-task | 0.6994 |
| libraries | libraries/json-validation-security | 0.6982 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.6909 |

## APIs

| API | Type | Count |
|-----|------|-------|
| System.Text | namespace | 12 |
| System.Text.Json | type | 12 |
| System.IO | namespace | 6 |
| System.IO.Pipelines | type | 6 |
| Console.WriteLine | method | 4 |
| FlushAsync | method | 4 |
| MyData | method | 4 |
| CompleteAsync | method | 3 |
| File.OpenRead | method | 3 |
| JsonSerializer.SerializeAsync | method | 3 |
| Message | method | 3 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 6
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 2

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.653 |
| 1 | Adopting Streaming APIs | 0.719 | 0.628 |
| 2 | Producer-Consumer Pipeline | 0.653 | 1.000 |
| 3 | HTTP Response Streaming | 0.642 | 0.683 |
| 4 | Memory-Efficient Parsing | 0.615 | 0.637 |
| 5 | Large File Processing | 0.653 | 0.699 |
