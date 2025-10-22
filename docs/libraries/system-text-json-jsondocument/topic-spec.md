# System.Text.Json.JsonDocument - Topic Specification

## Feature Description

System.Text.Json.JsonDocument provides a read-only Document Object Model (DOM) for JSON with minimal memory allocation. It parses JSON into a pooled memory buffer and provides `JsonElement` for navigation, enabling high-performance JSON querying without defining concrete types. JsonDocument is designed for scenarios requiring temporary JSON access with predictable, low-allocation characteristics.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/use-dom.md | System.Text.Json DOM documentation | |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/use-dom | rendered | Main System.Text.Json DOM documentation | |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/json | rendered | Official JSON samples repository | |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json.JsonDocument |
| ID | system-text-json-jsondocument |
| Category | Libraries |
| Namespace | System.Text.Json |
| Description | System.Text.Json.JsonDocument provides a read-only Document Object Model (DOM) for JSON with minimal memory allocation, enabling high-performance JSON querying without defining concrete types. |
| Complexity | 0.5 |
| Audience | All developers, Web developers, API developers |
| Priority | 2 (High) |
| Version | 3.0 |
| Year | 2019 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 13136741817361277754 |
| technical | simhash | 12992100100520943996 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json-nodes | 0.9017 |
| libraries | libraries/system-text-json | 0.8594 |
| libraries | libraries/system-text-json-jsonserializer | 0.8164 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.8127 |
| libraries | libraries/system-text-json-dotnet-10 | 0.7826 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.7693 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7494 |
| libraries | libraries/json-streaming-io | 0.7461 |
| libraries | libraries/json-validation-security | 0.7441 |
| libraries | libraries/system-text-json-source-generation | 0.7278 |
| libraries | libraries/dotnet-10-library-improvements | 0.6973 |
| libraries | libraries/span-based-string-processing | 0.6896 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| libraries/json-validation-security | deserialization | 1.700 |
| libraries/system-text-json | read-only | 1.500 |
| libraries/system-text-json-jsonserializer | deserialization | 1.700 |
| libraries/system-text-json-nodes | read-only | 1.500 |
| libraries/system-text-json-nodes | strongly-typed objects | 1.400 |

## APIs

| API | Type | Count |
|-----|------|-------|
| GetProperty | method | 39 |
| JsonDocument.Parse | method | 24 |
| GetString | method | 17 |
| TryGetProperty | method | 15 |
| Console.WriteLine | method | 10 |
| EnumerateArray | method | 9 |
| GetInt32 | method | 8 |
| GetRawText | method | 7 |
| EnumerateObject | method | 5 |
| JsonDocument.ParseAsync | method | 5 |
| GetBoolean | method | 4 |
| Select | method | 4 |

## Keywords

| Keyword | Score |
|---------|-------|
| jsondocument | 20.00 |
| system.text.json.jsondocument | 5.00 |
| jsonelement | 8.00 |
| metadata extraction | 4.00 |
| strongly-typed objects | 4.00 |
| deserialization | 7.00 |
| read-only | 5.00 |
| value | 6.00 |
| conditional deserialization | 3.00 |
| json arrays | 3.00 |
| webhook routing | 3.00 |
| document | 5.00 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 9
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 2

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.623 |
| 1 | Comparison with JsonNode | 0.739 | 0.674 |
| 2 | Reading Property Values | 0.623 | 1.000 |
| 3 | Iterating JSON Arrays | 0.569 | 0.703 |
| 4 | Processing Arrays of Objects | 0.599 | 0.692 |
| 5 | Using with Webhook Routing | 0.627 | 0.720 |
| 6 | Using with Metadata Extraction | 0.597 | 0.679 |
| 7 | Writing JSON from JsonElement | 0.592 | 0.633 |
| 8 | Memory Management | 0.685 | 0.668 |
