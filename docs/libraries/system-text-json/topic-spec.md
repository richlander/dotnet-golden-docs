# System.Text.Json - Topic Specification

## Feature Description

System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+ that provides functionality for serializing to and deserializing from JavaScript Object Notation (JSON). It emphasizes performance and low memory allocation over extensive features, with built-in UTF-8 support optimized for web and file operations.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/overview.md | System.Text.Json overview documentation | 0249c38f27 |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | 80fb00f580f |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements documentation | 0249c38f27 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/ | rendered | Main System.Text.Json documentation | 404 |
| https://devblogs.microsoft.com/dotnet/try-the-new-system-text-json-apis/ | rendered | Official System.Text.Json APIs announcement | 2025-09-20 |

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

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 16930982311004600425 |
| overview | simhash | 12992627727723340090 |
| technical | simhash | 13172382621933396857 |

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
| source generation | 27.00 |
| json | 70.00 |
| system.text.json | 20.00 |
| apis | 22.00 |
| read-only | 14.00 |
| serialization | 21.00 |
| use | 31.00 |
| api | 14.00 |
| scenarios | 14.00 |
| minimal | 17.00 |
| configuration | 12.00 |
| asp.net core | 6.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| JsonSerializable | attribute | 20 |
| JsonSerializer.Serialize | method | 18 |
| GetString | method | 9 |
| File.OpenRead | method | 6 |
| JsonNode.Parse | method | 6 |
| System.Text | namespace | 6 |
| System.Text.Json | type | 6 |
| GetUser | method | 5 |
| JsonDocument.Parse | method | 5 |
| Console.WriteLine | method | 4 |
| GetFromJsonAsync | method | 4 |
| GetProperty | method | 4 |

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
| libraries | libraries/system-text-json-jsonserializer | 0.9334 |
| libraries | libraries/system-text-json-nodes | 0.8730 |
| libraries | libraries/system-text-json-utf8jsonreader | 0.8663 |
| libraries | libraries/system-text-json-jsondocument | 0.8591 |
| libraries | libraries/system-text-json-source-generation | 0.8429 |
| libraries | libraries/system-text-json-utf8jsonwriter | 0.8391 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.8378 |
| libraries | libraries/dotnet-10-library-improvements | 0.7844 |
| libraries | libraries | 0.7366 |
| csharp | csharp/csharp-14-features | 0.7342 |
| dotnet | dotnet | 0.7318 |
| csharp | csharp | 0.6981 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| cli/native-aot | source generation | 1.324 |
| libraries/system-text-json-source-generation | newtonsoft.json | 1.356 |
| libraries/system-text-json-source-generation | source generation | 1.324 |


## Chunks

**Source**: `golden-reference.md`
**Count**: 11
**Baseline (Conceptual)**: Chunk 0
**Baseline (Technical)**: Chunk 1

| Index | Title | Code | Similarity (Conceptual) | Similarity (Technical) |
|-------|-------|------|-------------------------|------------------------|
| 0 | Overview |  | 1.000 | 0.657 |
| 1 | Quick Reference | ✓ | 0.657 | 1.000 |
| 2 | API comparison |  | 0.668 | 0.597 |
| 3 | Scenario recommendations | ✓ | 0.648 | 0.680 |
| 4 | Performance hierarchy (fastest to slowest) |  | 0.654 | 0.619 |
| 5 | HttpClient Extensions | ✓ | 0.647 | 0.707 |
| 6 | Large File Streaming | ✓ | 0.581 | 0.618 |
| 7 | Performance Optimization | ✓ | 0.668 | 0.674 |
| 8 | Security Considerations | ✓ | 0.603 | 0.599 |
| 9 | Installation and Setup | ✓ | 0.584 | 0.630 |
| 10 | Migration from Newtonsoft.Json | ✓ | 0.597 | 0.660 |
