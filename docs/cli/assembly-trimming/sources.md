# Assembly Trimming - Sources

## Primary Sources (High Confidence)

### Official Microsoft Documentation
- **Trim Self-Contained Applications**: https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/trim-self-contained
  - Last verified: 2020-04-03
  - Content: Core concepts, enabling trimming, basic configuration
  - Authority: Microsoft .NET documentation team

- **Trimming Options Reference**: https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/trimming-options
  - Last verified: 2025-05-01
  - Content: Complete MSBuild property reference, feature switches, configuration options
  - Authority: Microsoft .NET documentation team

- **Known Trimming Incompatibilities**: https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/incompatibilities
  - Last verified: 2023-11-08
  - Content: Framework limitations, incompatible patterns, alternative solutions
  - Authority: Microsoft .NET documentation team

- **Prepare Libraries for Trimming**: https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/prepare-libraries-for-trimming
  - Last verified: 2023-06-12
  - Content: Library authoring best practices, annotation usage, warning resolution
  - Authority: Microsoft .NET documentation team

### Tool Documentation and Implementation
- **ILLink Tool Documentation**: https://github.com/dotnet/runtime/tree/main/docs/tools/illink
  - Last verified: 2024-09-12
  - Content: Underlying trimmer implementation, warning codes, advanced options
  - Authority: Microsoft .NET runtime team

- **Feature Switches Documentation**: https://github.com/dotnet/runtime/blob/main/docs/workflow/trimming/feature-switches.md
  - Last verified: 2024-08-15
  - Content: Framework feature control, runtime configuration options
  - Authority: Microsoft .NET runtime team

### Warning Resolution Guides
- **Introduction to Trim Warnings**: https://docs.microsoft.com/en-us/dotnet/core/deploying/trimming/fixing-warnings
  - Last verified: 2024-07-20
  - Content: Common warning patterns, resolution strategies, annotation guidance
  - Authority: Microsoft .NET documentation team

- **Warning Codes Reference**: https://github.com/dotnet/runtime/blob/main/docs/tools/illink/error-codes.md#warning-codes
  - Last verified: 2024-09-12
  - Content: Complete list of trim warning codes and meanings
  - Authority: Microsoft .NET runtime team

## Secondary Sources (Good Quality)

### Analysis and Attribution Documentation
- **DynamicallyAccessedMembers Documentation**: https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.codeanalysis.dynamicallyaccessedmembersattribute
  - Last verified: 2024-06-15
  - Content: Attribute usage patterns, member preservation strategies
  - Authority: Microsoft API documentation team

- **RequiresUnreferencedCode Documentation**: https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.codeanalysis.requiresunreferencedcodeattribute
  - Last verified: 2024-06-15
  - Content: Marking trim-incompatible APIs, warning propagation
  - Authority: Microsoft API documentation team

### Integration Guides
- **Native AOT Integration**: https://docs.microsoft.com/en-us/dotnet/core/deploying/native-aot/
  - Last verified: 2023-06-12
  - Content: Trimming with Native AOT, automatic enabling, size optimization
  - Authority: Microsoft .NET documentation team

- **Single-File Deployment**: https://docs.microsoft.com/en-us/dotnet/core/deploying/single-file/
  - Last verified: 2024-08-10
  - Content: Combining trimming with single-file packaging
  - Authority: Microsoft .NET documentation team

### Community and Performance Resources
- **Stack Overflow Trimming Questions**: https://stackoverflow.com/questions/tagged/dotnet-trimming
  - Last verified: 2024-09-12
  - Content: Common problems, community solutions, real-world experiences
  - Authority: Developer community

- **Performance Benchmarks**: Various community blogs and Microsoft performance posts
  - Last verified: 2024-08-15
  - Content: Size reduction measurements, startup time improvements
  - Authority: Community contributors with Microsoft team oversight

## Code Examples Sources

### Official Sample Repository
- **Trimming Samples**: https://github.com/dotnet/samples/tree/main/core
  - Last verified: 2024-08-15
  - Content: Working examples, before/after size comparisons
  - Authority: Microsoft .NET samples team

### Documentation Code Snippets
- **docs/samples**: https://github.com/dotnet/docs/tree/main/docs/core/deploying/trimming/snippets
  - Last verified: 2024-07-20
  - Content: Step-by-step examples, configuration patterns
  - Authority: Microsoft documentation team

