# System.Text.Json Source Generation - Topic Specification

## Feature Description

System.Text.Json source generation provides compile-time generation of serialization code to enable high-performance, AOT-compatible JSON operations. It eliminates runtime reflection by generating typed serialization logic at compile time, making it essential for Native AOT deployments and high-performance applications. Source generation supports type-safe operations with unconstrained generics and automatic property naming policies, reducing the need for manual JsonPropertyName attributes.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/source-generation | rendered | System.Text.Json source generation guide | 2025-09-24 |
| https://docs.microsoft.com/dotnet/core/deploying/native-aot/#system-text-json | rendered | Native AOT and JSON serialization | 2025-09-24 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/source-generation.md | Source generation documentation | 2025-09-24 |
| dotnet/docs | docs/standard/serialization/system-text-json/source-generation-modes.md | Source generation modes guide | 2025-09-24 |
| dotnet/docs | docs/core/deploying/native-aot/serialization.md | AOT serialization patterns | 2025-09-24 |
| dotnet/runtime | src/libraries/System.Text.Json/src/System/Text/Json/Serialization/JsonSerializer.Write.String.cs | JsonSerializer implementation | 2025-09-24 |
| dotnet/runtime | src/libraries/System.Text.Json.SourceGeneration/src/JsonSourceGenerator.cs | Source generator implementation | 2025-09-24 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/designs/blob/main/accepted/2020/serializer-reliability.md | rendered | JSON serializer reliability design | 2025-09-24 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://devblogs.microsoft.com/dotnet/try-the-new-system-text-json-source-generator/ | rendered | Source generation announcement | 2025-09-24 |
| https://devblogs.microsoft.com/dotnet/announcing-dotnet-6/ | rendered | .NET 6 source generation features | 2025-09-24 |
| https://github.com/dotnet/samples/tree/main/core/json/source-generation | rendered | Official source generation samples | 2025-09-24 |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json Source Generation |
| ID | system-text-json-source-generation |
| Category | Libraries |
| Namespace | System.Text.Json.Serialization |
| Description | Compile-time generation of JSON serialization code for high-performance, AOT-compatible operations with automatic property naming and type-safe generic support. |
| Complexity | 0.45 |
| Audience | Performance-focused developers, Native AOT developers, Enterprise developers |
| Priority | 2 (High - important for AOT scenacd doterios) |
| Version | 6.0 |
| Year | 2021 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Native AOT compatibility, Compile-time type safety, Zero-allocation serialization, Generic type support |
| Conflicts with | Runtime reflection-based serialization, Dynamic type resolution |
| Alternative to | Reflection-based JsonSerializer, Manual serialization code |
| Prerequisite | .NET 6.0+, System.Text.Json 6.0+, Source generators support |
| Synergistic with | Native AOT compilation, ASP.NET Core minimal APIs, High-performance scenarios |

## Keywords

| Keyword | Score |
|---------|-------|
| aot applications | 4.55 |
| aot compatibility | 4.54 |
| aot compilation | 4.52 |
| property naming policies | 4.52 |
| type-safe | 4.52 |
| reflection-based | 3.59 |
| newtonsoft.json | 3.56 |
| system.text.json source generation | 3.51 |
| source generation | 3.24 |
| native aot | 3.22 |
| naming | 3.08 |
| context | 3.06 |

## APIs

