# Native AOT - Topic Specification

## Feature Description

Native AOT (Ahead-of-Time) compilation is a publishing model that compiles .NET applications directly to native code at build time, eliminating the need for a just-in-time (JIT) compiler at runtime. This results in faster startup times, reduced memory footprint, and self-contained executables that don't require the .NET runtime to be installed on the target machine.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/core/deploying/native-aot/ | rendered | Main Native AOT documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-dotnet-7-preview-3/ | rendered | .NET 7 Preview 3 announcement with Native AOT | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/creating-aot-compatible-libraries/ | rendered | How to make libraries compatible with native AOT | - |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/core/deploying/native-aot/index.md | Native AOT overview documentation | 0249c38f27 |
| dotnet/docs | docs/core/deploying/native-aot/cross-compile.md | Native AOT cross-compilation guide | 0249c38f27 |
| dotnet/core | release-notes/7.0/7.0.0/7.0.0.md | .NET 7.0.0 release notes | 4c489a6a |

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

## Relationships

| Type | Target |
| --- | --- |
| Enables | Fast startup times, Reduced memory usage, Self-contained deployment, Container optimization, Edge computing scenarios |
| Conflicts with | Dynamic code generation, Assembly.LoadFile, System.Reflection.Emit, C++/CLI |
| Alternative to | JIT compilation, Self-contained deployment, ReadyToRun |
| Prerequisite | .NET 7+ SDK, Platform-specific toolchain (C++ build tools) |
| Synergistic with | Source generators, Trimming, Single-file deployment, Container images |

## Keywords

- Native AOT
- ahead-of-time compilation
- native code
- fast startup
- self-contained
- performance optimization

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
