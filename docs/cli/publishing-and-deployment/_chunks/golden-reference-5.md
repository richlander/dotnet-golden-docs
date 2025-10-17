# Test different publishing modes locally
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
