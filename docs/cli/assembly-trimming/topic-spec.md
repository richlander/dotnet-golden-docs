# Assembly Trimming - Topic Specification

## Feature Description

Assembly trimming is a size-reduction optimization for self-contained .NET applications that removes unused code from the application and its dependencies. The trimmer performs build-time analysis to identify and eliminate code that is not statically reachable, significantly reducing deployment size while maintaining application functionality.

## Keywords

- assembly trimming
- code trimming
- size optimization
- unused code removal
- build-time analysis
- deployment optimization

## Relationships

| Type | Target |
| --- | --- |
| Enables | Reduced deployment size, Faster deployment, Lower storage costs, Improved container performance |
| Conflicts with | Dynamic assembly loading, Unbounded reflection, C++/CLI, WPF/WinForms (currently) |
| Alternative to | Manual dependency reduction, Framework-dependent deployment |
| Prerequisite | Self-contained deployment, .NET 6+ (fully supported), Static code analysis compatibility |
| Synergistic with | Native AOT compilation, Single-file deployment, Source generators |

## Metadata

| Property | Value |
| --- | --- |
| Name | Assembly Trimming |
| ID | assembly-trimming |
| Category | CLI |
| Description | Assembly trimming is a size-reduction optimization for self-contained .NET applications that removes unused code from the application and its dependencies. |
| Complexity | 0.7 |
| Audience | Performance-focused developers, Cloud developers, Library authors |
| Priority | 2 (Common) |
| Version | 6.0 |
| Year | 2021 |

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/deploying/trimming/trim-self-contained | rendered | Main assembly trimming documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-net-6/ | rendered | .NET 6 announcement with trimming features | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/deploying/trimming/trim-self-contained.md | Trim self-contained deployments documentation | - |
| dotnet/docs | docs/core/deploying/trimming/trimming-options.md | Trimming options and configuration | - |
| dotnet/docs | docs/core/deploying/trimming/incompatibilities.md | Trimming incompatibilities documentation | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/mono/linker | rendered | ILLink linker repository | 2025-09-20 |
