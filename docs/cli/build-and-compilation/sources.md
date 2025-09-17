# Build and Compilation - Sources

## Primary Sources (High Confidence)

### Official Microsoft Documentation
- **dotnet build Command Reference**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-build
  - Last verified: 2023-11-27
  - Content: Complete command syntax, options, examples, MSBuild integration
  - Authority: Microsoft .NET CLI documentation team

- **dotnet restore Command Reference**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-restore
  - Last verified: 2023-07-19
  - Content: Dependency restoration, package management, lock file usage
  - Authority: Microsoft .NET CLI documentation team

- **dotnet clean Command Reference**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-clean
  - Last verified: 2024-08-15
  - Content: Build artifact cleanup, configuration-specific cleaning
  - Authority: Microsoft .NET CLI documentation team

- **MSBuild Documentation**: https://docs.microsoft.com/en-us/visualstudio/msbuild/
  - Last verified: 2024-09-12
  - Content: Build system fundamentals, targets, properties, items
  - Authority: Microsoft MSBuild team

### Project System and SDK Documentation
- **Project File SDK Reference**: https://docs.microsoft.com/en-us/dotnet/core/project-sdk/overview
  - Last verified: 2024-08-10
  - Content: Modern project file format, properties, target frameworks
  - Authority: Microsoft .NET project system team

- **MSBuild Property Reference**: https://docs.microsoft.com/en-us/dotnet/core/project-sdk/msbuild-props
  - Last verified: 2024-07-25
  - Content: Complete list of MSBuild properties and their usage
  - Authority: Microsoft .NET SDK team

- **Target Framework Monikers**: https://docs.microsoft.com/en-us/dotnet/standard/frameworks
  - Last verified: 2024-06-20
  - Content: Framework targeting, compatibility, multi-targeting strategies
  - Authority: Microsoft .NET platform team

### Package Management Integration
- **NuGet CLI Reference**: https://docs.microsoft.com/en-us/nuget/reference/nuget-exe-cli-reference
  - Last verified: 2024-08-05
  - Content: Package restore, sources, authentication, configuration
  - Authority: Microsoft NuGet team

- **Package Lock Files**: https://docs.microsoft.com/en-us/nuget/consume-packages/package-references-in-project-files#locking-dependencies
  - Last verified: 2024-07-15
  - Content: Reproducible builds, lock file management, version pinning
  - Authority: Microsoft NuGet team

## Secondary Sources (Good Quality)

### Build Performance and Optimization
- **MSBuild Performance Guide**: https://docs.microsoft.com/en-us/visualstudio/msbuild/build-performance
  - Last verified: 2024-06-30
  - Content: Build acceleration, parallel builds, incremental compilation
  - Authority: Microsoft MSBuild team

- **Incremental Build Documentation**: https://docs.microsoft.com/en-us/visualstudio/msbuild/incremental-builds
  - Last verified: 2024-05-20
  - Content: Build optimization, dependency tracking, performance tuning
  - Authority: Microsoft MSBuild team

### CI/CD Integration Guides
- **GitHub Actions .NET Workflow**: https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-net
  - Last verified: 2024-08-20
  - Content: CI/CD best practices, build optimization, caching strategies
  - Authority: GitHub documentation team

- **Azure DevOps .NET Pipelines**: https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/dotnet-core
  - Last verified: 2024-07-10
  - Content: Enterprise CI/CD patterns, build agents, artifact management
  - Authority: Microsoft Azure DevOps team

### Multi-Targeting and Cross-Platform
- **Cross-Platform Targeting**: https://docs.microsoft.com/en-us/dotnet/standard/library-guidance/cross-platform-targeting
  - Last verified: 2024-06-15
  - Content: Platform considerations, compatibility strategies, best practices
  - Authority: Microsoft .NET library guidance team

- **Runtime Identifier (RID) Catalog**: https://docs.microsoft.com/en-us/dotnet/core/rid-catalog
  - Last verified: 2024-08-25
  - Content: Platform identifiers, cross-compilation, deployment targets
  - Authority: Microsoft .NET platform team

## Code Examples Sources

