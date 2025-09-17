# Publishing and Deployment - Golden Reference

## Overview
Publishing and deployment is the distribution-time workflow that transforms build artifacts into production-ready applications. The .NET CLI provides multiple publishing modes optimized for different deployment scenarios, from simple framework-dependent deployments to highly optimized Native AOT executables.

Publishing fundamentally differs from building:
- **Build**: Development-time compilation for testing and debugging
- **Publish**: Distribution-time packaging for production deployment

Core publishing principles:
- **Deployment target awareness**: Framework-dependent vs self-contained strategies
- **Performance optimization**: ReadyToRun, trimming, Native AOT compilation
- **Distribution optimization**: Single-file packaging, container deployment
- **Platform targeting**: Runtime identifier (RID) specification for cross-platform deployment

The publishing system serves multiple deployment scenarios:
- **Desktop applications**: Self-contained executables with optimal startup
- **Cloud services**: Container-optimized deployments with minimal footprint
- **IoT devices**: Trimmed applications for resource-constrained environments
- **Enterprise applications**: Framework-dependent deployments with shared runtimes

## Publishing Modes Overview

### Framework-Dependent Deployment (Default)
**Use case**: Shared runtime environments, enterprise deployments
**Benefits**: Smallest deployment size, automatic security updates, cross-platform portability
**Requirements**: Target runtime must be pre-installed

```bash
# Basic framework-dependent publishing
dotnet publish                            # Current platform, Debug config
dotnet publish -c Release                # Release configuration
dotnet publish -r win-x64                # Platform-specific executable
dotnet publish -f net8.0                 # Specific target framework
```

### Self-Contained Deployment
**Use case**: Isolated deployments, controlled runtime versions
**Benefits**: No runtime installation required, version control, deployment independence
**Trade-offs**: Larger deployment size, manual security updates

```bash
# Self-contained publishing
dotnet publish -r win-x64 --self-contained        # Windows 64-bit
dotnet publish -r linux-x64 --self-contained      # Linux 64-bit
dotnet publish -r osx-arm64 --self-contained      # macOS Apple Silicon
```

### Single-File Deployment
**Use case**: Simplified distribution, desktop applications, utility tools
**Benefits**: Single executable file, easy deployment, reduced file clutter
**Considerations**: Larger executable size, slower cold start

```bash
# Single-file deployment
dotnet publish -r win-x64 -p:PublishSingleFile=true
dotnet publish -r linux-x64 -p:PublishSingleFile=true --self-contained
```

### ReadyToRun Compilation
**Use case**: Improved startup performance, frequent application restarts
**Benefits**: Faster startup time, reduced JIT overhead, better first-run performance
**Trade-offs**: Larger deployment size, longer build time

```bash
# ReadyToRun publishing
dotnet publish -r win-x64 -p:PublishReadyToRun=true
dotnet publish -c Release -p:PublishReadyToRun=true --self-contained
```

### Native AOT Deployment
**Use case**: Ultimate performance, memory-constrained environments, cloud functions
**Benefits**: Fastest startup, smallest memory footprint, no runtime dependency
**Limitations**: Limited reflection support, framework compatibility restrictions

```bash
# Native AOT publishing
dotnet publish -r win-x64 -p:PublishAot=true
dotnet publish -r linux-x64 -p:PublishAot=true -c Release
```

### Container Deployment
**Use case**: Cloud-native applications, microservices, scalable deployments
**Benefits**: Consistent deployment environment, scalability, cloud integration
**Integration**: Direct container image creation without Dockerfile

```bash
# Container publishing (.NET 8+)
dotnet publish -t:PublishContainer
dotnet publish -t:PublishContainer -r linux-x64
dotnet publish -p:PublishProfile=DefaultContainer
```

## Publishing Mode Decision Matrix

### By Deployment Scenario

