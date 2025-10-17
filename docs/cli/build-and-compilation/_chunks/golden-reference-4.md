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
