# Native AOT

## Overview

Native AOT (Ahead-of-Time) compilation transforms .NET applications into native executables that run without requiring the .NET runtime on the target machine. This publishing model compiles IL code to native machine code at build time, rather than relying on just-in-time (JIT) compilation at runtime.

Key benefits include:

- Faster startup: 2-5x faster application startup compared to JIT compilation
- Reduced memory footprint: 20-50% lower memory usage at runtime
- Self-contained deployment: No .NET runtime installation required
- Smaller deployment size: Often smaller than self-contained deployments with full runtime
- Restricted environment compatibility: Runs in environments where JIT compilation is prohibited

The technology is particularly valuable for:

- Cloud and serverless: Fast cold start times for containers and functions
- Desktop applications: Improved user experience with instant startup
- IoT and edge computing: Reduced resource requirements for constrained devices
- Gaming and real-time systems: Predictable performance without JIT overhead

## Essential Syntax & Examples

### Basic Native AOT Publishing

```bash
# Add PublishAot to project file
<PropertyGroup>
    <PublishAot>true</PublishAot>
</PropertyGroup>

# Publish for current platform
dotnet publish -c Release

# Publish for specific platform
dotnet publish -r win-x64 -c Release
dotnet publish -r linux-x64 -c Release
dotnet publish -r osx-arm64 -c Release
```

### Platform Prerequisites Setup

```bash
# Windows - Install Visual Studio 2022 with C++ workload
# Or install C++ Build Tools

# Linux (Ubuntu)
sudo apt-get install clang zlib1g-dev

# Linux (Alpine)
sudo apk add clang build-base zlib-dev

# macOS - Install XCode Command Line Tools
xcode-select --install
```

### .NET 10 File-Based Apps with Native AOT

```csharp
// app.cs - Native AOT enabled by default in .NET 10
using System;

Console.WriteLine("Hello, Native AOT World!");

// Disable Native AOT if needed
#:property PublishAot=false
```

```bash
# Publish file-based app (new in .NET 10)
dotnet publish app.cs -r win-x64 -c Release
```

### AOT-Compatible Library Configuration

```xml
<PropertyGroup>
    <IsAotCompatible>true</IsAotCompatible>
    <!-- This enables: -->
    <!-- <IsTrimmable>true</IsTrimmable> -->
    <!-- <EnableTrimAnalyzer>true</EnableTrimAnalyzer> -->
    <!-- <EnableSingleFileAnalyzer>true</EnableSingleFileAnalyzer> -->
    <!-- <EnableAotAnalyzer>true</EnableAotAnalyzer> -->
</PropertyGroup>
```

### Debug Information Control

```xml
<PropertyGroup>
    <!-- Include debug info in binary (Unix) -->
    <StripSymbols>false</StripSymbols>

    <!-- Optimize for size -->
    <IlcOptimizationPreference>Size</IlcOptimizationPreference>

    <!-- Optimize for speed -->
    <IlcOptimizationPreference>Speed</IlcOptimizationPreference>
</PropertyGroup>
```

## Relationships & Integration

### Complementary Technologies

Native AOT works synergistically with:

- Trimming: Automatically enabled to remove unused code
- Source generators: Replace reflection-based code generation
- Single-file deployment: Can be combined for ultimate portability
- Container deployment: Ideal for minimalist container images

### ASP.NET Core Integration (.NET 8+)

```csharp
var builder = WebApplication.CreateSlimBuilder(args);
builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolverChain.Insert(0, AppJsonSerializerContext.Default);
});

var app = builder.Build();
app.MapGet("/", () => "Hello World!");
app.Run();

[JsonSerializable(typeof(WeatherForecast))]
internal partial class AppJsonSerializerContext : JsonSerializerContext { }
```

### Cross-Compilation Support

Limited cross-architecture compilation is supported:

- Windows: x64 ↔ ARM64 with appropriate VS components
- macOS: x64 ↔ ARM64 with XCode toolchain
- Linux: Platform-dependent toolchain setup required

### System.Text.Json Source Generation

System.Text.Json source generation is essential for Native AOT because it replaces reflection-based JSON serialization with compile-time code generation. Traditional JSON serialization uses runtime reflection, which is incompatible with AOT compilation.

```csharp
// ❌ Reflection-based - causes IL2026/IL3050 warnings in AOT
var json = JsonSerializer.Serialize(person);

// ✅ Source generation - AOT compatible
var json = JsonSerializer.Serialize(person, PersonContext.Default.Person);
```

#### Setting Up Source Generation

