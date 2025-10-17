# Multi-framework builds
## Dependency Management and Package Restore
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