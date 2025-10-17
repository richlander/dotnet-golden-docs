# JSON Validation and Security - Topic Specification

## Feature Description

JSON validation and security features in System.Text.Json help ensure that deserialized data is correct, complete, and safe. These features protect against common security vulnerabilities like duplicate property attacks, enforce data contracts through strict validation, and ensure type safety with nullable reference types and required properties. The Strict serialization preset provides secure-by-default configuration, while individual validation features can be enabled separately. Duplicate property detection prevents ambiguity and potential security exploits, unmapped member handling ensures JSON matches expected type contracts, and nullable/required property validation enforces C# type constraints during deserialization. These capabilities are essential for securely processing untrusted JSON from external sources.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements | 2025-10-15 |
| dotnet/docs | docs/standard/serialization/system-text-json/overview.md | System.Text.Json overview | 2025-10-15 |
| dotnet/runtime | src/libraries/System.Text.Json | System.Text.Json source | 2025-10-15 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json | rendered | System.Text.Json documentation | 2025-10-15 |
| https://docs.microsoft.com/dotnet/core/whats-new/dotnet-10 | rendered | .NET 10 what's new | 2025-10-15 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/runtime | rendered | .NET runtime repository | 2025-10-15 |
| https://devblogs.microsoft.com/dotnet/ | rendered | .NET Blog | 2025-10-15 |

## Metadata

| Property | Value |
| --- | --- |
| Name | JSON Validation and Security |
| ID | json-validation-security |
| Category | .NET Libraries |
| Namespace | System.Text.Json |
| Description | Validation and security features for JSON deserialization including strict options, duplicate property detection, unmapped member handling, and nullable/required property validation. |
| Complexity | 0.6 |
| Audience | all developers, security engineers, API developers |
| Priority | 2 (High - important for secure applications) |
| Version | Current |
| Year | N/A |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 4220134623093668640 |
| technical | simhash | 12694860369024133596 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json-dotnet-10 | 0.8830 |
| libraries | libraries/system-text-json-jsonserializer | 0.8098 |
| libraries | libraries/system-text-json | 0.7859 |
| libraries | libraries/dotnet-10-library-improvements | 0.7661 |
| libraries | libraries/system-text-json-nodes | 0.7507 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7453 |
| libraries | libraries/system-text-json-jsondocument | 0.7441 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.7324 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.7223 |
| csharp | csharp/csharp-14-features | 0.7125 |
| libraries | libraries/json-streaming-io | 0.6982 |
| csharp | csharp/properties-backing-fields | 0.6862 |

## APIs

| API | Type | Count |
|-----|------|-------|
| System.Text.Json | type | 13 |
| System.Text | namespace | 10 |
| Console.WriteLine | method | 7 |
| BadRequest | method | 3 |
| JsonSerializerOptions | method | 3 |
| JsonUnmappedMemberHandling | attribute | 3 |
| LogWarning | method | 3 |
| System.Text.Json.Serialization | type | 3 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 5
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.659 |
| 1 | Handling Unmapped Properties | 0.659 | 1.000 |
| 2 | Combining Validation Features | 0.664 | 0.693 |
| 3 | API Security Best Practices | 0.632 | 0.699 |
| 4 | Best Practices | 0.693 | 0.662 |