| API | Type | Count |
|-----|------|-------|
| JsonSerializable | attribute | 24 |
| JsonSourceGenerationOptions | attribute | 18 |
| JsonSerializer.Serialize | method | 14 |
| System.Text.Json | namespace | 11 |
| System.Text | namespace | 7 |
| JsonSerializer.Deserialize | method | 5 |
| JsonTypeInfoResolver.Combine | method | 5 |
| JsonPropertyName | attribute | 4 |
| System.Text.Json.JsonSerializer | namespace | 4 |
| System.Text.Json.JsonSerializer.Serialize | type | 4 |
| GetFromJsonAsync | method | 3 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| IL2026 | Using member which has 'RequiresUnreferencedCodeAttribute' can break functionality when trimming application code. Use JsonTypeInfo overloads instead. |
| IL2055 | Type '{0}' was not found in the caller assembly nor in the base library. Type reference '{1}' may be removed by the trimmer. |
| IL2057 | Unrecognized value '{0}' for parameter '{1}' of attribute '{2}'. |
| IL2070 | 'this' parameter does not satisfy 'DynamicallyAccessedMemberTypes.{0}' in call to '{1}'. The parameter '{2}' of method '{3}' does not have matching annotations. |
| IL2087 | 'target' parameter does not satisfy 'DynamicallyAccessedMemberTypes.{0}' in call to '{1}'. The parameter '{2}' of method '{3}' does not have matching annotations. |
| IL2091 | 'target' parameter does not satisfy 'DynamicallyAccessedMemberTypes.{0}' in call to '{1}'. The generic parameter '{2}' of '{3}' does not have matching annotations. |
| IL3050 | Using member which has 'RequiresDynamicCodeAttribute' can break functionality when AOT compiling. Use System.Text.Json source generation for native AOT applications. |
| SYSLIB0020 | JsonSerializerOptions.IgnoreNullValues is obsolete. To ignore null values when serializing, set DefaultIgnoreCondition to JsonIgnoreCondition.WhenWritingNull. |
| SYSLIB0049 | JsonSerializerOptions.AddContext is obsolete. To register a JsonSerializerContext, use either the TypeInfoResolver or TypeInfoResolverChain properties. |
| SYSLIB1030 | JsonSourceGenerationOptionsAttribute on type '{0}' is not valid. {1} |
| SYSLIB1031 | JsonSerializableAttribute on type '{0}' is not valid. {1} |
| SYSLIB1032 | JsonSourceGenerationMode '{0}' is not supported. |
| SYSLIB1033 | JsonStringEnumConverter on type '{0}' is not supported in source generation mode. |
| SYSLIB1034 | JsonStringEnumConverter with '{0}' is not supported in source generation mode. |
| SYSLIB1035 | Multiple JsonConstructorAttribute annotations are not supported in source generation mode. |
| SYSLIB1036 | JsonConstructorAttribute is specified on type '{0}' with non-public accessibility. |
| SYSLIB1037 | Init-only property '{0}' is not supported in source generation mode. |
| SYSLIB1038 | JsonInclude is specified on inaccessible property '{0}'. |
| SYSLIB1039 | Polymorphic types are not supported in source generation mode. |
| SYSLIB1220 | Invalid '{0}' attribute argument: '{1}'. |
| SYSLIB1222 | Constructor parameter '{0}' has a JsonConstructorAttribute annotation but is inaccessible. |
| SYSLIB1223 | JsonConverterAttribute '{0}' is invalid. |
| SYSLIB1225 | JSON source generation does not support the specified configuration. |
## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json | 0.8614 |
| cli | cli/native-aot | 0.7595 |
| dotnet | dotnet | 0.6763 |
| libraries | libraries/system-commandline | 0.6746 |
| libraries | libraries/dotnet-10-library-improvements | 0.6743 |
| cli | cli/file-based-apps | 0.6693 |
| csharp | csharp/csharp-14-features | 0.6648 |
| csharp | csharp/object-initialization | 0.6641 |
| cli | cli/publishing-and-deployment | 0.6453 |
| cli | cli/assembly-trimming | 0.6435 |
| csharp | csharp/collection-initialization | 0.6331 |
| extensions | extensions/microsoft-extensions-ai-evaluation | 0.6149 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| cli/native-aot | reflection-based | 1.359 |
| cli/native-aot | system.text.json source generation | 1.351 |
| cli/native-aot | source generation | 1.324 |
| cli/native-aot | native aot | 1.322 |
| cli/publishing-and-deployment | native aot | 1.322 |
| libraries/system-text-json | newtonsoft.json | 1.356 |
| libraries/system-text-json | source generation | 1.324 |

