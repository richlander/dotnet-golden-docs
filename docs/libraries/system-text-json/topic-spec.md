# System.Text.Json - Topic Specification

## Feature Description

System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+ that provides functionality for serializing to and deserializing from JavaScript Object Notation (JSON). It emphasizes performance and low memory allocation over extensive features, with built-in UTF-8 support optimized for web and file operations.

## Relationships

| Type | Target |
| --- | --- |
| Enables | Native AOT compatibility, High-performance JSON operations, Secure JSON processing |
| Conflicts with | System.Runtime.Serialization attributes, ISerializable interface |
| Alternative to | Newtonsoft.Json, DataContractJsonSerializer |
| Prerequisite | .NET Core 3.0+ (built-in), .NET Standard 2.0+ (NuGet package) |
| Synergistic with | ASP.NET Core APIs, Source generators, HttpClient extensions |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json |
| ID | system-text-json |
| Category | Libraries |
| Description | System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+ that provides functionality for serializing to and deserializing from JavaScript Object Notation (JSON). |
| Complexity | 0.6 |
| Audience | All developers, Web developers, API developers |
| Priority | 1 (Critical) |
| Version | 3.0 |
| Year | 2019 |

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/ | rendered | Main System.Text.Json documentation | 404 |
| https://devblogs.microsoft.com/dotnet/try-the-new-system-text-json-apis/ | rendered | Official System.Text.Json APIs announcement | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/serialization/system-text-json/overview.md | System.Text.Json overview documentation | - |
| dotnet/runtime | src/libraries/System.Text.Json/README.md | System.Text.Json library README | - |
| dotnet/docs | docs/core/whats-new/dotnet-10/libraries.md | .NET 10 library improvements documentation | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/json | rendered | Official JSON samples repository | 2025-09-20 |
