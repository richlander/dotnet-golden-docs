# System.Text.Json - Sources

## Primary Sources (High Confidence)

### Official Microsoft Documentation
- **System.Text.Json Overview**: https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/overview
  - Last verified: 2025-01-19
  - Content: Architecture, namespaces, thread safety, security information
  - Authority: Microsoft official docs team

- **How to Serialize and Deserialize**: https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/how-to
  - Last verified: 2025-02-11
  - Content: Basic serialization examples, performance tips, AI assistance
  - Authority: Microsoft official docs team

- **Source Generation Guide**: https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/source-generation
  - Last verified: 2023-10-09
  - Content: Source generation modes, ASP.NET Core integration, reflection disabling
  - Authority: Microsoft official docs team

- **.NET 10 Library Improvements**: https://docs.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/libraries
  - Last verified: 2025-09-09
  - Content: Strict options, AllowDuplicateProperties, ReferenceHandler, PipeReader support
  - Authority: Microsoft .NET team

### Source Code Repository
- **GitHub Runtime Repository**: https://github.com/dotnet/runtime/tree/main/src/libraries/System.Text.Json
  - Last verified: 2024-09-12
  - Content: Implementation details, performance optimizations, threat model
  - Authority: Microsoft .NET team

- **Threat Model Documentation**: https://github.com/dotnet/runtime/blob/main/src/libraries/System.Text.Json/docs/ThreatModel.md
  - Last verified: 2024-09-12
  - Content: Security considerations, attack vectors, mitigation strategies
  - Authority: Microsoft Security team

### API Reference Documentation
- **System.Text.Json Namespace**: https://docs.microsoft.com/en-us/dotnet/api/system.text.json
  - Last verified: 2024-12-15
  - Content: Complete API reference, method signatures, examples
  - Authority: Microsoft API documentation team

- **JsonSerializer Class**: https://docs.microsoft.com/en-us/dotnet/api/system.text.json.jsonserializer
  - Last verified: 2024-12-15
  - Content: Serialization methods, options, overloads
  - Authority: Microsoft API documentation team

## Secondary Sources (Good Quality)

### Migration and Comparison Guides
- **Newtonsoft.Json Migration Guide**: https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/migrate-from-newtonsoft
  - Last verified: 2024-08-15
  - Content: Feature comparisons, migration steps, compatibility issues
  - Authority: Microsoft documentation team

### Performance Benchmarks
- **Performance Improvements in .NET 8**: https://devblogs.microsoft.com/dotnet/performance-improvements-in-net-8/#json
  - Last verified: 2023-11-14
  - Content: Performance comparisons, optimization strategies
  - Authority: Microsoft .NET team blog

### Community Resources
- **Stack Overflow System.Text.Json Tag**: https://stackoverflow.com/questions/tagged/system.text.json
  - Last verified: 2024-09-12
  - Content: Common problems, solutions, best practices
  - Authority: Developer community

- **Reddit r/dotnet Discussions**: https://www.reddit.com/r/dotnet/
  - Last verified: 2024-09-12
  - Content: Performance discussions, migration experiences
  - Authority: Developer community

## Code Examples Sources

### Official Sample Repository
- **docs/samples**: https://github.com/dotnet/docs/tree/main/docs/standard/serialization/system-text-json/snippets
  - Last verified: 2024-08-15
  - Content: Working code examples for all scenarios
  - Authority: Microsoft documentation team

### ASP.NET Core Integration Examples
- **ASP.NET Core Web API Samples**: https://github.com/dotnet/AspNetCore.Docs/tree/main/aspnetcore/web-api
  - Last verified: 2024-07-20
  - Content: Real-world API integration patterns
  - Authority: Microsoft ASP.NET team

## Validation Status

### Code Compilation Tests
- [x] Basic serialization examples compile with .NET 8
- [x] Source generation examples work with Native AOT
- [x] ASP.NET Core integration examples functional
- [x] .NET 10 feature examples verified

### Cross-Platform Testing
- [x] Windows (x64, ARM64)
- [x] Linux (x64, ARM64)
- [x] macOS (x64, ARM64)

### Version Compatibility
- [x] .NET Core 3.0 basic features
- [x] .NET 5 improvements
- [x] .NET 6 source generation
- [x] .NET 7 type resolver chains
- [x] .NET 8 streaming optimizations
- [x] .NET 10 strict options and PipeReader

## Update Schedule

### Regular Verification
- Monthly check of primary documentation links
- Quarterly validation of code examples
- Semi-annual cross-platform testing

### Event-Based Updates
- New .NET version releases
- Major security advisories
- Breaking changes in APIs
- Performance benchmark updates

## Quality Metrics

### Source Authority Grading
- **A+**: Official Microsoft documentation, source code
- **A**: Microsoft team blogs, official samples
- **B+**: High-score Stack Overflow answers, established community guides
- **B**: Community blogs with verifiable examples
- **C**: Unverified community content

### Content Freshness
- **Green**: Updated within last 6 months
- **Yellow**: Updated within last year
- **Red**: Older than 1 year, needs verification

### Validation Requirements
- All code examples must compile and run
- Performance claims must have benchmarks
- Security advice must reference threat model
- Migration guidance must cover breaking changes