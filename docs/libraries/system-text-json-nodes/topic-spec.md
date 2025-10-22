# System.Text.Json.Nodes - Topic Specification

## Feature Description

System.Text.Json.Nodes provides a Document Object Model (DOM) for JSON, allowing developers to navigate, query, and modify JSON structures dynamically without needing to define concrete types. It includes JsonNode, JsonObject, JsonArray, and JsonValue classes that represent JSON structures in memory.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/use-dom.md | System.Text.Json.Nodes DOM documentation | |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/use-dom | rendered | Main System.Text.Json.Nodes documentation | |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/json | rendered | Official JSON samples repository | |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json.Nodes |
| ID | system-text-json-nodes |
| Category | Libraries |
| Namespace | System.Text.Json.Nodes |
| Description | System.Text.Json.Nodes provides a Document Object Model (DOM) for JSON, allowing developers to navigate, query, and modify JSON structures dynamically without needing to define concrete types. |
| Complexity | 0.6 |
| Audience | All developers, Web developers, API developers |
| Priority | 2 (High) |
| Version | 6.0 |
| Year | 2021 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 12995440279541449072 |
| technical | simhash | 17603786118948323708 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json-jsondocument | 0.9017 |
| libraries | libraries/system-text-json | 0.8745 |
| libraries | libraries/system-text-json-jsonserializer | 0.8430 |
| libraries | libraries/system-text-json-dotnet-10 | 0.7972 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.7954 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7949 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.7544 |
| libraries | libraries/system-text-json-source-generation | 0.7529 |
| libraries | libraries/json-validation-security | 0.7507 |
| libraries | libraries/json-streaming-io | 0.7200 |
| libraries | libraries/dotnet-10-library-improvements | 0.7183 |
| csharp | csharp/csharp-14-features | 0.7090 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| libraries/system-text-json | json | 3.000 |
| libraries/system-text-json | read-only | 1.600 |
| libraries/system-text-json | dynamic | 1.500 |
| libraries/system-text-json-jsondocument | read-only | 1.600 |
| libraries/system-text-json-jsondocument | strongly-typed objects | 1.300 |
| libraries/system-text-json-jsonserializer | json | 3.000 |
| libraries/system-text-json-migrate-from-newtonsoft | json | 3.000 |

## APIs

| API | Type | Count |
|-----|------|-------|
| JsonNode.Parse | method | 20 |
| AsObject | method | 9 |
| ToJsonString | method | 6 |
| AsArray | method | 5 |
| DateTime.UtcNow.ToString | method | 4 |
| DeepClone | method | 4 |
| Console.WriteLine | method | 3 |
| JsonArray | method | 3 |

## Keywords

| Keyword | Score |
|---------|-------|
| json | 20.00 |
| system.text.json.nodes | 6.00 |
| strongly-typed | 7.00 |
| json documents | 6.00 |
| nodes | 10.00 |
| read-only | 6.00 |
| type safety | 4.00 |
| strongly-typed objects | 3.00 |
| runtime | 10.00 |
| better | 5.00 |
| between | 5.00 |
| dynamic | 5.00 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 7
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 2

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.677 |
| 1 | Type Safety | 0.717 | 0.621 |
| 2 | Reading Values from JsonArray | 0.677 | 1.000 |
| 3 | Navigating Nested Structures | 0.642 | 0.729 |
| 4 | Type Checking and Conversion | 0.663 | 0.684 |
| 5 | Using with Configuration Merging | 0.608 | 0.713 |
| 6 | Choosing Between JsonNode and JsonDocument | 0.615 | 0.639 |
