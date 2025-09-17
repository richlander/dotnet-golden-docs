# Publishing and Deployment - Sources

## Primary Sources (High Confidence)

### Official Microsoft Documentation
- **dotnet publish Command Reference**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish
  - Last verified: 2025-01-07
  - Content: Complete command syntax, MSBuild integration, publish profiles
  - Authority: Microsoft .NET CLI documentation team

- **.NET Application Publishing Overview**: https://docs.microsoft.com/en-us/dotnet/core/deploying/index
  - Last verified: 2025-08-11
  - Content: Publishing modes comparison, deployment strategies, decision guidance
  - Authority: Microsoft .NET documentation team

- **Runtime Identifier (RID) Catalog**: https://docs.microsoft.com/en-us/dotnet/core/rid-catalog
  - Last verified: 2024-08-25
  - Content: Platform identifiers, cross-platform deployment, supported architectures
  - Authority: Microsoft .NET platform team

- **Self-Contained Deployment**: https://docs.microsoft.com/en-us/dotnet/core/deploying/index#self-contained-deployment
  - Last verified: 2025-08-11
  - Content: Self-contained deployment benefits, configuration, considerations
  - Authority: Microsoft .NET documentation team

### Deployment Mode Documentation
- **Single-File Deployment**: https://docs.microsoft.com/en-us/dotnet/core/deploying/single-file/overview
  - Last verified: 2024-08-15
  - Content: Single-file bundling, limitations, configuration options
  - Authority: Microsoft .NET deployment team

- **ReadyToRun Compilation**: https://docs.microsoft.com/en-us/dotnet/core/deploying/ready-to-run
  - Last verified: 2024-07-15
  - Content: Ahead-of-time compilation, performance benefits, usage patterns
  - Authority: Microsoft .NET runtime team

- **Native AOT Deployment**: https://docs.microsoft.com/en-us/dotnet/core/deploying/native-aot/
  - Last verified: 2023-06-12
  - Content: Native compilation, performance optimization, compatibility
  - Authority: Microsoft .NET runtime team

- **Container Deployment**: https://docs.microsoft.com/en-us/dotnet/core/containers/overview
  - Last verified: 2024-08-05
  - Content: Container image creation, optimization, cloud deployment
  - Authority: Microsoft containers team

### Framework and Runtime Documentation
- **Application Hosting**: https://docs.microsoft.com/en-us/dotnet/core/deploying/index#framework-dependent-deployment
  - Last verified: 2025-08-11
  - Content: Framework-dependent deployment, host configuration, runtime selection
  - Authority: Microsoft .NET hosting team

- **.NET Version Selection**: https://docs.microsoft.com/en-us/dotnet/core/versions/selection
  - Last verified: 2024-09-10
  - Content: Runtime version binding, roll-forward behavior, compatibility
  - Authority: Microsoft .NET platform team

## Secondary Sources (Good Quality)

### Performance and Optimization Guides
- **Deployment Performance Best Practices**: https://docs.microsoft.com/en-us/dotnet/core/deploying/trim-self-contained
  - Last verified: 2020-04-03
  - Content: Size optimization, trimming strategies, performance tuning
  - Authority: Microsoft .NET performance team

- **Cloud Deployment Optimization**: Various Azure and AWS documentation
  - Last verified: 2024-08-20
  - Content: Cloud-specific deployment patterns, container optimization
  - Authority: Cloud platform teams

### CI/CD Integration Guides
- **GitHub Actions .NET Deployment**: https://docs.github.com/en/actions/deployment/deploying-to-your-cloud-provider
  - Last verified: 2024-08-15
  - Content: Automated deployment workflows, multi-platform builds
  - Authority: GitHub documentation team

- **Azure DevOps .NET Pipelines**: https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/dotnet-core
  - Last verified: 2024-07-10
  - Content: CI/CD pipeline configuration, artifact management
  - Authority: Microsoft Azure DevOps team

### Container and Cloud Platform Documentation
- **Docker .NET Images**: https://hub.docker.com/_/microsoft-dotnet
  - Last verified: 2024-09-10
  - Content: Official base images, optimization strategies, usage patterns
  - Authority: Microsoft container team

- **Kubernetes .NET Deployment**: https://docs.microsoft.com/en-us/dotnet/architecture/containerized-lifecycle/
  - Last verified: 2024-06-20
  - Content: Container orchestration, scaling, cloud-native patterns
  - Authority: Microsoft cloud architecture team

## Code Examples Sources

