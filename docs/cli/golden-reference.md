# .NET CLI - Golden Reference

## Overview

The .NET CLI (Command-Line Interface) is the primary cross-platform toolchain for developing, building, testing, and deploying .NET applications. It provides a unified command-line experience across Windows, macOS, and Linux for all stages of the application development lifecycle.

The CLI operates through the `dotnet` command as a generic driver that provides two main functions:

1. **SDK commands**: Tools for project development, building, testing, and deployment
2. **Runtime host**: Execution of .NET applications and libraries

Key architectural principles:

- **Cross-platform**: Consistent experience across all supported operating systems
- **SDK-based**: Commands require SDK installation, runtime hosting requires only runtime
- **Extensible**: Support for global and local tools, workloads, and project templates
- **Version-aware**: Multiple SDK and runtime versions can coexist

The CLI serves multiple audiences:

- **Developers**: Primary development workflow through command-line
- **DevOps engineers**: CI/CD pipeline automation and deployment
- **System administrators**: Runtime and SDK management
- **Tool authors**: Platform for building additional development tools

## Essential Command Categories

### Project Management Commands

```bash
# Project creation and templates
dotnet new console                    # Create new console application
dotnet new webapi                     # Create new Web API project
dotnet new sln                        # Create solution file
dotnet sln add MyProject.csproj       # Add project to solution

# List available templates
dotnet new list

# Install custom templates
dotnet new install Microsoft.AspNetCore.SpaTemplates

# Project building and compilation
dotnet build                          # Build project in current directory
dotnet build -c Release              # Build in Release configuration
dotnet clean                          # Clean build outputs

# Running applications
dotnet run                            # Run application in current directory
dotnet run --project MyApp            # Run specific project
dotnet run -- arg1 arg2              # Pass arguments to application
dotnet MyApp.dll                     # Run specific application
dotnet exec MyApp.dll                # Execute with explicit path

# Watch for changes and auto-rebuild/rerun
dotnet watch run
dotnet watch test
```

### Package and Dependency Management

```bash
# NuGet package management
dotnet add package Newtonsoft.Json   # Add package reference
dotnet add package Microsoft.EntityFrameworkCore --version 7.0.0
dotnet remove package PackageName    # Remove package reference
dotnet list package                  # List package references
dotnet list package --outdated       # Check for outdated packages
dotnet restore                       # Restore project dependencies

# Project references
dotnet add reference ../MyLib.csproj # Add project reference
dotnet list reference               # List project references

# Package creation and publishing
dotnet pack                          # Pack libraries into NuGet packages
dotnet pack --configuration Release --output ./artifacts
dotnet nuget push MyPackage.1.0.0.nupkg --api-key YOUR_API_KEY --source https://api.nuget.org/v3/index.json
```

### Testing and Quality Assurance

```bash
# Testing commands
dotnet test                          # Run all tests in solution
dotnet test --logger trx            # Run tests with specific logger
dotnet test --collect:"XPlat Code Coverage"  # Run with coverage
dotnet test MyApp.Tests              # Run specific test projects
dotnet test --filter "Category=Integration"  # Filter tests

# Code formatting and analysis
dotnet format                        # Format code according to style rules
dotnet format --verify-no-changes   # Verify formatting in CI scenarios
dotnet build --verbosity normal     # Shows analyzer warnings
```

### Publishing and Deployment

```bash
# Basic publishing
dotnet publish                       # Publish framework-dependent
dotnet publish -r win-x64           # Publish self-contained for Windows
dotnet publish -c Release           # Publish in Release configuration

# Advanced publishing modes
dotnet publish -p:PublishSingleFile=true    # Single-file deployment
dotnet publish -p:PublishTrimmed=true       # Trimmed deployment
dotnet publish -p:PublishAot=true           # Native AOT compilation
dotnet publish -p:PublishReadyToRun=true    # ReadyToRun optimization

# Cross-platform publishing
dotnet publish -r linux-x64         # Linux 64-bit
dotnet publish -r osx-arm64          # macOS Apple Silicon
dotnet publish -r win-arm64          # Windows ARM64
```

### Tool and Workload Management

```bash
# Global tool management
dotnet tool install -g dotnet-ef    # Install global tool
dotnet tool list -g                 # List installed global tools
dotnet tool update -g ToolName      # Update specific tool

# Local tool management
dotnet new tool-manifest            # Create tool manifest
dotnet tool install dotnet-ef       # Install project-local tool
dotnet tool run dotnet-ef           # Run local tool
dotnet ef migrations add InitialCreate  # Tool commands available directly

# Workload management
dotnet workload list                 # List available workloads
dotnet workload install maui        # Install specific workload
dotnet workload search              # Search available workloads
dotnet workload update              # Update all workloads
dotnet workload repair              # Repair workload installations
```

