# System.Text.Json.Utf8JsonWriter - Topic Specification

## Feature Description

System.Text.Json.Utf8JsonWriter is a high-performance, low-allocation writer for UTF-8 encoded JSON text. It provides direct control over JSON generation, writing directly to UTF-8 bytes without intermediate string allocation. Utf8JsonWriter is designed for performance-critical scenarios requiring streaming output, minimal allocation, and complete control over JSON structure and formatting.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/use-utf8jsonwriter | rendered | Utf8JsonWriter documentation | |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/use-utf8jsonwriter.md | Utf8JsonWriter usage documentation | |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | |

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
| libraries | libraries/system-text-json | 0.8391 |
| libraries | libraries/system-text-json-jsonserializer | 0.8289 |
| libraries | libraries/system-text-json-source-generation | 0.7696 |
| libraries | libraries/system-text-json-jsondocument | 0.7693 |
| libraries | libraries/system-text-json-nodes | 0.7544 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7239 |
| libraries | libraries/dotnet-10-library-improvements | 0.6736 |
| libraries | libraries/system-buffers-searchvalues | 0.6637 |
| csharp | csharp/csharp-14-features | 0.6564 |
| csharp | csharp | 0.6305 |
| dotnet | dotnet | 0.6218 |

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

