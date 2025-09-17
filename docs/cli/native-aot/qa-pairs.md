# Native AOT - Q&A Pairs

## Basic Concepts Questions

**Q: What is Native AOT and how does it differ from regular .NET compilation?**
A: Native AOT (Ahead-of-Time) compilation compiles .NET applications directly to native machine code at build time, rather than using just-in-time (JIT) compilation at runtime. This eliminates the need for the .NET runtime on the target machine and provides faster startup times and lower memory usage.

**Q: What are the main benefits of using Native AOT?**
A: Key benefits include: 1) 2-5x faster application startup, 2) 20-50% reduced memory footprint, 3) Self-contained deployment without runtime dependency, 4) Often smaller deployment size than self-contained apps, 5) Compatibility with restricted environments where JIT is prohibited.

**Q: When should I consider using Native AOT?**
A: Use Native AOT for scenarios requiring fast startup (cloud/serverless functions), reduced memory usage (IoT/edge devices), self-contained deployment (desktop apps), or restricted environments. It's particularly valuable for microservices, console tools, and performance-critical applications.

**Q: What are the main limitations of Native AOT?**
A: Key limitations include: No dynamic assembly loading, no runtime code generation (Reflection.Emit), limited reflection support, no C++/CLI, expression trees are always interpreted, and increased build time with larger binary size for complex applications.

**Q: Which .NET versions support Native AOT?**
A: Native AOT is available starting with .NET 7, with improved support in .NET 8 (including ASP.NET Core) and .NET 9 (expanded platform support). .NET 10 adds enhanced file-based app support with Native AOT enabled by default.

## Setup and Configuration Questions

**Q: How do I enable Native AOT for my project?**
A: Add `<PublishAot>true</PublishAot>` to your project file's PropertyGroup, then publish with a runtime identifier:
```xml
<PropertyGroup>
    <PublishAot>true</PublishAot>
</PropertyGroup>
```
```bash
dotnet publish -r win-x64 -c Release
```

**Q: What platform prerequisites are needed for Native AOT?**
A: Windows requires Visual Studio 2022 with "Desktop development with C++" workload. Linux needs clang and zlib development packages. macOS requires XCode Command Line Tools. Each platform needs the appropriate native toolchain for compilation.

**Q: How do I set up Native AOT on Linux?**
A: Install the required packages:
```bash
# Ubuntu
sudo apt-get install clang zlib1g-dev

# Alpine
sudo apk add clang build-base zlib-dev

# Fedora/RHEL
sudo dnf install clang zlib-devel
```

**Q: Can I use Native AOT with file-based apps in .NET 10?**
A: Yes, .NET 10 file-based apps target Native AOT by default. Simply publish with `dotnet publish app.cs -r <RID> -c Release`. To disable Native AOT, add `#:property PublishAot=false` to your .cs file.

**Q: How do I configure a library to be AOT-compatible?**
A: Set `<IsAotCompatible>true</IsAotCompatible>` in your library project. This automatically enables IsTrimmable, EnableTrimAnalyzer, EnableSingleFileAnalyzer, and EnableAotAnalyzer properties for compatibility validation.

## Performance and Optimization Questions

**Q: How much faster is Native AOT startup compared to JIT?**
A: Native AOT typically provides 2-5x faster startup times compared to JIT compilation, with the exact improvement depending on application complexity and size. Cold start scenarios show the most dramatic improvements.

**Q: Does Native AOT reduce memory usage?**
A: Yes, Native AOT applications typically use 20-50% less memory at runtime compared to JIT-compiled applications, as there's no need for JIT compilation overhead and metadata.

**Q: How do I optimize Native AOT binary size?**
A: Use trimming (automatically enabled), choose size optimization (`<IlcOptimizationPreference>Size</IlcOptimizationPreference>`), and ensure unused code is removed through proper source generation and minimal API usage.

**Q: Should I combine Native AOT with single-file deployment?**
A: Yes, combining Native AOT with single-file deployment creates the most portable and optimized executable. Add `-p:PublishSingleFile=true` to your publish command for a single native executable.

**Q: How does Native AOT affect generic types and methods?**
A: Native AOT pre-generates code for all generic instantiations at compile time, which can significantly increase binary size for applications with many generic combinations. Consider minimizing generic type complexity.

## ASP.NET Core and Web Applications Questions

**Q: Can I use Native AOT with ASP.NET Core applications?**
A: Yes, starting with .NET 8, ASP.NET Core supports Native AOT. Use `WebApplication.CreateSlimBuilder()` and ensure all JSON serialization uses source generators instead of reflection.

**Q: How do I configure JSON serialization for Native AOT in ASP.NET Core?**
A: Use source-generated JSON contexts:
```csharp
[JsonSerializable(typeof(MyModel))]
internal partial class AppJsonContext : JsonSerializerContext { }

builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolverChain.Insert(0, AppJsonContext.Default);
});
```

**Q: What ASP.NET Core features are not supported with Native AOT?**
A: Unsupported features include: MVC controllers with model binding, SignalR, some authentication schemes, and features requiring runtime code generation. Minimal APIs with source generators are the recommended approach.

