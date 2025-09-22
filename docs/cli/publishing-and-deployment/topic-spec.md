# Publishing and Deployment - Topic Specification

## Feature Description

Publishing and deployment encompasses the distribution-time workflow of preparing .NET applications for production use, including packaging, optimization, and deployment strategies. This covers all publishing modes from framework-dependent to self-contained, single-file, Native AOT, and container deployment, along with the decision matrix for choosing appropriate deployment strategies.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/tools/dotnet-publish | rendered | Main dotnet publish command documentation | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/tools/dotnet-publish.md | dotnet publish command documentation | 0249c38f27 |
| dotnet/docs | docs/core/deploying/index.md | .NET Core deployment overview | 0249c38f27 |
| dotnet/docs | docs/core/rid-catalog.md | Runtime identifier catalog | 0249c38f27 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/core/tree/main/release-notes | rendered | .NET Core release notes | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Publishing and Deployment |
| ID | publishing-and-deployment |
| Category | CLI |
| Description | Publishing and deployment encompasses the distribution-time workflow of preparing .NET applications for production use, including packaging, optimization, and deployment strategies. |
| Complexity | 0.6 |
| Audience | All .NET developers, DevOps engineers, System administrators |
| Priority | 1 (Critical) |
| Version | 1.0 |
| Year | 2016 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Production deployment, Application distribution, Performance optimization, Platform targeting |
| Conflicts with | None (comprehensive workflow) |
| Alternative to | Manual deployment processes, Platform-specific packaging |
| Prerequisite | Successful build compilation, Target platform selection |
| Synergistic with | Build and compilation, Assembly trimming, Native AOT, Container technologies |

## Keywords

- dotnet publish
- deployment
- publishing modes
- self-contained
- production deployment
- application distribution

## Diagnostic Codes

| Code | Message |
| --- | --- |
| NETSDK1031 | It is not supported to build or publish a self-contained application without specifying a RuntimeIdentifier. |
| NETSDK1097 | It is not supported to publish an application to a single-file without specifying a RuntimeIdentifier. |
| NETSDK1098 | Applications published to a single-file are required to use the application host. |
| NETSDK1099 | Publishing to a single-file is only supported for executable applications. |
| NETSDK1123 | Publishing an application to a single-file requires .NET Core 3.0 or higher. |
| NETSDK1125 | Publishing to a single-file is only supported for netcoreapp target framework. |
| NETSDK1126 | Publishing ReadyToRun using Crossgen2 is only supported for self-contained applications. |
| NETSDK1128 | COM hosting does not support self-contained deployments. |
| NETSDK1129 | The 'Publish' target is not supported without specifying a target framework. |
| NETSDK1134 | Building a solution with a specific RuntimeIdentifier is not supported. |
| NETSDK1142 | Including symbols in a single file bundle is not supported when publishing for .NET5 or higher. |
| NETSDK1152 | Found multiple publish output files with the same relative path. |
| NETSDK1167 | Compression in a single file bundle is only supported when publishing for .NET6 or higher. |
| NETSDK1176 | Compression in a single file bundle is only supported when publishing a self-contained application. |
| NETSDK1193 | If PublishSelfContained is set, it must be either true or false. |
| NETSDK1198 | A publish profile with the name '{0}' was not found in the project. |
| NETSDK1225 | Native compilation is not supported when invoking the Publish target directly. |
