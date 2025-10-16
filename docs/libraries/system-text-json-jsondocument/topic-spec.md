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
| overview | simhash | 13460983673022227226 |
| technical | simhash | 12703867533935911260 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json-nodes | 0.9017 |
| libraries | libraries/system-text-json | 0.8591 |
| libraries | libraries/system-text-json-jsonserializer | 0.8164 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.8127 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.7693 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7494 |
| libraries | libraries/system-text-json-source-generation | 0.7278 |
| libraries | libraries/dotnet-10-library-improvements | 0.6973 |
| csharp | csharp/csharp-14-features | 0.6811 |
| libraries | libraries/system-buffers-searchvalues | 0.6724 |
| dotnet | dotnet | 0.6507 |
| csharp | csharp/object-initialization | 0.6371 |

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

