# Analyze with MSBuild Structured Log Viewer
## Local Development Workflow

```bash
# Typical development cycle
dotnet restore                            # One-time dependency setup
dotnet build                             # Compile and check for errors
# Make code changes
dotnet build                             # Incremental compilation
dotnet run                              # Test changes
```

## Library Development and Packaging

```bash
# Multi-target library build
dotnet build -c Release                  # Build all target frameworks
dotnet pack -c Release                   # Create NuGet package
dotnet pack --include-symbols            # Include debugging symbols
```

## Enterprise and Team Development

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
