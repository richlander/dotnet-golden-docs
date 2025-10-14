# Build and Compilation - Topic Specification

## Feature Description

Build and compilation encompasses the development-time workflow of transforming source code into executable binaries, managing dependencies, and preparing projects for testing and deployment. This includes the core commands `dotnet build`, `dotnet restore`, `dotnet clean`, along with MSBuild integration, multi-targeting, and build optimization strategies.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/tools/dotnet-build | rendered | Main dotnet build command documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-net-core-1-0/ | rendered | Official .NET Core 1.0 announcement | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/tools/dotnet-build.md | dotnet build command documentation | 0249c38f27 |
| dotnet/docs | docs/core/tools/dotnet-restore.md | dotnet restore command documentation | 0249c38f27 |
| dotnet/docs | docs/core/tools/dotnet-clean.md | dotnet clean command documentation | 0249c38f27 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/msbuild | rendered | MSBuild repository | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Build and Compilation |
| ID | build-and-compilation |
| Category | CLI |
| Description | Build and compilation encompasses the development-time workflow of transforming source code into executable binaries, managing dependencies, and preparing projects for testing and deployment. |
| Complexity | 0.5 |
| Audience | All .NET developers, DevOps engineers, Build engineers |
| Priority | 1 (Critical) |
| Version | 1.0 |
| Year | 2016 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 17751379938475704630 |
| technical | simhash | 13139692957975577396 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Application development, Testing workflows, Publishing preparation, CI/CD automation |
| Conflicts with | None (fundamental workflow) |
| Alternative to | Manual MSBuild invocation, IDE-specific build systems |
| Prerequisite | .NET SDK installation, Project files (*.csproj,*.sln) |
| Synergistic with | Package management, Testing frameworks, Publishing workflows, Code analysis tools |

## Keywords

| Keyword | Score |
|---------|-------|
| build | 15.00 |
| compilation | 5.00 |
| build acceleration | 2.00 |
| custom build configurations | 2.00 |
| dependency resolution | 2.00 |
| msbuild integration | 2.00 |
| ci | 4.00 |
| analysis | 3.00 |
| builds | 3.00 |
| parallel | 3.00 |
| workflows | 3.00 |
| performance optimization | 2.00 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| cli | cli | 0.8459 |
| cli | cli/publishing-and-deployment | 0.8120 |
| cli | cli/file-based-apps | 0.7631 |
| dotnet | dotnet | 0.7617 |
| libraries | libraries | 0.7280 |
| libraries | libraries/system-commandline | 0.6689 |
| libraries | libraries/dotnet-10-library-improvements | 0.6622 |
| csharp | csharp/csharp-14-features | 0.6456 |
| csharp | csharp | 0.6385 |
| libraries | libraries/system-text-json-source-generation | 0.6282 |
| libraries | libraries/system-text-json | 0.6227 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.6163 |

