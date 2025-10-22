# CLI - Topic Specification

## Feature Description

The .NET CLI (Command-Line Interface) is the primary cross-platform toolchain for developing, building, testing, and deploying .NET applications. It provides a unified command-line experience across Windows, macOS, and Linux for all stages of the application development lifecycle.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/tools/index.md | .NET CLI tools documentation | 0249c38f27 |
| dotnet/core | release-notes/1.0/1.0.0.md | .NET Core 1.0.0 release notes | 4c489a6a |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/tools/ | rendered | Main .NET CLI documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-net-core-1-0/ | rendered | Official .NET Core 1.0 announcement | 2025-09-20 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/cli | rendered | .NET CLI repository | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | CLI |
| ID | cli |
| Category | CLI |
| Namespace | (none) |
| Description | The .NET CLI (Command-Line Interface) is the primary cross-platform toolchain for developing, building, testing, and deploying .NET applications. |
| Complexity | 0.4 |
| Audience | all developers, DevOps engineers, system administrators |
| Priority | 1 (Critical - fundamental .NET tooling) |
| Version | 1.0 |
| Year | 2016 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 13139554503262208824 |
| technical | simhash | 13139588021186986364 |

## Relationships

| Type | Target |
| --- | --- |

## Keywords

| Keyword | Score |
|---------|-------|
| cli | 23.00 |
| tools | 13.00 |
| package | 11.00 |
| development | 10.00 |
| commands | 9.00 |
| across | 8.00 |
| global | 8.00 |
| command-line | 5.00 |
| builds | 7.00 |
| projects | 6.00 |
| consistent | 5.00 |
| sdk | 5.00 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| cli | cli/build-and-compilation | 0.8459 |
| cli | cli/file-based-apps | 0.7994 |
| libraries | libraries/system-commandline | 0.7970 |
| cli | cli/publishing-and-deployment | 0.7850 |
| dotnet | dotnet | 0.7804 |
| libraries | libraries | 0.7484 |
| libraries | libraries/dotnet-10-library-improvements | 0.6809 |
| libraries | libraries/system-threading-tasks-task | 0.6661 |
| extensions | extensions/microsoft-extensions-ai | 0.6615 |
| libraries | libraries/system-text-json | 0.6554 |
| csharp | csharp | 0.6447 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.6368 |

### Similarity Metadata

| Category | Threshold | Percentile | Total Pairs |
|----------|-----------|------------|-------------|
| cli | 0.7850 | P50 | 5 |
| csharp | 0.5530 | P70 | 9 |
| dotnet | 0.7804 | P50 | 1 |
| extensions | 0.6142 | P50 | 3 |
| libraries | 0.5742 | P70 | 21 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| cli/build-and-compilation | commands | 1.900 |
| cli/build-and-compilation | builds | 1.700 |
| dotnet | tools | 2.300 |
| libraries/system-commandline | commands | 1.900 |
| libraries/system-commandline | command-line | 1.500 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 9
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 7

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.521 |
| 1 | Tool and Workload Management | 0.505 | 0.569 |
| 2 | Solution Management | 0.527 | 0.653 |
| 3 | Integration Patterns | 0.565 | 0.609 |
| 4 | Package Restore Optimization | 0.569 | 0.569 |
| 5 | Version and Compatibility Management | 0.534 | 0.586 |
| 6 | Security and Trust Considerations | 0.479 | 0.542 |
| 7 | Package and Dependency Management | 0.521 | 1.000 |
| 8 | CI/CD Pipeline Integration | 0.600 | 0.573 |
