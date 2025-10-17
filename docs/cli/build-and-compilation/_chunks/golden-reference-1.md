# Diagnostic and troubleshooting
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
