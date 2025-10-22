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
| overview | simhash | 13136881455338070840 |
| technical | simhash | 12992240838009299324 |

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

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| libraries/json-streaming-io | utf-8 | 1.900 |
| libraries/json-validation-security | during | 1.600 |
| libraries/span-based-string-processing | utf-8 | 1.900 |
| libraries/system-buffers-searchvalues | values | 1.900 |

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

## Keywords

| Keyword | Score |
|---------|-------|
| parsing | 17.00 |
| utf8jsonreader | 12.00 |
| system.text.json.utf8jsonreader | 5.00 |
| reading | 7.00 |
| utf-8 | 9.00 |
| values | 9.00 |
| forward-only | 4.00 |
| process | 6.00 |
| reader | 6.00 |
| token | 5.00 |
| during | 6.00 |
| multi-segment | 3.00 |

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
