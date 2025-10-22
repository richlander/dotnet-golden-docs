# System.Text.Json.JsonSerializer - Topic Specification

## Feature Description

System.Text.Json.JsonSerializer provides high-level APIs for converting between .NET objects and JSON text. It offers simple static methods for serialization and deserialization, supporting both synchronous and asynchronous operations. JsonSerializer abstracts the complexity of JSON parsing and generation, providing a straightforward API for common JSON operations while supporting advanced features like custom converters, naming policies, and source generation.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/how-to.md | JsonSerializer usage documentation | |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/how-to | rendered | JsonSerializer how-to documentation | |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/json | rendered | Official JSON samples repository | |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json.JsonSerializer |
| ID | system-text-json-jsonserializer |
| Category | Libraries |
| Namespace | System.Text.Json |
| Description | System.Text.Json.JsonSerializer provides high-level APIs for converting between .NET objects and JSON text with support for serialization, deserialization, and advanced customization. |
| Complexity | 0.5 |
| Audience | All developers, Web developers, API developers |
| Priority | 1 (Critical) |
| Version | 3.0 |
| Year | 2019 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 13176850832237699898 |
| technical | simhash | 12992100100520943996 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json | 0.9393 |
| libraries | libraries/system-text-json-dotnet-10 | 0.8727 |
| libraries | libraries/system-text-json-source-generation | 0.8652 |
| libraries | libraries/system-text-json-nodes | 0.8430 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.8428 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.8423 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.8289 |
| libraries | libraries/system-text-json-jsondocument | 0.8164 |
| libraries | libraries/json-validation-security | 0.8098 |
| libraries | libraries/json-streaming-io | 0.7811 |
| libraries | libraries/dotnet-10-library-improvements | 0.7658 |
| csharp | csharp/csharp-14-features | 0.7259 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| csharp/csharp-14-features | compile-time | 1.600 |
| libraries/json-validation-security | deserialization | 2.300 |
| libraries/system-text-json | json | 2.200 |
| libraries/system-text-json | source generation | 1.700 |
| libraries/system-text-json | compile-time | 1.600 |
| libraries/system-text-json-dotnet-10 | source generation | 1.700 |
| libraries/system-text-json-jsondocument | deserialization | 2.300 |
| libraries/system-text-json-migrate-from-newtonsoft | json | 2.200 |
| libraries/system-text-json-nodes | json | 2.200 |
| libraries/system-text-json-source-generation | source generation | 1.700 |
| libraries/system-text-json-source-generation | compile-time | 1.600 |
| libraries/system-text-json-utf8jsonwriter | control | 1.700 |
| libraries/system-text-json-utf8jsonwriter | output | 1.500 |

## APIs

| API | Type | Count |
|-----|------|-------|
| JsonSerializer.Serialize | method | 40 |
| System.Text.Json | type | 20 |
| System.Text | namespace | 18 |
| Console.WriteLine | method | 16 |
| System.Text.Json.Serialization | type | 15 |
| Description | attribute | 8 |
| Product | method | 6 |
| JsonConstructor | attribute | 4 |
| JsonDerivedType | attribute | 4 |
| JsonSerializable | attribute | 4 |
| JsonSerializerOptions | method | 4 |
| JsonStringEnumMemberName | attribute | 4 |

## Keywords

| Keyword | Score |
|---------|-------|
| deserialization | 13.00 |
| system.text.json.jsonserializer | 5.00 |
| serialization | 10.00 |
| source generation | 7.00 |
| json | 12.00 |
| jsonserializer | 9.00 |
| serialize | 8.00 |
| compile-time | 6.00 |
| constructor parameters | 3.00 |
| utf-8 operations | 3.00 |
| control | 7.00 |
| output | 5.00 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 21
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.590 |
| 1 | Deserializing Objects | 0.590 | 1.000 |
| 2 | Configuring Naming Policies | 0.615 | 0.655 |
| 3 | Custom Property Names | 0.635 | 0.678 |
| 4 | Working with Records | 0.601 | 0.716 |
| 5 | Deserializing with Constructors | 0.615 | 0.677 |
| 6 | UTF-8 Operations | 0.609 | 0.681 |
| 7 | Custom Converters | 0.648 | 0.653 |
| 8 | Handling Large Numbers | 0.628 | 0.668 |
| 9 | Reusing JsonSerializerOptions | 0.633 | 0.683 |
| 10 | Circular References | 0.648 | 0.642 |
| 11 | Thread Safety | 0.608 | 0.678 |
| 12 | Indentation Customization | 0.638 | 0.656 |
| 13 | Freezing JsonSerializerOptions | 0.589 | 0.668 |
| 14 | Generating JSON Schema | 0.590 | 0.645 |
| 15 | Adding Documentation to JSON Schema | 0.593 | 0.643 |
| 16 | Documenting Constructor Parameters in Schema | 0.578 | 0.672 |
| 17 | Out-of-Order Metadata Deserialization | 0.607 | 0.627 |
| 18 | Required Constructor Parameters | 0.618 | 0.672 |
| 19 | Using with PipeReader and PipeWriter | 0.600 | 0.679 |
| 20 | Chaining Type Resolvers | 0.606 | 0.640 |
