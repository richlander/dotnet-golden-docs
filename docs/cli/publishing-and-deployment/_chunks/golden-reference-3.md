# Version and metadata control
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
