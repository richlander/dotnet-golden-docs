# System.Text.Json - What's New in .NET 10 - Topic Specification

## Feature Description

This version-specific topic describes the System.Text.Json improvements added in .NET 10. The key enhancements focus on security, validation, and I/O performance: JsonSerializerOptions.Strict provides a secure-by-default preset configuration, AllowDuplicateProperties prevents duplicate property attacks, and PipeReader support enables high-performance streaming with System.IO.Pipelines. This topic is intended for distribution in .NET 10 NuGet packages and related materials. It will be deprecated when .NET 11 releases, with the features also documented in permanent thematic topics like JSON Validation and Security and JSON Streaming and I/O.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements | 2025-10-16 |
| dotnet/runtime | src/libraries/System.Text.Json | System.Text.Json source | 2025-10-16 |
| dotnet/core | release-notes/10.0/preview/*/libraries.md | .NET 10 preview release notes | 2025-10-16 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/whats-new/dotnet-10 | rendered | .NET 10 what's new | 2025-10-16 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/runtime | rendered | .NET runtime repository | 2025-10-16 |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json - What's New in .NET 10 |
| ID | system-text-json-dotnet-10 |
| Category | .NET Libraries |
| Namespace | System.Text.Json |
| Description | System.Text.Json improvements in .NET 10 including strict options, duplicate property detection, and PipeReader support. Version-specific topic for .NET 10 distribution. |
| Complexity | 0.6 |
| Audience | all developers, API developers |
| Priority | 2 (High - important for .NET 10 adoption) |
| Version | 10.0 |
| Year | 2025 |
| Lifecycle | Ephemeral - will be deprecated when .NET 11 releases |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 13444401641859923858 |
| technical | simhash | 13280328320399320536 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/json-validation-security | 0.8830 |
| libraries | libraries/system-text-json | 0.8743 |
| libraries | libraries/system-text-json-jsonserializer | 0.8727 |
| libraries | libraries/dotnet-10-library-improvements | 0.8676 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7999 |
| libraries | libraries/system-text-json-nodes | 0.7972 |
| libraries | libraries/system-text-json-jsondocument | 0.7826 |
| libraries | libraries/system-text-json-source-generation | 0.7817 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.7766 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.7666 |
| csharp | csharp/csharp-14-features | 0.7483 |
| libraries | libraries/json-streaming-io | 0.7437 |

## APIs

| API | Type | Count |
|-----|------|-------|
| System.Text.Json | type | 11 |
| System.Text | namespace | 9 |
| System.IO | namespace | 4 |
| System.IO.Pipelines | type | 4 |
| Console.WriteLine | method | 3 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 5
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 2

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.635 |
| 1 | PipeReader Performance | 0.685 | 0.644 |
| 2 | Duplicate Property Detection | 0.635 | 1.000 |
| 3 | Combining New Features | 0.637 | 0.607 |
| 4 | Using PipeReader | 0.625 | 0.683 |