### Official Sample Repository
- **Build and Test Samples**: https://github.com/dotnet/samples/tree/main/core
  - Last verified: 2024-08-15
  - Content: Working build configurations, multi-targeting examples
  - Authority: Microsoft .NET samples team

### Documentation Code Snippets
- **docs/samples**: https://github.com/dotnet/docs/tree/main/docs/core/tools
  - Last verified: 2024-07-20
  - Content: Command examples, configuration patterns, troubleshooting
  - Authority: Microsoft documentation team

### Community Examples
- **Stack Overflow .NET Build Questions**: https://stackoverflow.com/questions/tagged/dotnet-build
  - Last verified: 2024-09-12
  - Content: Common problems, solutions, optimization techniques
  - Authority: Developer community

## Validation Status

### Code Compilation Tests
- [x] Basic build commands work across .NET versions (.NET 6, 7, 8, 9)
- [x] Multi-targeting examples compile successfully
- [x] CI/CD pipeline configurations functional
- [x] Performance optimization techniques validated

### Cross-Platform Testing
- [x] Windows (x64, ARM64) build behavior
- [x] Linux (x64, ARM64) compilation and dependencies
- [x] macOS (x64, ARM64) SDK compatibility

### Version Compatibility
- [x] .NET Core 3.1 build system basics
- [x] .NET 5 improvements and features
- [x] .NET 6 performance optimizations
- [x] .NET 7 build enhancements
- [x] .NET 8 new features and artifact paths
- [x] .NET 9 latest improvements

## Update Schedule

### Regular Verification
- Monthly check of primary documentation links
- Quarterly validation of build examples and configurations
- Semi-annual cross-platform testing
- Annual performance benchmark updates

### Event-Based Updates
- New .NET version releases with build system changes
- MSBuild version updates and new features
- CLI command additions or breaking changes
- Performance optimization discoveries

## Quality Metrics

### Source Authority Grading
- **A+**: Official Microsoft documentation, MSBuild reference, CLI command docs
- **A**: Microsoft team blogs, official samples, SDK documentation
- **B+**: High-score Stack Overflow answers, verified community guides
- **B**: Community performance benchmarks, CI/CD specific guides
- **C**: Unverified community content, outdated examples

### Content Freshness
- **Green**: Updated within last 6 months
- **Yellow**: Updated within last year, needs verification
- **Red**: Older than 1 year, potential accuracy issues

### Validation Requirements
- All command examples must work with latest .NET SDK
- Build configurations must compile successfully
- Performance claims must have benchmarks
- CI/CD examples must work in real environments
- Multi-targeting scenarios must be tested across platforms

## Known Issues and Limitations Tracking

### Build System Evolution
- Track MSBuild version changes and feature additions
- Monitor CLI command modifications and deprecations
- Watch for breaking changes in project file format
- Follow performance improvement announcements

### Documentation Gaps
- Limited guidance for complex MSBuild customizations
- Incomplete coverage of enterprise build scenarios
- Missing troubleshooting guides for specific error conditions
- Insufficient performance optimization strategies for large solutions

### Community Feedback Integration
- Monitor GitHub issues for build system problems
- Track Stack Overflow questions for common pain points
- Incorporate community performance optimization techniques
- Update troubleshooting guides based on real-world issues

## Related Technology Sources

### Testing Integration
- **dotnet test Documentation**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-test
- **Test Project Configuration**: Testing framework integration with build system

### Publishing Integration
- **dotnet publish Documentation**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish
- **Deployment Strategies**: Build artifacts and publishing workflow integration

### Package Development
- **dotnet pack Documentation**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-pack
- **NuGet Package Creation**: Library packaging and distribution

### Code Analysis Integration
- **Code Analysis Configuration**: https://docs.microsoft.com/en-us/dotnet/fundamentals/code-analysis/
- **Analyzer Integration**: Build-time code analysis and quality tools

## Maintenance Notes

### Regular Review Items
- New MSBuild properties and targets
- CLI command option additions
- Build performance improvements
- Cross-platform compatibility changes

### Version Compatibility Matrix
Track compatibility across:
- .NET SDK versions (6.x, 7.x, 8.x, 9.x)
- MSBuild versions and feature sets
- Platform-specific build behaviors
- CI/CD system integrations