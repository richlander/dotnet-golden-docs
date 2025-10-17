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