```csharp
// Define your data model
public class Person
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public int Age { get; set; }
}

// Create JsonSerializerContext
[JsonSerializable(typeof(Person))]
[JsonSerializable(typeof(List<Person>))]
[JsonSourceGenerationOptions(
    PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase,
    WriteIndented = true)]
public partial class PersonContext : JsonSerializerContext { }

// Use source-generated serialization
var person = new Person { FirstName = "John", LastName = "Doe", Age = 30 };
string json = JsonSerializer.Serialize(person, PersonContext.Default.Person);
Person result = JsonSerializer.Deserialize(json, PersonContext.Default.Person)!;
```

#### Enabling Source Generation for Generic Methods with JsonTypeInfo

For generic methods that work with any type in AOT scenarios, use `JsonTypeInfo<T>`:

```csharp
// AOT-compatible generic deserialization
public static T DeserializeFromApi<T>(string json, JsonTypeInfo<T> typeInfo) where T : class
{
    return JsonSerializer.Deserialize(json, typeInfo)!;
}

// Usage with different types
var person = DeserializeFromApi(personJson, PersonContext.Default.Person);
var product = DeserializeFromApi(productJson, ProductContext.Default.Product);
```

When using System.Text.Json with Native AOT, it is important that source generation is configured for every type that will be serialized. This need is most critical a method (not a class) that defines its own `T`. That means that a matching `JsonTypeInfo<T>` needs to provided so that serialization will be successful. The most convenient way to do that if in the same `T` method, as you can see in the prior example. This approach will ensure that the correct types are included with the JSON source generation process. If a matching `JsonTypeInfo<T>` is not available, then there will ba runtime exception. The reflection-based runtime serializer is not available. The `class` generic constraint is a useful performance optimization. The code that Native AOT needs to compile will be much simpler and smaller if is constrained to classes.

#### Common AOT Errors

When using reflection-based JSON serialization in Native AOT projects, you'll encounter:

```
warning IL2026: Using member 'JsonSerializer.Serialize<TValue>' which has
'RequiresUnreferencedCodeAttribute' can break functionality when trimming.
Use the overload that takes a JsonTypeInfo or JsonSerializerContext.

warning IL3050: Using member 'JsonSerializer.Serialize<TValue>' which has
'RequiresDynamicCodeAttribute' can break functionality when AOT compiling.
Use System.Text.Json source generation for native AOT applications.
```

These warnings indicate runtime failures in AOT scenarios. Always use source generation overloads.

## Using Native AOT for High-Performance Console Applications

```csharp
// Program optimized for Native AOT
using System;
using System.Text.Json;

var data = new { Message = "Fast startup!", Timestamp = DateTime.UtcNow };
Console.WriteLine(JsonSerializer.Serialize(data, AppContext.Default.Object));

[JsonSerializable(typeof(object))]
internal partial class AppContext : JsonSerializerContext { }
```

## Using Native AOT with Minimal API Microservices

```csharp
var builder = WebApplication.CreateSlimBuilder(args);
var app = builder.Build();

app.MapGet("/health", () => Results.Ok(new { Status = "Healthy" }));
app.MapPost("/process", (DataModel model) =>
    Results.Ok(new { Processed = model.Value * 2 }));

app.Run();

public record DataModel(int Value);
```

## Container-Optimized Deployment with Native AOT

```dockerfile
FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-alpine
COPY publish/ /app
WORKDIR /app
ENTRYPOINT ["./MyApp"]
```

## Gotchas & Limitations

### Critical Limitations

- No dynamic loading: Assembly.LoadFile, Assembly.LoadFrom not supported
- No runtime code generation: System.Reflection.Emit prohibited
- Limited reflection: Only statically analyzable reflection patterns work
- No C++/CLI: Mixed-mode assemblies not supported
- Expression trees: Always interpreted, never compiled to delegates

### Platform-Specific Issues

- Windows: No built-in COM support
- Linux: Specific glibc/musl compatibility requirements
- Cross-OS compilation: Not supported without emulation

### Performance Considerations

- Generic instantiations: All combinations pre-generated, increasing size
- First-run performance: No profile-guided optimization
- Large applications: Compilation time significantly increased
- Memory usage: Higher peak memory during compilation

### Common Troubleshooting

```xml
<!-- Address trim warnings -->
<PropertyGroup>
    <SuppressTrimAnalysisWarnings>false</SuppressTrimAnalysisWarnings>
    <TrimmerSingleWarn>false</TrimmerSingleWarn>
</PropertyGroup>

<!-- Preserve specific types -->
<ItemGroup>
    <TrimmerRootAssembly Include="MyLibrary" />
</ItemGroup>
```

### Library Compatibility

Not all libraries are Native AOT compatible. Check for:

- IsAotCompatible metadata in NuGet packages
- Trim analysis warnings during build
- Runtime exceptions related to missing metadata

## See Also

- Performance optimization: Trimming, single-file deployment, ReadyToRun
- Deployment strategies: Self-contained deployment, container images
- Development tools: Source generators, AOT analyzers
- Platform guides: Cross-compilation, mobile platforms (iOS/Android)
