# Assembly Trimming - Topic Specification

## Feature Description

Assembly trimming is a size-reduction optimization for self-contained .NET applications that removes unused code from the application and its dependencies. The trimmer performs build-time analysis to identify and eliminate code that is not statically reachable, significantly reducing deployment size while maintaining application functionality.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/deploying/trimming/trim-self-contained | rendered | Main assembly trimming documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-net-6/ | rendered | .NET 6 announcement with trimming features | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/deploying/trimming/trim-self-contained.md | Trim self-contained deployments documentation | 0249c38f27 |
| dotnet/docs | docs/core/deploying/trimming/trimming-options.md | Trimming options and configuration | 0249c38f27 |
| dotnet/docs | docs/core/deploying/trimming/incompatibilities.md | Trimming incompatibilities documentation | 0249c38f27 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/mono/linker | rendered | ILLink linker repository | 2025-09-20 |

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

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 15867871635841552429 |
| overview | simhash | 13139696325230338417 |
| technical | simhash | 3773366901076271484 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Reduced deployment size, Faster deployment, Lower storage costs, Improved container performance |
| Conflicts with | Dynamic assembly loading, Unbounded reflection, C++/CLI, WPF/WinForms (currently) |
| Alternative to | Manual dependency reduction, Framework-dependent deployment |
| Prerequisite | Self-contained deployment, .NET 6+ (fully supported), Static code analysis compatibility |
| Synergistic with | Native AOT compilation, Single-file deployment, Source generators |

## Keywords

| Keyword | Score |
|---------|-------|
| trimming | 8.00 |
| assembly trimming | 2.00 |
| analysis | 4.00 |
| reduced | 4.00 |
| test | 4.00 |
| code | 7.00 |
| desktop applications | 2.00 |
| framework integration | 2.00 |
| library development | 2.00 |
| deployment | 4.00 |
| build-time | 2.00 |
| disabled | 3.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| RequiresUnreferencedCode | attribute | 8 |
| DynamicallyAccessedMembers | attribute | 7 |
| GetMethods | method | 4 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| IL2026 | Using member '{0}' which has 'RequiresUnreferencedCodeAttribute' can break functionality when trimming application code. |
| IL2032 | Unrecognized value passed to the parameter '{0}' of method 'CreateInstance'. It's not possible to guarantee the availability of the target type. |
| IL2055 | Call to 'System.Type.MakeGenericType' can not be statically analyzed. |
| IL2057 | Unrecognized value passed to the parameter 'typeName' of method 'System.Type.GetType'. It's not possible to guarantee the availability of the target type. |
| IL2062 | Value passed to implicit 'this' parameter of method '{0}' does not satisfy 'DynamicallyAccessedMembersAttribute' requirements. |
| IL2070 | 'this' argument does not satisfy 'DynamicallyAccessedMembersAttribute' in call to target method. The parameter of method does not have matching annotations. |
| IL2102 | Invalid AssemblyMetadata('IsTrimmable', ...) attribute. Value must be 'True'. |
| IL2110 | Field '{0}' with 'DynamicallyAccessedMembersAttribute' is accessed via reflection. |
| IL2111 | Method '{0}' with parameters or return value with 'DynamicallyAccessedMembersAttribute' is accessed via reflection. |
| NETSDK1124 | Trimming assemblies requires .NET Core 3.0 or higher. |
| NETSDK1168 | WPF is not supported or recommended with trimming enabled. |
| NETSDK1175 | Windows Forms is not supported or recommended with trimming enabled. |
| NETSDK1195 | Trimming, or code compatibility analysis for trimming, single-file deployment, or ahead-of-time compilation is not supported for the target framework. |
| NETSDK1212 | IsTrimmable and EnableTrimAnalyzer are not supported for the target framework. |
## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| cli | cli/build-and-compilation | 0.7217 |
| dotnet | dotnet | 0.7190 |
| cli | cli/native-aot | 0.7073 |
| cli | cli/publishing-and-deployment | 0.7000 |
| csharp | csharp/csharp-14-features | 0.6853 |
| libraries | libraries | 0.6762 |
| libraries | libraries/dotnet-10-library-improvements | 0.6727 |
| libraries | libraries/system-text-json | 0.6477 |
| libraries | libraries/system-text-json-source-generation | 0.6435 |
| csharp | csharp | 0.6079 |
| extensions | extensions/microsoft-extensions-http-resilience | 0.6045 |
| extensions | extensions/microsoft-extensions-ai | 0.5959 |

