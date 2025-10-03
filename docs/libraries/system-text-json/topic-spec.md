# System.Text.Json - Topic Specification

## Feature Description

System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+ that provides functionality for serializing to and deserializing from JavaScript Object Notation (JSON). It emphasizes performance and low memory allocation over extensive features, with built-in UTF-8 support optimized for web and file operations.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/ | rendered | Main System.Text.Json documentation | 404 |
| https://devblogs.microsoft.com/dotnet/try-the-new-system-text-json-apis/ | rendered | Official System.Text.Json APIs announcement | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/overview.md | System.Text.Json overview documentation | 0249c38f27 |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | 80fb00f580f |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements documentation | 0249c38f27 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/json | rendered | Official JSON samples repository | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json |
| ID | system-text-json |
| Category | Libraries |
| Namespace | System.Text.Json |
| Description | System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+ that provides functionality for serializing to and deserializing from JavaScript Object Notation (JSON). |
| Complexity | 0.7 |
| Audience | All developers, Web developers, API developers |
| Priority | 1 (Critical) |
| Version | 3.0 |
| Year | 2019 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Native AOT compatibility, High-performance JSON operations, Secure JSON processing |
| Conflicts with | System.Runtime.Serialization attributes, ISerializable interface |
| Alternative to | Newtonsoft.Json, DataContractJsonSerializer |
| Prerequisite | .NET Core 3.0+ (built-in), .NET Standard 2.0+ (NuGet package) |
| Synergistic with | ASP.NET Core APIs, Source generators, HttpClient extensions |

## Keywords

| Keyword | Score |
|---------|-------|
| newtonsoft.json | 3.56 |
| source generation | 3.21 |
| default | 3.04 |
| limits | 3.03 |
| requires | 3.03 |

## APIs

| API | Type | Count |
|-----|------|-------|
| JsonSerializable | attribute | 7 |
| JsonSerializer.Serialize | method | 7 |
| JsonSerializer.SerializeAsync | method | 3 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| IL2026 | Using member `System.Text.Json.JsonSerializer.Serialize<TValue>(TValue, JsonSerializerOptions)` which has 'RequiresUnreferencedCodeAttribute' can break functionality when trimming application code. JSON serialization and deserialization might require types that cannot be statically analyzed. Use the overload that takes a JsonTypeInfo or JsonSerializerContext, or make sure all of the required types are preserved. |
| IL2026 | Using member `System.Text.Json.JsonSerializer.Deserialize<TValue>(String, JsonSerializerOptions)` which has 'RequiresUnreferencedCodeAttribute' can break functionality when trimming application code. JSON serialization and deserialization might require types that cannot be statically analyzed. Use the overload that takes a JsonTypeInfo or JsonSerializerContext, or make sure all of the required types are preserved. |
| IL3050 | Using member `System.Text.Json.JsonSerializer.Serialize<TValue>(TValue, JsonSerializerOptions)` which has 'RequiresDynamicCodeAttribute' can break functionality when AOT compiling. JSON serialization and deserialization might require types that cannot be statically analyzed and might need runtime code generation. Use System.Text.Json source generation for native AOT applications. |
| IL3050 | Using member `System.Text.Json.JsonSerializer.Deseriallize<TValue>(String, JsonSerializerOptions)` which has 'RequiresDynamicCodeAttribute' can break functionality when AOT compiling. JSON serialization and deserialization might require types that cannot be statically analyzed and might need runtime code generation. Use System.Text.Json source generation for native AOT applications. |
| SYSLIB1030 | JsonSourceGenerationOptionsAttribute on type '{0}' is not valid. {1} |
| SYSLIB1034 | JsonStringEnumConverter with '{0}' is not supported in source generation mode. |
| SYSLIB1037 | Init-only property '{0}' is not supported in source generation mode. |
| SYSLIB1038 | JsonInclude is specified on inaccessible property '{0}'. |
| SYSLIB1039 | Polymorphic types are not supported in source generation mode. |
| SYSLIB1220 | Invalid '{0}' attribute argument: '{1}'. |
| SYSLIB1222 | Constructor parameter '{0}' has a JsonConstructorAttribute annotation but is inaccessible. |
| SYSLIB1223 | JsonConverterAttribute '{0}' is invalid. |
| SYSLIB1225 | JSON source generation does not support the specified configuration. |
| SYSLIB0020 | JsonSerializerOptions.IgnoreNullValues is obsolete. To ignore null values when serializing, set DefaultIgnoreCondition to JsonIgnoreCondition.WhenWritingNull. |
| SYSLIB0049 | JsonSerializerOptions.AddContext is obsolete. To register a JsonSerializerContext, use either the TypeInfoResolver or TypeInfoResolverChain properties. |
## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-text-json-source-generation | 0.8614 |
| libraries | libraries/dotnet-10-library-improvements | 0.7690 |
| dotnet | dotnet | 0.7299 |
| csharp | csharp/csharp-14-features | 0.7242 |
| libraries | libraries/system-commandline | 0.7216 |
| csharp | csharp | 0.6981 |
| cli | cli/native-aot | 0.6960 |
| cli | cli/file-based-apps | 0.6947 |
| csharp | csharp/object-initialization | 0.6575 |
| cli | cli/assembly-trimming | 0.6477 |
| cli | cli | 0.6320 |
| extensions | extensions/microsoft-extensions-ai-evaluation | 0.6286 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| cli/native-aot | source generation | 1.324 |
| libraries/system-text-json-source-generation | newtonsoft.json | 1.356 |
| libraries/system-text-json-source-generation | source generation | 1.324 |

