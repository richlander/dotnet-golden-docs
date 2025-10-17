# System.Text.Json.Utf8JsonWriter - Topic Specification

## Feature Description

System.Text.Json.Utf8JsonWriter is a high-performance, low-allocation writer for UTF-8 encoded JSON text. It provides direct control over JSON generation, writing directly to UTF-8 bytes without intermediate string allocation. Utf8JsonWriter is designed for performance-critical scenarios requiring streaming output, minimal allocation, and complete control over JSON structure and formatting.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/use-utf8jsonwriter.md | Utf8JsonWriter usage documentation | |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/use-utf8jsonwriter | rendered | Utf8JsonWriter documentation | |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/json | rendered | Official JSON samples repository | |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json.Utf8JsonWriter |
| ID | system-text-json-utf8jsonwriter |
| Category | Libraries |
| Namespace | System.Text.Json |
| Description | System.Text.Json.Utf8JsonWriter is a high-performance, low-allocation writer for UTF-8 encoded JSON text, providing direct control over JSON generation with minimal allocation. |
| Complexity | 0.6 |
| Audience | All developers, Performance-critical applications, Library authors |
| Priority | 3 (Medium) |
| Version | 3.0 |
| Year | 2019 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 469786640745173528 |
| technical | simhash | 17603924666003358076 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json-utf8jsonreader | 0.8631 |
| libraries | libraries/system-text-json | 0.8408 |
| libraries | libraries/system-text-json-jsonserializer | 0.8289 |
| libraries | libraries/system-text-json-dotnet-10 | 0.7766 |
| libraries | libraries/system-text-json-source-generation | 0.7696 |
| libraries | libraries/system-text-json-jsondocument | 0.7693 |
| libraries | libraries/json-streaming-io | 0.7638 |
| libraries | libraries/system-text-json-nodes | 0.7544 |
| libraries | libraries/json-validation-security | 0.7324 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7239 |
| libraries | libraries/span-based-string-processing | 0.7134 |
| libraries | libraries/dotnet-10-library-improvements | 0.6736 |

## APIs

| API | Type | Count |
|-----|------|-------|
| WriteString | method | 34 |
| WriteStartObject | method | 29 |
| WriteEndObject | method | 28 |
| Utf8JsonWriter | method | 22 |
| WriteNumber | method | 19 |
| Flush | method | 14 |
| WritePropertyName | method | 13 |
| MemoryStream | method | 11 |
| FlushAsync | method | 10 |
| WriteEndArray | method | 9 |
| WriteStartArray | method | 9 |
| WriteStringValue | method | 7 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 8
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 2

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.616 |
| 1 | Performance vs Convenience | 0.707 | 0.652 |
| 2 | Writing with Formatting Options | 0.616 | 1.000 |
| 3 | Writing Different Number Types | 0.613 | 0.731 |
| 4 | Using with HTTP Response Streams | 0.671 | 0.696 |
| 5 | Custom Serialization Logic | 0.624 | 0.693 |
| 6 | Validation and Error Handling | 0.661 | 0.733 |
| 7 | Manual Structure Validation | 0.665 | 0.662 |
