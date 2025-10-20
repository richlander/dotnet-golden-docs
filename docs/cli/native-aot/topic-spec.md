# Native AOT - Topic Specification

## Feature Description

Native AOT (Ahead-of-Time) compilation is a publishing model that compiles .NET applications directly to native code at build time, eliminating the need for a just-in-time (JIT) compiler at runtime. This results in faster startup times, reduced memory footprint, and self-contained executables that don't require the .NET runtime to be installed on the target machine.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/deploying/native-aot/index.md | Native AOT overview documentation | 0249c38f27 |
| dotnet/docs | docs/core/deploying/native-aot/cross-compile.md | Native AOT cross-compilation guide | 0249c38f27 |
| dotnet/core | release-notes/7.0/7.0.0/7.0.0.md | .NET 7.0.0 release notes | 4c489a6a |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/deploying/native-aot/ | rendered | Main Native AOT documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-dotnet-7-preview-3/ | rendered | .NET 7 Preview 3 announcement with Native AOT | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/creating-aot-compatible-libraries/ | rendered | How to make libraries compatible with native AOT | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/nativeaot | rendered | Official Native AOT samples | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Native AOT |
| ID | native-aot |
| Category | CLI |
| Description | Native AOT (Ahead-of-Time) compilation is a publishing model that compiles .NET applications directly to native code at build time, eliminating the need for a just-in-time (JIT) compiler at runtime. |
| Complexity | 0.8 |
| Audience | Performance-focused developers, Cloud developers, Desktop app developers |
| Priority | 2 (Common) |
| Version | 7.0 |
| Year | 2022 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 128515531412412530 |
| overview | simhash | 17748008422434374514 |
| technical | simhash | 13136350303040708988 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Fast startup times, Reduced memory usage, Self-contained deployment, Container optimization, Edge computing scenarios |
| Conflicts with | Dynamic code generation, Assembly.LoadFile, System.Reflection.Emit, C++/CLI |
| Alternative to | JIT compilation, Self-contained deployment, ReadyToRun |
| Prerequisite | .NET 7+ SDK, Platform-specific toolchain (C++ build tools) |
| Synergistic with | Source generators, Trimming, Single-file deployment, Container images |

## Keywords

| Keyword | Score |
|---------|-------|
| native aot | 10.00 |
| compilation | 9.00 |
| reflection-based | 4.00 |
| runtime | 11.00 |
| source generation | 4.00 |
| no | 6.00 |
| self-contained | 3.00 |
| jit | 4.00 |
| supported | 4.00 |
| using native aot | 2.00 |
| generic methods | 2.00 |
| system.text.json source generation | 2.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| JsonSerializable | attribute | 5 |
| JsonSerializer.Serialize | method | 4 |
| WebApplication.CreateSlimBuilder | method | 3 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| NETSDK1196 | The SDK does not support ahead-of-time compilation. Set the PublishAot property to false. |
| IL2026 | Using member '{0}' which has 'RequiresUnreferencedCodeAttribute' can break functionality when trimming application code. |
| IL2055 | Call to 'System.Type.MakeGenericType' can not be statically analyzed. |
| IL2057 | Unrecognized value passed to the parameter 'typeName' of method 'System.Type.GetType'. It's not possible to guarantee the availability of the target type. |
| IL2070 | 'this' argument does not satisfy 'DynamicallyAccessedMembersAttribute' in call to target method. The parameter of method does not have matching annotations. |
| IL2087 | 'target parameter' argument does not satisfy 'DynamicallyAccessedMembersAttribute' in call to 'target method'. The return value of source method does not have matching annotations. |
| IL2091 | 'target parameter' argument does not satisfy 'DynamicallyAccessedMembersAttribute' in call to 'target method'. The generic parameter does not have matching annotations. |
## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| cli | cli/publishing-and-deployment | 0.8261 |
| cli | cli/file-based-apps | 0.7976 |
| dotnet | dotnet | 0.7752 |
| libraries | libraries/system-text-json-source-generation | 0.7720 |
| cli | cli/build-and-compilation | 0.7450 |
| libraries | libraries | 0.6828 |
| libraries | libraries/system-commandline | 0.6697 |
| libraries | libraries/system-text-json | 0.6683 |
| csharp | csharp/csharp-14-features | 0.6593 |
| csharp | csharp | 0.6473 |
| libraries | libraries/dotnet-10-library-improvements | 0.6411 |
| extensions | extensions/microsoft-extensions-ai | 0.6401 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| cli/publishing-and-deployment | native aot | 1.322 |
| libraries/system-text-json | source generation | 1.324 |
| libraries/system-text-json-source-generation | reflection-based | 1.359 |
| libraries/system-text-json-source-generation | system.text.json source generation | 1.351 |
| libraries/system-text-json-source-generation | source generation | 1.324 |
| libraries/system-text-json-source-generation | native aot | 1.322 |


## Chunks

**Source**: `golden-reference.md`
**Count**: 5
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.543 |
| 1 | Complementary Technologies | 0.543 | 1.000 |
| 2 | Setting Up Source Generation | 0.548 | 0.605 |
| 3 | Common AOT Errors | 0.515 | 0.521 |
| 4 | Common Troubleshooting | 0.614 | 0.637 |
