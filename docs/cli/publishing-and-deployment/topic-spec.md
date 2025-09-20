# Publishing and Deployment - Topic Specification

## Feature Description

Publishing and deployment encompasses the distribution-time workflow of preparing .NET applications for production use, including packaging, optimization, and deployment strategies. This covers all publishing modes from framework-dependent to self-contained, single-file, Native AOT, and container deployment, along with the decision matrix for choosing appropriate deployment strategies.

## Relationships

| Type | Target |
| --- | --- |
| Enables | Production deployment, Application distribution, Performance optimization, Platform targeting |
| Conflicts with | None (comprehensive workflow) |
| Alternative to | Manual deployment processes, Platform-specific packaging |
| Prerequisite | Successful build compilation, Target platform selection |
| Synergistic with | Build and compilation, Assembly trimming, Native AOT, Container technologies |

## Metadata

| Property | Value |
| --- | --- |
| Name | Publishing and Deployment |
| ID | publishing-and-deployment |
| Category | CLI |
| Description | Publishing and deployment encompasses the distribution-time workflow of preparing .NET applications for production use, including packaging, optimization, and deployment strategies. |
| Complexity | 0.9 |
| Audience | All .NET developers, DevOps engineers, System administrators |
| Priority | 1 (Critical) |
| Version | 1.0 |
| Year | 2016 |

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/tools/dotnet-publish | rendered | Main dotnet publish command documentation | - |
| https://devblogs.microsoft.com/dotnet/announcing-net-core-1-0/ | rendered | Official .NET Core 1.0 announcement | - |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/tools/dotnet-publish.md | dotnet publish command documentation | - |
| dotnet/docs | docs/core/deploying/index.md | .NET Core deployment overview | - |
| dotnet/docs | docs/core/rid-catalog.md | Runtime identifier catalog | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/core/tree/main/release-notes | rendered | .NET Core release notes | - |
