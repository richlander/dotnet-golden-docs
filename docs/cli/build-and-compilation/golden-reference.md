# Build and Compilation - Golden Reference

## Overview

Build and compilation is the foundational development workflow that transforms source code into executable binaries, manages project dependencies, and prepares applications for testing and deployment. The .NET CLI provides a unified, cross-platform build experience through MSBuild integration that works consistently across Windows, macOS, and Linux.

Core build workflow stages:

1. **Dependency resolution**: Restore NuGet packages and project references
2. **Compilation**: Transform source code to Intermediate Language (IL)
3. **Assembly generation**: Create .dll files and executable binaries
4. **Asset preparation**: Generate runtime configuration and dependency files

Key principles:

- **Incremental builds**: Only rebuild changed components for performance
- **Parallel compilation**: Utilize multiple CPU cores for faster builds
- **Multi-targeting**: Build for multiple .NET framework versions simultaneously
- **Configuration-based**: Support Debug, Release, and custom build configurations

The build system serves multiple audiences:

- **Developers**: Local development and debugging workflows
- **DevOps engineers**: CI/CD pipeline automation and optimization
- **Build engineers**: Complex build orchestration and performance tuning

## Essential Commands and Syntax

### Core Build Commands

```bash
# Basic build operations
dotnet build                              # Build current project/solution
dotnet build MyProject.csproj            # Build specific project
dotnet build MySolution.sln              # Build entire solution
dotnet build -c Release                  # Build in Release configuration
dotnet build -f net8.0                   # Build specific target framework

# Clean operations
dotnet clean                              # Remove build artifacts
dotnet clean -c Release                  # Clean specific configuration
dotnet clean -f net8.0                   # Clean specific framework

# Restore operations
dotnet restore                            # Restore dependencies
dotnet restore --no-cache                # Force fresh package download
dotnet restore --locked-mode             # Use lock file for reproducible builds
```

### Advanced Build Configuration

```bash
# Multi-targeting and platform builds
dotnet build -f net8.0                   # Target specific framework
dotnet build -r win-x64                  # Target specific runtime
dotnet build --self-contained            # Include runtime in output
dotnet build --no-self-contained         # Framework-dependent build

# Performance and optimization
dotnet build --no-restore                # Skip restore phase
dotnet build --no-dependencies           # Build only specified project
dotnet build --no-incremental            # Force full rebuild
dotnet build -m:1                        # Limit parallel builds

# Diagnostic and troubleshooting
dotnet build -v diagnostic               # Detailed build output
dotnet build -p:TreatWarningsAsErrors=true # Treat warnings as errors
dotnet build --disable-build-servers     # Disable build server caching
```

### MSBuild Integration and Properties

```bash
# MSBuild property overrides
dotnet build -p:Configuration=Release    # Set build configuration
dotnet build -p:VersionPrefix=1.2.3     # Override version
dotnet build -p:OutputPath=/custom/path  # Custom output directory

# Advanced MSBuild options
dotnet build -p:PublishReadyToRun=true   # Enable ReadyToRun compilation
dotnet build -p:DebugType=portable       # Portable debug symbols
dotnet build -p:Deterministic=true       # Reproducible builds
```

### Project and Solution Management

```bash
# Solution-level operations
dotnet build                              # Build all projects in solution
dotnet build --project MyApp             # Build specific project in solution
dotnet build /m:4                        # Control parallel project builds

# Multi-framework builds
dotnet build -f net8.0 -f net6.0        # Build multiple frameworks
dotnet build --framework net8.0          # Build single framework explicitly
```

## Build Configurations and Environments

### Standard Build Configurations

```xml
<!-- Debug configuration (default) -->
<PropertyGroup Condition="'$(Configuration)' == 'Debug'">
    <DebugSymbols>true</DebugSymbols>
    <DebugType>portable</DebugType>
    <Optimize>false</Optimize>
    <DefineConstants>DEBUG;TRACE</DefineConstants>
</PropertyGroup>

<!-- Release configuration -->
<PropertyGroup Condition="'$(Configuration)' == 'Release'">
    <DebugType>pdbonly</DebugType>
    <Optimize>true</Optimize>
    <DefineConstants>TRACE</DefineConstants>
    <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
</PropertyGroup>
```

