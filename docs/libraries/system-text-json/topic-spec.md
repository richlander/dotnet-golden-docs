# System.Text.Json - Topic Specification

## Feature Description
System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+ that provides functionality for serializing to and deserializing from JavaScript Object Notation (JSON). It emphasizes performance and low memory allocation over extensive features, with built-in UTF-8 support optimized for web and file operations.

## Relationships
Enables: Native AOT compatibility, High-performance JSON operations, Secure JSON processing
Conflicts with: System.Runtime.Serialization attributes, ISerializable interface
Alternative to: Newtonsoft.Json, DataContractJsonSerializer
Prerequisite: .NET Core 3.0+ (built-in), .NET Standard 2.0+ (NuGet package)
Synergistic with: ASP.NET Core APIs, Source generators, HttpClient extensions

## Metadata
Name: System.Text.Json
ID: system-text-json
Category: Libraries
Description: System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+ that provides functionality for serializing to and deserializing from JavaScript Object Notation (JSON).
Complexity: 0.6
Audience: All developers | Web developers | API developers
Priority: 1 (Critical)
Introduced-Version: 3.0
Introduced-Year: 2019

## Official Sources
Documentation: https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/
Announcement: https://devblogs.microsoft.com/dotnet/try-the-new-system-text-json-apis/

## Primary Sources
- https://raw.githubusercontent.com/dotnet/docs/main/docs/standard/serialization/system-text-json/overview.md
- https://raw.githubusercontent.com/dotnet/runtime/main/src/libraries/System.Text.Json/README.md
- https://raw.githubusercontent.com/dotnet/docs/main/docs/core/whats-new/dotnet-10/libraries.md

## Secondary Sources
- https://github.com/dotnet/samples/tree/main/core/json
- Migration guides from Newtonsoft.Json
- Community performance comparisons and tutorials

## Generation Hints
Emphasize: Performance benefits, Source generation, UTF-8 optimization, Security features
Avoid: Complex enterprise scenarios, Legacy serialization APIs
Cross-reference discover from: json-serialization, newtonsoft-migration, source-generation
Cross-reference surface to: aspnet-core-apis, httpclient-extensions, native-aot

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic serialization/deserialization patterns
Comprehensive coverage: 2400 tokens - Source generation, options, converters, .NET 10 features
Full reference: 4800 tokens - Advanced scenarios, performance optimization, security considerations