**Q: How do I handle dependency injection with Native AOT?**
A: Use compile-time dependency injection or source generators. Avoid runtime type discovery. Register services explicitly and use concrete types where possible instead of dynamic type resolution.

## Cross-Platform and Deployment Questions

**Q: Does Native AOT support cross-platform compilation?**
A: Native AOT does not support cross-OS compilation (e.g., building for Linux on Windows). However, it supports cross-architecture compilation within the same OS (x64 to ARM64) with proper toolchain setup.

**Q: How do I cross-compile for ARM64 on Windows?**
A: Install the "VS 2022 C++ ARM64/ARM64EC build tools" component in Visual Studio, then publish with:
```bash
dotnet publish -r win-arm64 -c Release
```

**Q: Can I use Native AOT in Docker containers?**
A: Yes, Native AOT is excellent for containers. Use runtime-deps base images instead of full runtime images:
```dockerfile
FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-alpine
COPY publish/ /app
WORKDIR /app
ENTRYPOINT ["./MyApp"]
```

**Q: How do I handle different Linux distributions with Native AOT?**
A: Native AOT binaries are tied to specific Linux distributions and glibc/musl versions. Build on the oldest supported distribution or use Alpine Linux with musl for broader compatibility.

## Troubleshooting and Compatibility Questions

**Q: Why am I getting trim warnings during Native AOT compilation?**
A: Trim warnings indicate potential runtime issues with reflection or dynamic code. Use source generators instead of reflection, mark preserved types with `[DynamicallyAccessedMembers]`, or use `TrimmerRootAssembly` for entire assemblies.

**Q: How do I fix "DynamicDependency" warnings in Native AOT?**
A: Replace dynamic dependencies with static references. Use source generators for serialization, avoid Assembly.LoadFrom, and ensure all required types are statically referenced in your code.

**Q: What should I do if a NuGet package isn't Native AOT compatible?**
A: Check if the package has IsAotCompatible metadata. If not, look for alternatives, use source generators to replace reflection-based features, or create wrapper code that avoids incompatible patterns.

**Q: How do I debug Native AOT applications?**
A: Debug information is produced in separate files (.pdb on Windows, .dbg on Linux, .dSYM on macOS). For embedded debug info on Unix, set `<StripSymbols>false</StripSymbols>`. Use platform-native debugging tools.

**Q: Why is my Native AOT build failing with linking errors?**
A: Linking errors often indicate missing native dependencies or incompatible library versions. Ensure all platform prerequisites are installed and verify that referenced libraries support your target platform.

## Migration and Best Practices Questions

**Q: How do I migrate an existing application to Native AOT?**
A: Start by enabling AOT analyzers (`<EnableAotAnalyzer>true</EnableAotAnalyzer>`), fix warnings, replace reflection with source generators, remove dynamic code generation, and test thoroughly on target platforms.

**Q: What's the best way to handle reflection in Native AOT applications?**
A: Avoid reflection when possible. Use source generators for serialization, compile-time dependency injection, and static code analysis. When reflection is necessary, use `[DynamicallyAccessedMembers]` attributes.

**Q: How do I ensure my libraries are Native AOT compatible?**
A: Set `<IsAotCompatible>true</IsAotCompatible>`, avoid reflection and dynamic code generation, use source generators, test with trim analyzers enabled, and document any Native AOT requirements.

**Q: Should I use Native AOT for all my applications?**
A: No, Native AOT is best for applications requiring fast startup, low memory usage, or self-contained deployment. Applications with heavy reflection use, dynamic code generation, or complex framework dependencies may not be suitable.

**Q: How do I measure Native AOT performance improvements?**
A: Benchmark startup time, memory usage at steady state, binary size, and cold start performance. Use tools like BenchmarkDotNet for accurate measurements and compare against JIT compilation baselines.

## Advanced Scenarios Questions

**Q: Can I use Native AOT with Entity Framework Core?**
A: EF Core has limited Native AOT support. Use compiled models and avoid reflection-based features. Consider alternatives like Dapper or micro-ORMs that don't rely on runtime code generation.

**Q: How do I handle configuration and options patterns with Native AOT?**
A: Use source generators for configuration binding or manual binding code. Avoid IConfiguration.Bind() with complex objects. Consider compile-time configuration validation.

**Q: What's the difference between Native AOT and ReadyToRun?**
A: ReadyToRun is partial AOT compilation that includes both native code and IL, providing faster startup but still requiring the runtime. Native AOT compiles everything to native code with no runtime dependency.

**Q: Can I use Native AOT with gRPC services?**
A: Yes, but use source-generated gRPC clients and services. Avoid reflection-based features and ensure all protobuf types are statically referenced. Consider using grpc-dotnet with source generation.

**Q: How do I handle localization and resources in Native AOT?**
A: Embed resources at compile time using source generators. Avoid ResourceManager's reflection-based loading. Consider compile-time resource generation for better Native AOT compatibility.