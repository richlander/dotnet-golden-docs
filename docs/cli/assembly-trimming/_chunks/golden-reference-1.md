# Explicit trimming flag
## Essential Syntax & Examples

### Basic Trimming Setup

```xml
<!-- Enable trimming -->
<PropertyGroup>
    <PublishTrimmed>true</PublishTrimmed>
</PropertyGroup>
```

```bash
# Publish with trimming (requires self-contained)
dotnet publish -r win-x64 -c Release

# Explicit trimming flag
dotnet publish -r linux-x64 -c Release -p:PublishTrimmed=true
```

### Library Compatibility Preparation

```xml
<!-- Mark library as trim-compatible -->
<PropertyGroup>
    <IsTrimmable>true</IsTrimmable>
</PropertyGroup>

<!-- Enable trim analysis without marking as compatible -->
<PropertyGroup>
    <EnableTrimAnalyzer>true</EnableTrimAnalyzer>
</PropertyGroup>
```

### Advanced Configuration Options

```xml
<PropertyGroup>
    <!-- Show detailed warnings instead of per-assembly summary -->
    <TrimmerSingleWarn>false</TrimmerSingleWarn>

    <!-- Don't treat trim warnings as errors -->
    <ILLinkTreatWarningsAsErrors>false</ILLinkTreatWarningsAsErrors>

    <!-- Remove symbols from trimmed output -->
    <TrimmerRemoveSymbols>true</TrimmerRemoveSymbols>

    <!-- Disable specific framework features -->
    <DebuggerSupport>false</DebuggerSupport>
    <EventSourceSupport>false</EventSourceSupport>
    <InvariantGlobalization>true</InvariantGlobalization>
</PropertyGroup>
```

### Creating Trimming Test Projects

```xml
<!-- Test project for library trimming validation -->
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <PublishTrimmed>true</PublishTrimmed>
  </PropertyGroup>

  <ItemGroup>
    <ProjectReference Include="../MyLibrary/MyLibrary.csproj" />
    <TrimmerRootAssembly Include="MyLibrary" />
  </ItemGroup>
</Project>
```

## Relationships & Integration

### Synergistic Technologies

Trimming works exceptionally well with:

- Native AOT: Automatically enabled, provides maximum size reduction
- Single-file deployment: Combines for minimal deployment footprint
- Source generators: Replace reflection-based code with analyzable alternatives
- ReadyToRun: Improves startup performance of trimmed applications

### Framework Integration

```xml
<!-- Trimming with framework feature control -->
<PropertyGroup>
    <PublishTrimmed>true</PublishTrimmed>

    <!-- Remove specific framework features -->
    <EventSourceSupport>false</EventSourceSupport>
    <HttpActivityPropagationSupport>false</HttpActivityPropagationSupport>
    <MetricsSupport>false</MetricsSupport>
    <UseSystemResourceKeys>true</UseSystemResourceKeys>
</PropertyGroup>
```