| Scenario | Recommended Mode | Rationale |
|----------|------------------|-----------|
| **Enterprise Web Apps** | Framework-dependent | Shared runtime, security updates, smaller deployments |
| **Desktop Applications** | Self-contained + Single-file | No runtime dependency, easy distribution |
| **Cloud Microservices** | Container + ReadyToRun | Fast startup, consistent environment |
| **Serverless Functions** | Native AOT | Fastest cold start, minimal memory usage |
| **IoT Devices** | Self-contained + Trimmed | Resource constraints, no runtime installation |
| **Development Tools** | Single-file | Easy distribution, developer experience |

### By Performance Requirements

| Priority | Deployment Size | Startup Time | Memory Usage | Recommended Approach |
|----------|----------------|--------------|--------------|---------------------|
| **Minimal Size** | Framework-dependent | Framework-dependent | Native AOT | Framework-dependent |
| **Fastest Startup** | Native AOT | Native AOT | Native AOT | Native AOT |
| **Lowest Memory** | Native AOT | Native AOT | Native AOT | Native AOT + Trimming |
| **Balanced** | Self-contained + ReadyToRun | ReadyToRun | Self-contained | Self-contained + ReadyToRun |

## Advanced Publishing Configuration

### Optimization Combinations
```bash
# Maximum optimization for cloud deployment
dotnet publish -r linux-x64 -c Release \
  -p:PublishSingleFile=true \
  -p:PublishTrimmed=true \
  -p:PublishReadyToRun=true

# Ultimate performance (Native AOT + trimming)
dotnet publish -r linux-x64 -c Release \
  -p:PublishAot=true \
  -p:StripSymbols=true

# Container-optimized deployment
dotnet publish -t:PublishContainer \
  -p:PublishTrimmed=true \
  -p:InvariantGlobalization=true
```

### Platform-Specific Targeting
```bash
# Cross-platform deployment matrix
dotnet publish -r win-x64 -c Release      # Windows 64-bit
dotnet publish -r win-arm64 -c Release    # Windows ARM64
dotnet publish -r linux-x64 -c Release    # Linux 64-bit
dotnet publish -r linux-arm64 -c Release  # Linux ARM64
dotnet publish -r osx-x64 -c Release      # macOS Intel
dotnet publish -r osx-arm64 -c Release    # macOS Apple Silicon
```

### Custom Output Configuration
```bash
# Custom output paths and naming
dotnet publish -o /deploy/artifacts       # Custom output directory
dotnet publish --artifacts-path /build   # Centralized artifacts (.NET 8+)

# Version and metadata control
dotnet publish -p:VersionPrefix=1.2.3    # Version override
dotnet publish -p:AssemblyVersion=1.0.0  # Assembly version
dotnet publish -p:VersionSuffix=beta     # Pre-release suffix
```

## Performance and Size Optimization

### Build-Time Optimizations
```xml
<!-- Project file optimizations -->
<PropertyGroup Condition="'$(Configuration)' == 'Release'">
    <PublishTrimmed>true</PublishTrimmed>
    <PublishSingleFile>true</PublishSingleFile>
    <PublishReadyToRun>true</PublishReadyToRun>
    <IncludeNativeLibrariesForSelfExtract>true</IncludeNativeLibrariesForSelfExtract>
</PropertyGroup>

<!-- Size reduction features -->
<PropertyGroup>
    <InvariantGlobalization>true</InvariantGlobalization>
    <EventSourceSupport>false</EventSourceSupport>
    <HttpActivityPropagationSupport>false</HttpActivityPropagationSupport>
</PropertyGroup>
```

### Runtime Configuration
```json
// runtimeconfig.template.json
{
  "configProperties": {
    "System.GC.Server": true,
    "System.GC.Concurrent": true,
    "System.Threading.ThreadPool.MinThreads": 4,
    "System.Threading.ThreadPool.MaxThreads": 25
  }
}
```

### Framework Feature Control
```bash
# Disable unnecessary framework features
dotnet publish -r linux-x64 -c Release \
  -p:DebuggerSupport=false \
  -p:EventSourceSupport=false \
  -p:UseSystemResourceKeys=true
```

## Deployment Automation and CI/CD

### Optimized CI/CD Pipeline
```bash
# Production-ready pipeline sequence
dotnet restore --locked-mode              # Reproducible dependencies
dotnet build --no-restore -c Release      # Skip redundant restore
dotnet test --no-build -c Release         # Test built artifacts
dotnet publish --no-build -c Release -r linux-x64 -o ./publish
```