### Official Sample Repository
- **Deployment Samples**: https://github.com/dotnet/samples/tree/main/core
  - Last verified: 2024-08-15
  - Content: Working deployment examples, multi-platform configurations
  - Authority: Microsoft .NET samples team

### Documentation Code Snippets
- **docs/samples**: https://github.com/dotnet/docs/tree/main/docs/core/deploying
  - Last verified: 2024-07-20
  - Content: Step-by-step deployment examples, configuration patterns
  - Authority: Microsoft documentation team

### Container Examples
- **Container Samples**: https://github.com/dotnet/dotnet-docker/tree/main/samples
  - Last verified: 2024-08-10
  - Content: Dockerfile examples, multi-stage builds, optimization patterns
  - Authority: Microsoft container team

## Validation Status

### Code Compilation Tests
- [x] Publishing commands work across .NET versions (6, 7, 8, 9)
- [x] Multi-platform publishing examples functional
- [x] Container deployment configurations validated
- [x] Optimization combinations tested

### Cross-Platform Testing
- [x] Windows (x64, ARM64) publishing and execution
- [x] Linux (x64, ARM64) deployment verification
- [x] macOS (x64, ARM64) application startup

### Version Compatibility
- [x] .NET Core 3.1 basic publishing features
- [x] .NET 5 single-file and trimming improvements
- [x] .NET 6 container and ReadyToRun enhancements
- [x] .NET 7 Native AOT and performance improvements
- [x] .NET 8 container publishing and optimization features
- [x] .NET 9 latest deployment capabilities

## Update Schedule

### Regular Verification
- Monthly check of primary documentation links
- Quarterly validation of deployment examples and configurations
- Semi-annual cross-platform testing
- Annual performance benchmark updates

### Event-Based Updates
- New .NET version releases with deployment improvements
- Container platform updates and new base images
- Cloud platform deployment feature additions
- Performance optimization discoveries

## Quality Metrics

### Source Authority Grading
- **A+**: Official Microsoft documentation, CLI command reference, deployment guides
- **A**: Microsoft team blogs, official samples, platform-specific guides
- **B+**: High-score Stack Overflow answers, verified community deployment guides
- **B**: Cloud platform documentation, CI/CD specific guides
- **C**: Unverified community content, outdated deployment examples

### Content Freshness
- **Green**: Updated within last 6 months
- **Yellow**: Updated within last year, needs verification
- **Red**: Older than 1 year, potential accuracy issues

### Validation Requirements
- All publishing commands must work with latest .NET SDK
- Deployment configurations must work in production-like environments
- Performance claims must have benchmarks
- Container examples must work with latest base images
- Multi-platform scenarios must be tested across target platforms

## Known Issues and Limitations Tracking

### Platform-Specific Limitations
- Track ARM64 support evolution across platforms
- Monitor container base image updates and breaking changes
- Watch for platform-specific deployment restrictions
- Follow cross-compilation capability improvements

### Documentation Gaps
- Limited guidance for enterprise deployment scenarios
- Incomplete coverage of hybrid cloud deployments
- Missing troubleshooting guides for specific deployment failures
- Insufficient performance optimization strategies for large applications

### Community Feedback Integration
- Monitor GitHub issues for deployment problems
- Track Stack Overflow questions for common deployment pain points
- Incorporate community optimization techniques
- Update troubleshooting guides based on real-world deployment issues

## Related Technology Sources

### Build System Integration
- **dotnet build Documentation**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-build
- **MSBuild Publishing Targets**: Integration between build and publish workflows

### Testing Integration
- **dotnet test Documentation**: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-test
- **Testing in Deployment Pipelines**: Integration patterns for CI/CD

### Package Management
- **NuGet Deployment**: https://docs.microsoft.com/en-us/nuget/create-packages/
- **Library Distribution**: Publishing strategies for reusable components

### Security and Signing
- **Code Signing**: https://docs.microsoft.com/en-us/dotnet/core/deploying/
- **Secure Deployment**: Security considerations for production deployments

## Maintenance Notes

### Regular Review Items
- New publishing modes and deployment strategies
- Container base image updates and security patches
- Cloud platform deployment feature additions
- Performance optimization techniques

### Version Compatibility Matrix
Track compatibility across:
- .NET SDK versions (6.x, 7.x, 8.x, 9.x, 10.x)
- Target framework versions and deployment modes
- Platform-specific deployment behaviors
- Container runtime and orchestration systems

### Enterprise Deployment Considerations
- Large-scale deployment automation
- Security compliance requirements
- Multi-environment deployment strategies
- Rollback and disaster recovery patterns