# System.Text.Json - Topic Specification

## Feature Description
System.Text.Json is a high-performance JSON serialization library built into .NET Core 3.0+ that provides functionality for serializing to and deserializing from JavaScript Object Notation (JSON). It emphasizes performance and low memory allocation over extensive features, with built-in UTF-8 support optimized for web and file operations.

## Relationships
Enables: Native AOT compatibility, High-performance JSON operations, Secure JSON processing
Conflicts with: System.Runtime.Serialization attributes, ISerializable interface
Alternative to: Newtonsoft.Json, DataContractJsonSerializer
Prerequisite: .NET Core 3.0+ (built-in), .NET Standard 2.0+ (NuGet package)
Synergistic with: ASP.NET Core APIs, Source generators, HttpClient extensions

## Hierarchy
Name: System.Text.Json
ID: system-text-json
Category: Libraries
Complexity: Beginner | Intermediate | Advanced
Audience: All developers | Web developers | API developers
Priority: 1 (Critical)

## Source Authority
Primary Sources (High confidence):
- https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/ - Official documentation - Last verified: 2025-01-19
- https://docs.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/libraries#json-serialization - .NET 10 improvements - Last verified: 2025-09-09
- https://github.com/dotnet/runtime/tree/main/src/libraries/System.Text.Json - Source code - Last verified: 2024-09-12

Secondary Sources (Good quality):
- Migration guides from Newtonsoft.Json, Stack Overflow discussions, Community performance comparisons

Validation Requirements:
- [ ] Code examples compile and run across .NET versions
- [ ] Source generation examples work with Native AOT
- [ ] Performance benchmarks vs Newtonsoft.Json
- [ ] Security validation for threat model scenarios

## Generation Hints
Emphasize: Performance benefits, Source generation, UTF-8 optimization, Security features
Avoid: Complex enterprise scenarios, Legacy serialization APIs
Cross-reference discover from: json-serialization, newtonsoft-migration, source-generation
Cross-reference surface to: aspnet-core-apis, httpclient-extensions, native-aot

## Token Budget Guidance
Minimum viable content: 600 tokens - Basic serialization/deserialization patterns
Comprehensive coverage: 2400 tokens - Source generation, options, converters, .NET 10 features
Full reference: 4800 tokens - Advanced scenarios, performance optimization, security considerations