### Custom Build Configurations

```xml
<!-- Production configuration -->
<PropertyGroup Condition="'$(Configuration)' == 'Production'">
    <Optimize>true</Optimize>
    <DebugType>none</DebugType>
    <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
    <PublishTrimmed>true</PublishTrimmed>
</PropertyGroup>
```

### Multi-Targeting Configuration

```xml
<!-- Multi-target framework setup -->
<PropertyGroup>
    <TargetFrameworks>net8.0;net6.0;netstandard2.0</TargetFrameworks>
</PropertyGroup>

<!-- Framework-specific configurations -->
<PropertyGroup Condition="'$(TargetFramework)' == 'netstandard2.0'">
    <LangVersion>7.3</LangVersion>
</PropertyGroup>

<ItemGroup Condition="'$(TargetFramework)' == 'net6.0'">
    <PackageReference Include="System.Text.Json" Version="6.0.0" />
</ItemGroup>
```

## Dependency Management and Package Restore

### NuGet Package Management

```bash
# Package restore operations
dotnet restore                            # Restore all dependencies
dotnet restore --source https://nuget.org # Use specific package source
dotnet restore --packages /path/to/cache  # Custom package cache location
dotnet restore --force                    # Force re-evaluation of dependencies

# Lock file management
dotnet restore --use-lock-file            # Generate packages.lock.json
dotnet restore --locked-mode              # Use existing lock file strictly
dotnet restore --force-evaluate           # Re-evaluate even with lock file
```

### Project Reference Management

```bash
# Project references in build context
dotnet add reference ../SharedLibrary/SharedLibrary.csproj
dotnet remove reference ../OldLibrary/OldLibrary.csproj
dotnet list reference                     # List all project references

# Build with project references
dotnet build --no-dependencies           # Skip building referenced projects
dotnet build /p:BuildProjectReferences=false # MSBuild approach
```

### Dependency Resolution Strategies

```xml
<!-- Central package management -->
<PackageReference Include="Newtonsoft.Json" />
<!-- Version specified in Directory.Packages.props -->

<!-- Package version overrides -->
<PackageReference Include="System.Text.Json" Version="8.0.0" />
<PackageReference Include="Microsoft.Extensions.Logging" Version="8.0.0" />

<!-- Transitive dependency control -->
<PackageReference Include="SomePackage" Version="1.0.0">
    <ExcludeAssets>runtime</ExcludeAssets>
</PackageReference>
```

## Performance Optimization and Build Acceleration

### Incremental Build Optimization

```xml
<!-- Enable incremental builds -->
<PropertyGroup>
    <EnableDefaultCompileItems>true</EnableDefaultCompileItems>
    <EnableDefaultEmbeddedResourceItems>true</EnableDefaultEmbeddedResourceItems>
</PropertyGroup>

<!-- Custom incremental build triggers -->
<ItemGroup>
    <UpToDateCheckInput Include="CustomConfig.json" />
    <UpToDateCheckOutput Include="GeneratedFile.cs" />
</ItemGroup>
```

### Parallel Build Configuration

```bash
# Control build parallelism
dotnet build -m:1                        # Single-threaded build
dotnet build -m:4                        # Use 4 parallel processes
dotnet build /maxcpucount:2              # MSBuild syntax

# Node reuse for faster builds
dotnet build /nodeReuse:true             # Enable build server caching
dotnet build --disable-build-servers     # Disable for clean environment
```

### Build Server and Caching

```bash
# Build server management
dotnet build-server shutdown             # Stop all build servers
dotnet build --disable-build-servers     # Run without caching

# Custom cache control
dotnet restore --no-cache                # Skip package cache
dotnet build --no-incremental            # Force full rebuild
```

## CI/CD and Automation Patterns

### Optimized CI Pipeline Commands

```bash
# Restore with locked dependencies
dotnet restore --locked-mode --packages .packages

# Build without restore (already done)
dotnet build --no-restore --configuration Release

# Multi-configuration builds
dotnet build -c Debug --no-restore
dotnet build -c Release --no-restore
```

### Reproducible Build Configuration