### Runtime and Environment Information

```bash
# Environment inspection
dotnet --info                       # Detailed environment information
dotnet --version                    # SDK version information
dotnet --list-sdks                  # List installed SDKs
dotnet --list-runtimes              # List installed runtimes
dotnet sdk check                    # Check SDK compatibility
```

## Modern CLI Features

### File-Based Applications

Streamlined development for single-file scenarios without project overhead.

```bash
# Run single C# files directly
dotnet run hello-world.cs
dotnet run script.cs -- arg1 arg2

# Publish file-based apps
dotnet publish hello-world.cs --configuration Release --output ./dist
```

### Solution Management

Comprehensive solution file management and organization.

```bash
# Create solutions
dotnet new sln -n MySolution

# Add projects to solutions
dotnet sln add MyApp/MyApp.csproj
dotnet sln add MyLib/MyLib.csproj
dotnet sln add **/*.csproj          # Add all projects

# List solution projects
dotnet sln list

# Solution-level operations
dotnet build MySolution.sln         # Build entire solution
dotnet test MySolution.sln          # Test entire solution
```

## Architecture and Design Patterns

### Command Structure and Organization

The CLI follows a hierarchical command structure:

- **Root command**: `dotnet` provides global options and runtime hosting
- **Verb commands**: Primary actions like `build`, `test`, `publish`
- **Noun commands**: Object-focused like `sln`, `package`, `reference`
- **Composite commands**: Multi-level like `dotnet tool install`, `dotnet workload list`

### Configuration and Customization

```bash
# Global configuration
dotnet nuget config set globalPackagesFolder /path/to/packages
dotnet nuget config set repositoryPath /shared/packages

# Environment-specific behavior
export DOTNET_CLI_TELEMETRY_OPTOUT=1  # Disable telemetry
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1  # Skip welcome experience
```

### Integration Patterns

```bash
# CI/CD integration patterns
dotnet restore --locked-mode         # Ensure reproducible builds
dotnet build --no-restore           # Skip restore in pipeline
dotnet test --no-build              # Skip build in testing phase
dotnet publish --no-build           # Skip build in deployment phase

# Multi-target framework handling
dotnet build -f net8.0              # Build specific framework
dotnet test -f net8.0               # Test specific framework
```

## Integration & Environment

### IDE and Editor Integration

The CLI integrates seamlessly with development environments.

**Visual Studio Integration**: The CLI commands power Visual Studio's build system, with all operations ultimately translating to CLI calls.

**VS Code Integration**: The C# extension uses the CLI for IntelliSense, debugging, and build tasks. The integrated terminal provides direct CLI access.

**Command Line Development**: Full-featured development workflow using only the CLI and text editors, particularly valuable for remote development and containers.

### Development Workflow Patterns

Established patterns for efficient CLI-based development.

**Watch-Driven Development**:

```bash
# Auto-rebuild and restart on file changes
dotnet watch run

# Auto-test on changes
dotnet watch test --project MyApp.Tests
```

**Configuration Management**:

```bash
# Environment-specific builds
dotnet build --configuration Development
dotnet build --configuration Release
dotnet build --configuration Docker

# Multiple target frameworks
dotnet build --framework net8.0
dotnet build --framework net481
```

### CI/CD Pipeline Integration

The CLI is designed for automation and continuous integration scenarios.

**Optimized CI Pipeline Commands**:

```bash
# Comprehensive CI workflow
dotnet restore --locked-mode --packages /packages
dotnet build --no-restore --configuration Release
dotnet test --no-build --logger trx --results-directory /results
dotnet publish --no-build --configuration Release --output /publish

# Build performance optimization
dotnet build --no-dependencies      # Skip dependency building
dotnet build --no-incremental       # Force full rebuild
dotnet build -m:1                   # Control parallel builds

# Diagnostic and troubleshooting
dotnet build --verbosity diagnostic # Detailed build output
dotnet --diagnostics                # Enable diagnostic output
```

**Docker Integration**:

```dockerfile
# Multi-stage builds using CLI
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "MyApp.dll"]
```

**Container and Cloud Deployment**:

```bash
# Container-optimized publishing
dotnet publish -r linux-x64 -p:PublishSingleFile=true -p:PublishTrimmed=true
dotnet publish -t:PublishContainer   # Direct container creation

# Cloud-ready configurations
dotnet publish -c Release -p:InvariantGlobalization=true
```

### Cross-Platform Considerations

