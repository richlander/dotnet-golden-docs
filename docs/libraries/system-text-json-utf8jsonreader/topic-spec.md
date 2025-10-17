# System.Text.Json.Utf8JsonReader - Topic Specification

## Feature Description

System.Text.Json.Utf8JsonReader is a high-performance, low-allocation, forward-only reader for UTF-8 encoded JSON text. It provides the lowest-level API for reading JSON, operating directly on UTF-8 bytes without allocation and offering maximum control over parsing. Utf8JsonReader is designed for performance-critical scenarios where streaming, minimal allocation, and complete parsing control are essential.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/use-utf8jsonreader.md | Utf8JsonReader usage documentation | |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/use-utf8jsonreader | rendered | Utf8JsonReader documentation | |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/json | rendered | Official JSON samples repository | |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json.Utf8JsonReader |
| ID | system-text-json-utf8jsonreader |
| Category | Libraries |
| Namespace | System.Text.Json |
| Description | System.Text.Json.Utf8JsonReader is a high-performance, low-allocation, forward-only reader for UTF-8 encoded JSON text, providing the lowest-level API for reading JSON with maximum control over parsing. |
| Complexity | 0.7 |
| Audience | All developers, Performance-critical applications, Library authors |
| Priority | 3 (Medium) |
| Version | 3.0 |
| Year | 2019 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 2796080149753443096 |
| technical | simhash | 12704010495948890620 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json | 0.8694 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.8631 |
| libraries | libraries/system-text-json-jsonserializer | 0.8423 |
| libraries | libraries/system-text-json-jsondocument | 0.8127 |
| libraries | libraries/span-based-string-processing | 0.8072 |
| libraries | libraries/system-text-json-nodes | 0.7954 |
| libraries | libraries/json-streaming-io | 0.7854 |
| libraries | libraries/system-text-json-dotnet-10 | 0.7666 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7430 |
| libraries | libraries/system-buffers-searchvalues | 0.7235 |
| libraries | libraries/json-validation-security | 0.7223 |
| libraries | libraries/system-text-json-source-generation | 0.7151 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Read | method | 34 |
| Console.WriteLine | method | 25 |
| GetString | method | 25 |
| Utf8JsonReader | method | 22 |
| Encoding.UTF8.GetBytes | method | 13 |
| GetInt32 | method | 9 |
| Add | method | 8 |
| TestSequenceSegment | method | 4 |
| GetBoolean | method | 3 |
| ReadAsync | method | 3 |
| Skip | method | 3 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 7
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.637 |
| 1 | Extracting Specific Values | 0.637 | 1.000 |
| 2 | Reading Nested Objects | 0.616 | 0.755 |
| 3 | Reading with Options | 0.656 | 0.747 |
| 4 | Using for Custom Deserialization | 0.638 | 0.711 |
| 5 | Using for Streaming Array Processing | 0.633 | 0.714 |
| 6 | Ref Struct Constraints | 0.658 | 0.668 |