```xml
<!-- Deterministic builds -->
<PropertyGroup>
    <Deterministic>true</Deterministic>
    <ContinuousIntegrationBuild>true</ContinuousIntegrationBuild>
    <PublishRepositoryUrl>true</PublishRepositoryUrl>
</PropertyGroup>

<!-- Source link integration -->
<PackageReference Include="Microsoft.SourceLink.GitHub" Version="8.0.0">
    <PrivateAssets>all</PrivateAssets>
    <IncludeAssets>runtime; build; native; contentfiles; analyzers</IncludeAssets>
</PackageReference>
```

### Build Artifact Management

```bash
# Custom output paths
dotnet build -o /build/artifacts         # Specify output directory
dotnet build --artifacts-path /artifacts # .NET 8+ centralized artifacts

# Version and metadata
dotnet build -p:VersionSuffix=beta       # Add version suffix
dotnet build -p:AssemblyVersion=1.0.0    # Override assembly version
```

## Common Scenarios and Use Cases

### Local Development Workflow

```bash
# Typical development cycle
dotnet restore                            # One-time dependency setup
dotnet build                             # Compile and check for errors
# Make code changes
dotnet build                             # Incremental compilation
dotnet run                              # Test changes
```

### Library Development and Packaging

```bash
# Multi-target library build
dotnet build -c Release                  # Build all target frameworks
dotnet pack -c Release                   # Create NuGet package
dotnet pack --include-symbols            # Include debugging symbols
```

### Enterprise and Team Development

```bash
# Centralized build configuration
dotnet build -p:TreatWarningsAsErrors=true
dotnet build -p:WarningLevel=5          # Maximum warning detection
dotnet build --verbosity normal         # Controlled output for logs
```

## Troubleshooting and Diagnostics

### Common Build Issues

```bash
# Clean builds for troubleshooting
dotnet clean && dotnet restore && dotnet build

# Diagnostic output for issues
dotnet build -v diagnostic              # Maximum verbosity
dotnet build --disable-build-servers    # Eliminate caching issues

# Force dependency re-evaluation
dotnet restore --force                  # Re-download packages
dotnet build --no-incremental          # Force full compilation
```

### Build Performance Analysis

```bash
# MSBuild performance profiling
dotnet build -p:msbuilddisablenodereuse=true  # Disable node reuse
dotnet build -flp:logfile=build.log;verbosity=diagnostic  # Log to file

# Memory and timing analysis
dotnet build -bl:build.binlog           # Binary log for analysis
# Analyze with MSBuild Structured Log Viewer
```

### Version and Compatibility Issues

```bash
# Framework targeting issues
dotnet build -f net8.0 -v normal        # Specific framework with output
dotnet --list-sdks                      # Verify available SDKs
dotnet --list-runtimes                  # Verify available runtimes

# Package compatibility validation
dotnet restore --force-evaluate         # Re-check package compatibility
```

## Integration with Development Tools

### IDE Integration Patterns

```xml
<!-- Visual Studio integration -->
<PropertyGroup>
    <GenerateDocumentationFile>true</GenerateDocumentationFile>
    <DocumentationFile>bin\$(Configuration)\$(TargetFramework)\$(AssemblyName).xml</DocumentationFile>
</PropertyGroup>

<!-- Code analysis integration -->
<PropertyGroup>
    <EnableNETAnalyzers>true</EnableNETAnalyzers>
    <AnalysisLevel>latest</AnalysisLevel>
    <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
</PropertyGroup>
```

### Testing Integration

```bash
# Build for testing
dotnet build --no-restore               # Build before testing
dotnet test --no-build                  # Test without rebuilding
dotnet test --no-restore --no-build     # Combined optimization
```

### Code Quality and Analysis

```bash
# Build with analysis
dotnet build -p:RunAnalyzersDuringBuild=true
dotnet build -p:TreatWarningsAsErrors=true
dotnet format --verify-no-changes       # Format verification
```

## See Also

- **Publishing and deployment**: Self-contained builds, trimming, Native AOT compilation
- **Package management**: NuGet workflows, dependency resolution, version management
- **Testing workflows**: Test execution, coverage analysis, CI integration
- **Performance optimization**: Build acceleration, caching strategies, parallel execution
