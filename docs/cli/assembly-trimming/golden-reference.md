# Assembly Trimming - Golden Reference

## Overview

Assembly trimming is a build-time optimization that reduces the size of self-contained .NET applications by removing unused code from the application and its dependencies. The trimmer uses static analysis to identify code that is never reached during execution and eliminates it from the final deployment.

Key benefits include:

- Significant size reduction: 20-70% smaller deployments depending on application complexity
- Faster deployment: Reduced download and transfer times
- Lower storage costs: Particularly important for cloud and container scenarios
- Improved cold start: Less code to load and JIT compile (when combined with ReadyToRun)

The technology works by:

1. Static analysis: Analyzing code paths from application entry points
2. Dependency tracking: Following method calls, field accesses, and type references
3. Dead code elimination: Removing unreachable code and unused assemblies
4. Metadata reduction: Stripping unused reflection metadata

Trimming is particularly valuable for:

- Cloud applications: Reduced container image sizes and deployment times
- Desktop applications: Smaller installers and faster startup
- IoT applications: Reduced storage requirements on constrained devices
- Serverless functions: Faster cold starts and reduced memory footprint

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

### Library Authoring Best Practices

```csharp
// Annotate reflection-dependent code
[RequiresUnreferencedCode("This method uses reflection")]
public void ProcessType(Type type)
{
    // Reflection code that may not work with trimming
}

// Specify required members for reflection
public void ProcessTypeMembers([DynamicallyAccessedMembers(DynamicallyAccessedMemberTypes.PublicMethods)] Type type)
{
    var methods = type.GetMethods(); // Safe with annotation
}

// Suppress warnings when requirements are guaranteed
[UnconditionalSuppressMessage("Trimming", "IL2070", Justification = "Type is guaranteed to have constructor")]
public object CreateInstance(Type type)
{
    return Activator.CreateInstance(type);
}
```

## Common Scenarios

### Cloud-Native Applications

```xml
<!-- Optimized for container deployment -->
<PropertyGroup>
    <PublishTrimmed>true</PublishTrimmed>
    <InvariantGlobalization>true</InvariantGlobalization>
    <EventSourceSupport>false</EventSourceSupport>
    <HttpActivityPropagationSupport>false</HttpActivityPropagationSupport>
</PropertyGroup>
```

### Desktop Applications

```xml
<!-- Balanced approach for desktop apps -->
<PropertyGroup>
    <PublishTrimmed>true</PublishTrimmed>
    <TrimmerSingleWarn>false</TrimmerSingleWarn>
    <!-- Keep debugger support for better crash reporting -->
    <DebuggerSupport>true</DebuggerSupport>
</PropertyGroup>
```

### Library Development

```csharp
// Example trim-compatible library code
public class JsonProcessor
{
    // Use source generation instead of reflection
    public string Serialize<T>(T obj, JsonSerializerContext context)
        where T : class
    {
        return JsonSerializer.Serialize(obj, context.GetTypeInfo(typeof(T)));
    }

    // Annotate unavoidable reflection
    [RequiresUnreferencedCode("Dynamic type processing requires unreferenced code")]
    public object ProcessDynamicType(Type type, string data)
    {
        return JsonSerializer.Deserialize(data, type);
    }
}
```

## Gotchas & Limitations

### Critical Incompatibilities

- WPF applications: Trimming currently disabled due to extensive reflection usage
- Windows Forms: Disabled due to COM marshalling dependencies
- C++/CLI: Mixed-mode assemblies not supported
- Dynamic assembly loading: Assembly.LoadFrom/LoadFile patterns incompatible
- Unbounded reflection: Serializers using complex reflection patterns

### Common Warning Scenarios

```csharp
// This will generate trim warnings
public void ProblematicCode()
{
    // IL2070: 'this' argument does not satisfy 'DynamicallyAccessedMemberTypes.PublicMethods'
    var type = typeof(MyClass);
    var methods = type.GetMethods(); // Warning: may not work after trimming
}

// Fixed version
public void FixedCode([DynamicallyAccessedMembers(DynamicallyAccessedMemberTypes.PublicMethods)] Type type)
{
    var methods = type.GetMethods(); // Safe with annotation
}
```

### Performance Considerations

- Build time: Trimming analysis adds significant compile time
- First deployment: Initial trimmed builds are slower
- Warning investigation: Time investment required to resolve compatibility issues
- Testing overhead: Need to test trimmed applications thoroughly

### Framework Feature Limitations

When trimming is enabled, several features are automatically disabled:

- Built-in COM interop support
- Custom resource type support
- C++/CLI host activation
- Startup hook support
- Some binary formatter scenarios

## Troubleshooting Common Issues

### Resolving Reflection Warnings

```csharp
// Problem: Dynamic type creation
public T CreateInstance<T>() where T : new()
{
    return (T)Activator.CreateInstance(typeof(T)); // May generate warnings
}

// Solution: Use constraints and annotations
[RequiresUnreferencedCode("Generic type creation requires unreferenced code")]
public T CreateInstance<T>() where T : class, new()
{
    return new T(); // Preferred approach when possible
}
```

### Library Migration Strategies

1. Enable analysis: Add `<EnableTrimAnalyzer>true</EnableTrimAnalyzer>`
2. Fix warnings progressively: Start with high-impact APIs
3. Use source generators: Replace reflection with compile-time alternatives
4. Document requirements: Clearly state trim compatibility status
5. Test thoroughly: Create trim-enabled test applications

## See Also

- Performance optimization: Native AOT compilation, ReadyToRun, single-file deployment
- Library development: Source generators, trim annotations, compatibility testing
- Deployment strategies: Self-contained deployment, container optimization
- Framework integration: ASP.NET Core trimming, minimal APIs, feature switches