### Multi-Platform Deployment
```bash
# Build matrix for multiple platforms
PLATFORMS="win-x64 linux-x64 osx-x64 osx-arm64"
for platform in $PLATFORMS; do
  dotnet publish -r $platform -c Release -o "./dist/$platform"
done
```

### Container Integration
```dockerfile
# Multi-stage Docker build with optimized publishing
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -r linux-x64 -c Release -o /app/publish \
    -p:PublishTrimmed=true -p:PublishSingleFile=true

FROM mcr.microsoft.com/dotnet/runtime-deps:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["./MyApp"]
```

## Common Deployment Scenarios

### Desktop Application Distribution
```bash
# Self-contained desktop app with installer-ready output
dotnet publish -r win-x64 -c Release \
  -p:PublishSingleFile=true \
  -p:IncludeNativeLibrariesForSelfExtract=true \
  -p:PublishReadyToRun=true
```

### Web Application Deployment
```bash
# Web app optimized for container deployment
dotnet publish -r linux-x64 -c Release \
  -p:PublishTrimmed=true \
  -p:InvariantGlobalization=true \
  -o ./publish
```

### Microservice Deployment
```bash
# Microservice with fastest startup for cloud deployment
dotnet publish -r linux-x64 -c Release \
  -p:PublishAot=true \
  -p:StripSymbols=true \
  -p:InvariantGlobalization=true
```

### Cross-Platform Library Distribution
```bash
# Framework-dependent library for NuGet distribution
dotnet publish -c Release                # Portable deployment
dotnet pack -c Release                   # Create NuGet package
```

## Troubleshooting and Diagnostics

### Common Publishing Issues
```bash
# Diagnostic publishing for troubleshooting
dotnet publish -v diagnostic             # Detailed output
dotnet publish --no-build               # Skip build phase
dotnet publish --no-restore             # Skip restore phase

# Verify publishing requirements
dotnet --list-runtimes                   # Available runtimes
dotnet --list-sdks                       # Available SDKs
```

### Platform Compatibility Verification
```bash
# Test published application
./MyApp                                  # Direct execution test
dotnet MyApp.dll                        # Runtime hosting test

# Dependency verification
ldd MyApp                               # Linux dependency check
dumpbin /dependents MyApp.exe           # Windows dependency check
```

### Performance Analysis
```bash
# Measure deployment characteristics
du -sh publish/                         # Deployment size
time ./MyApp                            # Startup performance
ps aux | grep MyApp                     # Memory usage
```

## Integration with Development Workflow

### Local Development Testing
```bash
# Test different publishing modes locally
dotnet publish -c Debug                 # Debug symbols included
dotnet publish -c Release               # Production simulation
dotnet publish -r $(dotnet --info | grep RID | cut -d: -f2 | tr -d ' ')
```

### Publishing Profile Management
```xml
<!-- Properties/PublishProfiles/FolderProfile.pubxml -->
<Project>
  <PropertyGroup>
    <PublishDir>bin\Release\net8.0\publish\</PublishDir>
    <PublishProtocol>FileSystem</PublishProtocol>
    <TargetFramework>net8.0</TargetFramework>
    <RuntimeIdentifier>win-x64</RuntimeIdentifier>
    <SelfContained>true</SelfContained>
    <PublishSingleFile>true</PublishSingleFile>
    <PublishReadyToRun>true</PublishReadyToRun>
  </PropertyGroup>
</Project>
```

### Quality Assurance Integration
```bash
# Publishing validation workflow
dotnet publish -c Release -r linux-x64
# Test published application
cd publish && ./MyApp --version
# Verify all dependencies included
ldd MyApp || echo "Self-contained verified"
```

## See Also
- **Build and compilation**: Development-time workflows, dependency management
- **Native AOT**: Ultimate performance optimization and compilation strategies
- **Assembly trimming**: Size reduction techniques and compatibility considerations
- **Container deployment**: Cloud-native deployment patterns and optimization