### Library Examples
- **System.Text.Json Source Generation**: https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/source-generation
  - Last verified: 2023-10-09
  - Content: Trim-compatible serialization patterns
  - Authority: Microsoft documentation team

## Validation Status

### Code Compilation Tests
- [x] Basic PublishTrimmed examples compile with .NET 8
- [x] Library annotation examples work correctly
- [x] Feature switch configurations validated
- [x] Warning resolution patterns tested

### Cross-Platform Testing
- [x] Windows (x64, ARM64) trimming behavior
- [x] Linux (x64, ARM64) size reduction verification
- [x] macOS (x64, ARM64) compatibility testing

### Version Compatibility
- [x] .NET Core 3.1 experimental features
- [x] .NET 5 experimental improvements
- [x] .NET 6 full support and stability
- [x] .NET 7 enhanced library support
- [x] .NET 8 performance improvements and new features

## Update Schedule

### Regular Verification
- Monthly check of primary documentation links
- Quarterly validation of code examples and configurations
- Semi-annual cross-platform testing
- Annual performance benchmark updates

### Event-Based Updates
- New .NET version releases with trimming improvements
- ILLink tool updates and new warning codes
- Framework compatibility changes (WPF/WinForms support)
- New attribute types and annotation patterns

## Quality Metrics

### Source Authority Grading
- **A+**: Official Microsoft documentation, runtime source code
- **A**: Microsoft team blogs, official samples, tool documentation
- **B+**: High-score Stack Overflow answers, verified community guides
- **B**: Community performance benchmarks, library-specific guides
- **C**: Unverified community content, outdated examples

### Content Freshness
- **Green**: Updated within last 6 months
- **Yellow**: Updated within last year, needs verification
- **Red**: Older than 1 year, potential accuracy issues

### Validation Requirements
- All code examples must compile and run with trimming enabled
- Size reduction claims must have benchmarks
- Warning resolution examples must be tested
- Library compatibility advice must be verified across versions
- Framework incompatibility information must be current

## Known Issues and Limitations Tracking

### Framework Compatibility Status
- **WPF**: Currently disabled, track GitHub issue progress
- **Windows Forms**: Currently disabled, monitor compatibility work
- **Blazor**: Supported with specific patterns and limitations
- **Entity Framework**: Limited support, evolving compatibility

### Documentation Gaps
- Limited guidance for complex reflection scenarios
- Incomplete coverage of third-party library compatibility
- Missing performance optimization strategies
- Insufficient troubleshooting guides for specific warning codes

### Community Feedback Integration
- Monitor GitHub issues for trimming problems
- Track Stack Overflow questions for common pain points
- Incorporate community size reduction benchmarks
- Update warning resolution strategies based on real-world usage

## Related Technology Sources

### Source Generation
- **Source Generators Overview**: https://docs.microsoft.com/en-us/dotnet/csharp/roslyn-sdk/source-generators-overview
- **Configuration Binding Source Generator**: https://docs.microsoft.com/en-us/dotnet/core/whats-new/dotnet-8/runtime#configuration-binding-source-generator

### Deployment Optimization
- **ReadyToRun Compilation**: https://docs.microsoft.com/en-us/dotnet/core/deploying/ready-to-run
- **Container Optimization**: https://docs.microsoft.com/en-us/dotnet/core/containers/

### Alternative Serialization
- **System.Text.Json Migration**: https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/migrate-from-newtonsoft
- **BinaryFormatter Migration**: https://docs.microsoft.com/en-us/dotnet/core/compatibility/serialization/5.0/binaryformatter-serialization-obsolete

### Static Analysis Tools
- **Roslyn Analyzers**: https://docs.microsoft.com/en-us/dotnet/fundamentals/code-analysis/overview
- **Trim Analysis Integration**: Documentation for IDE and CI/CD integration

## Maintenance Notes

### Regular Review Items
- New MSBuild properties and feature switches
- Changes to framework default behavior
- Updates to warning codes and error messages
- Library ecosystem compatibility improvements

### Version Compatibility Matrix
Track compatibility across:
- .NET versions (.NET 6, 7, 8, 9, 10+)
- Target frameworks (net6.0, net8.0, etc.)
- Platform restrictions (Windows, Linux, macOS)
- Architecture support (x64, ARM64, x86)