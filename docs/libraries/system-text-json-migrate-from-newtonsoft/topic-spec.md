# Migrating from Newtonsoft.Json to System.Text.Json - Topic Specification

## Feature Description

This topic provides technical mapping between Newtonsoft.Json and System.Text.Json APIs. It covers API equivalents, attribute mappings, and required code changes for applications migrating from Newtonsoft.Json to System.Text.Json. The document focuses on mechanical conversion steps without comparing features or benefits.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/migrate-from-newtonsoft.md | Migration guide | |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/migrate-from-newtonsoft | rendered | Migration guide documentation | |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |

## Metadata

| Property | Value |
| --- | --- |
| Name | Migrating from Newtonsoft.Json to System.Text.Json |
| ID | system-text-json-migrate-from-newtonsoft |
| Category | Libraries |
| Namespace | System.Text.Json |
| Description | Technical mapping between Newtonsoft.Json and System.Text.Json APIs for migration purposes. |
| Complexity | 0.6 |
| Audience | Developers migrating from Newtonsoft.Json |
| Priority | 2 (High) |
| Version | 3.0 |
| Year | 2019 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 614095243011328414 |
| technical | simhash | 12974224274836293980 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json-jsonserializer | 0.8428 |
| libraries | libraries/system-text-json | 0.8369 |
| libraries | libraries/system-text-json-dotnet-10 | 0.7999 |
| libraries | libraries/system-text-json-nodes | 0.7949 |
| libraries | libraries/system-text-json-source-generation | 0.7575 |
| libraries | libraries/system-text-json-jsondocument | 0.7494 |
| libraries | libraries/json-validation-security | 0.7453 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.7430 |
| libraries | libraries/dotnet-10-library-improvements | 0.7378 |
| csharp | csharp/csharp-14-features | 0.7255 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.7239 |
| libraries | libraries | 0.6928 |

## APIs

| API | Type | Count |
|-----|------|-------|
| System.Text.Json | type | 34 |
| System.Text | namespace | 28 |
| JsonProperty | attribute | 7 |
| JsonIgnore | attribute | 5 |
| JsonConvert.SerializeObject | method | 4 |
| JsonRequired | attribute | 4 |
| JsonSerializer.Serialize | method | 4 |
| JsonConstructor | attribute | 3 |
| JsonConverter | attribute | 3 |
| JsonDerivedType | attribute | 3 |
| JsonPropertyName | attribute | 3 |
| Select | method | 3 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 8
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 2

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.645 |
| 1 | DateFormatString | 0.583 | 0.640 |
| 2 | JsonSerializerSettings to JsonSerializerOptions | 0.645 | 1.000 |
| 3 | Numbers in Quotes | 0.628 | 0.728 |
| 4 | Dictionary with Non-String Keys | 0.623 | 0.716 |
| 5 | Callbacks | 0.601 | 0.711 |
| 6 | JToken to JsonElement (Read-Only) | 0.635 | 0.687 |
| 7 | System.Runtime.Serialization Attributes | 0.626 | 0.678 |