The CLI provides consistent behavior across platforms while supporting platform-specific features.

**Platform Targeting**: Support for targeting specific runtimes and frameworks while maintaining code portability.

**File System Handling**: Consistent path handling and file operations across Windows, Linux, and macOS.

**Permission Models**: Appropriate handling of different operating system permission models and executable formats.

## Performance and Efficiency

### Build Performance

The CLI includes several features to optimize build performance:

- **Incremental Builds**: Only rebuilds changed projects and their dependencies
- **Parallel Builds**: Automatically parallelizes builds of independent projects in solutions
- **Build Caching**: Leverages file timestamps and dependency graphs to avoid unnecessary work

### Package Restore Optimization

Efficient dependency resolution and caching mechanisms:

- **NuGet Cache**: Central package cache shared across projects to avoid redundant downloads
- **Lock Files**: Optional package lock files for reproducible builds and faster restores
- **Source Mapping**: Multiple package source support with fallback and authentication

### Developer Productivity Tools

```bash
# Development server and hot reload
dotnet watch run                     # Auto-restart on file changes
dotnet dev-certs https --trust       # Setup HTTPS development certificates

# Code generation and scaffolding
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet ef migrations add InitialCreate
dotnet ef database update
```

## Common Scenarios and Use Cases

### Team Development Patterns

CLI usage patterns that support team collaboration:

- **Solution Organization**: Using solution files to group related projects and enable efficient bulk operations
- **Tool Manifests**: Committing tool manifests to ensure consistent tooling across team members
- **Global.json**: Pinning SDK versions for consistent builds across development machines

### Project Template Customization

```bash
# Custom template creation and usage
dotnet new install ./MyTemplate     # Install custom template
dotnet new mytemplate -n NewProject # Use custom template
dotnet new uninstall MyTemplate     # Remove custom template
```

### Enterprise and Team Development

```bash
# Centralized package management
dotnet nuget config set repositoryPath /shared/packages

# Version management and consistency
dotnet sdk check                    # Check SDK compatibility
dotnet workload repair              # Repair workload installations
```

## Gotchas and Limitations

### Version and Compatibility Management

- **Multiple SDK versions**: Global.json controls which SDK version is used
- **Runtime compatibility**: Forward compatibility generally works, but breaking changes exist
- **Platform differences**: Some commands behave differently across operating systems
- **Path limitations**: Long paths can cause issues on Windows without proper configuration

### Performance Considerations

- **First-time experience**: Initial package restore and template downloads can be slow
- **Parallel builds**: Default parallelism may overwhelm system resources
- **Incremental builds**: Not always reliable with complex project graphs
- **Package caching**: Global package cache can grow large over time
- **Cold Start**: First restore operations can be slow due to package downloads and cache population
- **Large Solutions**: Very large solutions with many projects may have slower build and restore times
- **Network Dependencies**: Package restore and tool operations require network access and can be affected by connectivity issues

### Common Error Scenarios

```bash
# Network and authentication issues
dotnet nuget list source            # Verify configured sources
dotnet nuget config set credentialProviders /path/to/provider

# Build and runtime issues
dotnet clean && dotnet restore      # Clear build cache
dotnet --info | grep "RID"          # Verify runtime identifier
```

### Platform-Specific Limitations

- **Path Length**: Windows path length limitations can affect deep project hierarchies
- **File Permissions**: Unix-like systems require explicit executable permissions for published outputs
- **Case Sensitivity**: File system case sensitivity differences between platforms can cause issues

### Security and Trust Considerations

- **Package source verification**: Always verify package sources in enterprise environments
- **Code signing**: Consider package signature verification for security-critical applications
- **Telemetry and privacy**: CLI collects telemetry by default, can be disabled
- **Tool installation**: Global tools run with user permissions, verify before installing

## See Also

### Core Development Concepts

- **Project management**: MSBuild integration, project file format, SDK-style projects
- **Publishing and deployment**: Self-contained deployment, trimming, Native AOT
- **Development tools**: Global tools, workloads, project templates
- **Testing infrastructure**: Test frameworks, coverage tools, reporting

### Related Tools and Extensions

- **Entity Framework CLI**: Database migration and scaffolding tools
- **ASP.NET Core CLI**: Web application development and deployment tools
- **MAUI CLI**: Multi-platform application development tools
- **Global Tools**: Community-developed CLI extensions

### Development Environments

- **Visual Studio**: Full IDE with integrated CLI functionality
- **Visual Studio Code**: Lightweight editor with CLI integration
- **JetBrains Rider**: Cross-platform IDE with CLI support
- **Command Line**: Pure CLI development workflow and tooling
