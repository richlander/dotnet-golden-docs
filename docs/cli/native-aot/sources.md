# Native AOT - Sources

## Primary Sources (High Confidence)

### Official Microsoft Documentation
- **Native AOT Deployment Overview**: https://docs.microsoft.com/en-us/dotnet/core/deploying/native-aot/index
  - Last verified: 2023-06-12
  - Content: Core concepts, prerequisites, publishing process, limitations
  - Authority: Microsoft .NET documentation team

- **Cross-Compilation Guide**: https://docs.microsoft.com/en-us/dotnet/core/deploying/native-aot/cross-compile
  - Last verified: 2023-10-10
  - Content: Platform-specific toolchain setup, cross-architecture compilation
  - Authority: Microsoft .NET documentation team

- **Application Publishing Overview**: https://docs.microsoft.com/en-us/dotnet/core/deploying/index
  - Last verified: 2025-08-11
  - Content: Publishing modes comparison, Native AOT in context of other deployment options
  - Authority: Microsoft .NET documentation team

- **.NET 10 SDK Features**: https://docs.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/sdk
  - Last verified: 2025-09-09
  - Content: File-based apps with Native AOT, .NET 10 enhancements
  - Authority: Microsoft .NET team

### Official Samples and Repositories
- **Native AOT Samples**: https://github.com/dotnet/samples/tree/main/core/nativeaot
  - Last verified: 2024-09-12
  - Content: Working examples, Dockerfiles for Linux/Windows
  - Authority: Microsoft .NET samples team

- **Runtime Repository**: https://github.com/dotnet/runtime/tree/main/src/coreclr/nativeaot
  - Last verified: 2024-09-12
  - Content: Implementation details, source code, design documents
  - Authority: Microsoft .NET runtime team

### ASP.NET Core Integration
- **ASP.NET Core Native AOT Support**: https://docs.microsoft.com/en-us/aspnet/core/fundamentals/native-aot
  - Last verified: 2024-07-15
  - Content: Web application compatibility, minimal APIs, source generation
  - Authority: Microsoft ASP.NET team

- **ASP.NET Core Samples**: https://github.com/dotnet/AspNetCore.Docs/tree/main/aspnetcore/fundamentals/native-aot
  - Last verified: 2024-06-20
  - Content: Working web application examples
  - Authority: Microsoft ASP.NET documentation team

## Secondary Sources (Good Quality)

### Performance and Benchmarking
- **.NET Performance Blog Posts**: https://devblogs.microsoft.com/dotnet/category/performance/
  - Last verified: 2024-08-15
  - Content: Performance comparisons, optimization strategies
  - Authority: Microsoft .NET performance team

- **Community Benchmarks**: Various Stack Overflow and GitHub discussions
  - Last verified: 2024-09-12
  - Content: Real-world performance comparisons, startup time measurements
  - Authority: Developer community

### Platform-Specific Guides
- **Linux Distribution Setup Guides**: Ubuntu, Alpine, Fedora, RHEL documentation
  - Last verified: 2024-07-20
  - Content: Platform-specific toolchain installation
  - Authority: Linux distribution maintainers

- **Visual Studio Documentation**: https://docs.microsoft.com/en-us/visualstudio/
  - Last verified: 2024-08-10
  - Content: C++ build tools setup, workload requirements
  - Authority: Microsoft Visual Studio team

### Container and Cloud Resources
- **Container Publishing Guide**: https://docs.microsoft.com/en-us/dotnet/core/containers/
  - Last verified: 2024-08-05
  - Content: Container optimization with Native AOT
  - Authority: Microsoft containers team

- **Docker Hub .NET Images**: https://hub.docker.com/_/microsoft-dotnet-runtime-deps
  - Last verified: 2024-09-10
  - Content: Runtime-deps base images for Native AOT
  - Authority: Microsoft container team

## Code Examples Sources

### Official Documentation Samples
- **docs/samples**: https://github.com/dotnet/docs/tree/main/docs/core/deploying/native-aot
  - Last verified: 2024-08-15
  - Content: Step-by-step tutorials, code snippets
  - Authority: Microsoft documentation team

### Community Examples
- **dotnet/core GitHub Issues**: https://github.com/dotnet/core/issues?q=native+aot
  - Last verified: 2024-09-12
  - Content: Troubleshooting examples, community solutions
  - Authority: Developer community with Microsoft team oversight

- **Stack Overflow Native AOT Tag**: https://stackoverflow.com/questions/tagged/native-aot
  - Last verified: 2024-09-12
  - Content: Common problems and solutions
  - Authority: Developer community

## Validation Status

### Code Compilation Tests
- [x] Basic Native AOT publishing examples compile with .NET 8
- [x] File-based app examples work with .NET 10
- [x] ASP.NET Core minimal API examples functional
- [x] Cross-platform Docker examples verified

### Platform Compatibility Testing
- [x] Windows (x64, ARM64) with Visual Studio 2022
- [x] Linux (Ubuntu 22.04, Alpine 3.18) with clang
- [x] macOS (x64, ARM64) with XCode Command Line Tools

### Version Compatibility
- [x] .NET 7 basic Native AOT functionality
- [x] .NET 8 ASP.NET Core support
- [x] .NET 9 expanded platform support
- [x] .NET 10 file-based apps integration

## Update Schedule

### Regular Verification
- Monthly check of primary documentation links
- Quarterly validation of code examples
- Semi-annual cross-platform testing
- Annual performance benchmark updates

### Event-Based Updates
- New .NET version releases (.NET 11 preview updates)
- Native AOT feature additions or breaking changes
- Platform toolchain updates
- ASP.NET Core Native AOT improvements

## Quality Metrics

### Source Authority Grading
- **A+**: Official Microsoft documentation, runtime source code
- **A**: Microsoft team blogs, official samples
- **B+**: High-score Stack Overflow answers, verified community guides
- **B**: Platform-specific documentation from maintainers
- **C**: Unverified community content

### Content Freshness
- **Green**: Updated within last 6 months
- **Yellow**: Updated within last year
- **Red**: Older than 1 year, needs verification

### Validation Requirements
- All code examples must compile and run on target platforms
- Performance claims must have benchmarks
- Platform setup instructions must be verified
- Container examples must work with latest base images
- Cross-compilation examples must be tested

## Known Issues and Limitations Tracking

### Documentation Gaps
- Limited cross-OS compilation documentation
- Incomplete mobile platform (iOS/Android) guidance
- Missing enterprise deployment scenarios

### Community Feedback Integration
- Monitor GitHub issues for common problems
- Track Stack Overflow questions for documentation improvements
- Incorporate community performance benchmarks
- Update troubleshooting guides based on user experience

## Related Technology Sources

### Trimming and Single-File
- **Trimming Documentation**: https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/
- **Single-File Deployment**: https://docs.microsoft.com/en-us/dotnet/core/deploying/single-file/

### Source Generators
- **Source Generators Guide**: https://docs.microsoft.com/en-us/dotnet/csharp/roslyn-sdk/source-generators-overview
- **System.Text.Json Source Generation**: https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/source-generation

### Performance Optimization
- **ReadyToRun Documentation**: https://docs.microsoft.com/en-us/dotnet/core/deploying/ready-to-run
- **Profile-Guided Optimization**: https://docs.microsoft.com/en-us/dotnet/core/run-time-config/compilation