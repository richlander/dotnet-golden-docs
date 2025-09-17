# Assembly Trimming - Q&A Pairs

## Basic Concepts Questions

**Q: What is assembly trimming and how does it work?**
A: Assembly trimming is a build-time optimization that reduces application size by removing unused code from the application and its dependencies. It uses static analysis to identify unreachable code paths and eliminates them from the final deployment, often reducing size by 20-70%.

**Q: When should I use assembly trimming?**
A: Use trimming for self-contained deployments where size matters: cloud applications, container images, desktop installers, IoT devices, or serverless functions. It's particularly valuable when deployment speed and storage costs are concerns.

**Q: What are the prerequisites for using trimming?**
A: Trimming requires: 1) Self-contained deployment (cannot be framework-dependent), 2) .NET 6+ for full support (.NET Core 3.1 and .NET 5 had experimental support), 3) Static code patterns that can be analyzed at build time.

**Q: How much size reduction can I expect from trimming?**
A: Size reduction varies from 20-70% depending on application complexity and framework usage. Simple console applications see higher reduction percentages, while complex applications with many dependencies see more modest but still significant reductions.

**Q: Is trimming compatible with Native AOT?**
A: Yes, trimming is automatically enabled with Native AOT and works synergistically. Native AOT provides the maximum size reduction when combined with trimming, as both eliminate unused code at build time.

## Setup and Configuration Questions

**Q: How do I enable trimming for my application?**
A: Add `<PublishTrimmed>true</PublishTrimmed>` to your project file and publish self-contained:
```xml
<PropertyGroup>
    <PublishTrimmed>true</PublishTrimmed>
</PropertyGroup>
```
Then publish with: `dotnet publish -r win-x64 -c Release`

**Q: Can I enable trimming from the command line?**
A: Yes, you can use: `dotnet publish -r win-x64 -c Release -p:PublishTrimmed=true`. However, it's better to set it in the project file to enable trim-incompatible feature warnings during build.

**Q: How do I show detailed trimming warnings instead of summaries?**
A: Set `<TrimmerSingleWarn>false</TrimmerSingleWarn>` in your project file. By default, trim analysis shows one warning per assembly, but this setting shows individual warnings for all incompatible patterns.

**Q: How do I prevent trimming warnings from being treated as errors?**
A: Set `<ILLinkTreatWarningsAsErrors>false</ILLinkTreatWarningsAsErrors>` in your project file. This is useful when you have global "warnings as errors" enabled but want to allow trim warnings.

**Q: Can I disable specific framework features during trimming?**
A: Yes, use feature switches like:
```xml
<PropertyGroup>
    <DebuggerSupport>false</DebuggerSupport>
    <EventSourceSupport>false</EventSourceSupport>
    <InvariantGlobalization>true</InvariantGlobalization>
    <HttpActivityPropagationSupport>false</HttpActivityPropagationSupport>
</PropertyGroup>
```

## Library Development Questions

**Q: How do I make my library compatible with trimming?**
A: Set `<IsTrimmable>true</IsTrimmable>` in your library project, avoid unbounded reflection, use `[DynamicallyAccessedMembers]` annotations for reflection requirements, and annotate incompatible APIs with `[RequiresUnreferencedCode]`.

**Q: What's the difference between IsTrimmable and EnableTrimAnalyzer?**
A: `<IsTrimmable>true</IsTrimmable>` marks your library as trim-compatible and enables warnings. `<EnableTrimAnalyzer>true</EnableTrimAnalyzer>` enables warnings without marking the library as compatible. Use IsTrimmable when your library is actually trim-safe.

**Q: How do I test my library for trimming compatibility?**
A: Create a test console application that references your library, enable `<PublishTrimmed>true</PublishTrimmed>`, add `<TrimmerRootAssembly Include="YourLibraryName" />`, and run `dotnet publish`. This shows all trimming warnings for your library.

**Q: When should I use [RequiresUnreferencedCode] attribute?**
A: Use `[RequiresUnreferencedCode]` when your method uses reflection patterns that cannot be statically analyzed, such as dynamic type creation, unbounded reflection, or complex serialization scenarios that the trimmer cannot understand.

**Q: How do I use [DynamicallyAccessedMembers] attribute?**
A: Use `[DynamicallyAccessedMembers]` to specify which parts of a type need to be preserved for reflection:
```csharp
public void ProcessType([DynamicallyAccessedMembers(DynamicallyAccessedMemberTypes.PublicMethods)] Type type)
{
    var methods = type.GetMethods(); // Safe with annotation
}
```

## Compatibility and Troubleshooting Questions

**Q: Which frameworks and features are incompatible with trimming?**
A: Major incompatibilities include: WPF (disabled in SDK), Windows Forms (disabled), C++/CLI, built-in COM marshalling, dynamic assembly loading (Assembly.LoadFrom), and many reflection-based serializers like Newtonsoft.Json.

**Q: How do I fix "IL2070: 'this' argument does not satisfy DynamicallyAccessedMemberTypes" warnings?**
A: This warning occurs when you call reflection methods without proper annotations. Add `[DynamicallyAccessedMembers]` to method parameters or fields that feed into reflection APIs, or use `[RequiresUnreferencedCode]` if the pattern can't be made analyzable.

**Q: What should I do if I get trim warnings from NuGet packages?**
A: Check if newer versions are trim-compatible, look for alternative packages that support trimming, or accept the warnings if you've tested that the functionality works correctly in your trimmed application.

**Q: How do I handle serialization with trimming?**
A: Replace reflection-based serializers with source-generated alternatives:
- Use System.Text.Json with source generation instead of Newtonsoft.Json
- Use configuration binding source generators instead of manual reflection
- Avoid BinaryFormatter (which is also deprecated for security reasons)

**Q: Can I suppress specific trim warnings if I know they're safe?**
A: Yes, use `[UnconditionalSuppressMessage]` on the problematic method, but only if you're certain the code will work correctly. This is risky and should be a last resort after proper annotations fail.

## Advanced Configuration Questions

**Q: How do I control trimming granularity and behavior?**
A: Use MSBuild properties like:
```xml
<PropertyGroup>
    <TrimmerSingleWarn>false</TrimmerSingleWarn>
    <TrimmerRemoveSymbols>true</TrimmerRemoveSymbols>
    <ILLinkTreatWarningsAsErrors>false</ILLinkTreatWarningsAsErrors>
</PropertyGroup>
```

**Q: What is TrimmerRootAssembly and when do I use it?**
A: `<TrimmerRootAssembly Include="AssemblyName" />` tells the trimmer to analyze the entire assembly and keep all reachable code. Use it in test projects to ensure your library is thoroughly analyzed for trim warnings.

**Q: How do I use [DynamicDependency] attribute?**
A: `[DynamicDependency]` preserves specific members that would otherwise be trimmed:
```csharp
[DynamicDependency("HelperMethod", "MyAssembly")]
public void CallHelperViaReflection()
{
    // Ensures HelperMethod is kept even if not statically referenced
}
```
Use this as a last resort when other annotations don't work.

**Q: Can I trim different amounts based on deployment target?**
A: Yes, you can use conditional MSBuild properties:
```xml
<PropertyGroup Condition="'$(Configuration)' == 'Release'">
    <PublishTrimmed>true</PublishTrimmed>
    <InvariantGlobalization>true</InvariantGlobalization>
</PropertyGroup>
```

## Performance and Optimization Questions

**Q: Does trimming affect application performance?**
A: Trimming generally improves performance through faster startup (less code to load), reduced memory usage, and better cache locality. However, build times increase due to static analysis overhead.

**Q: Should I combine trimming with other optimizations?**
A: Yes, trimming works excellently with: Single-file deployment (smaller final executable), ReadyToRun (faster startup), Native AOT (maximum optimization), and container deployment (smaller images).

**Q: How does trimming affect debugging and diagnostics?**
A: You can control debugging support with `<DebuggerSupport>false</DebuggerSupport>` to remove debugging code, and `<TrimmerRemoveSymbols>true</TrimmerRemoveSymbols>` to remove debug symbols. This reduces size but makes debugging harder.

**Q: What's the build time impact of enabling trimming?**
A: Trimming adds significant build time due to static analysis. The impact depends on application size and complexity. Consider using trimming only for release builds or when deploying to production.

## Migration and Best Practices Questions

**Q: How do I migrate an existing application to use trimming?**
A: 1) Enable `<PublishTrimmed>true</PublishTrimmed>`, 2) Build and address all trim warnings, 3) Replace reflection-heavy code with source generators, 4) Test thoroughly with trimmed builds, 5) Consider enabling feature switches to reduce size further.

**Q: What are the best practices for trim-compatible library design?**
A: 1) Minimize reflection usage, 2) Use source generators instead of runtime code generation, 3) Annotate reflection requirements with `[DynamicallyAccessedMembers]`, 4) Mark incompatible APIs with `[RequiresUnreferencedCode]`, 5) Test with trimming enabled.

**Q: How do I handle reflection that can't be made static?**
A: For unavoidable reflection: 1) Isolate it in specific methods, 2) Annotate with `[RequiresUnreferencedCode]`, 3) Consider providing trim-safe alternatives, 4) Document the trimming requirements clearly for consumers.

**Q: Should I enable trimming for all my applications?**
A: Enable trimming when: deployment size matters, you're using self-contained deployment, you can address compatibility issues, and you can test thoroughly. Skip it for: framework-dependent apps, applications with extensive reflection, rapid prototyping scenarios.

**Q: How do I validate that trimming doesn't break my application?**
A: 1) Create comprehensive tests covering all application functionality, 2) Test with trimmed builds in staging environments, 3) Monitor for runtime exceptions related to missing types/members, 4) Use static analysis warnings as early indicators of potential issues.

## Specific Technology Integration Questions

**Q: How does trimming work with ASP.NET Core?**
A: ASP.NET Core supports trimming with minimal APIs and source generators. Use `WebApplication.CreateSlimBuilder()` for better trim compatibility, ensure JSON serialization uses source generation, and avoid reflection-heavy features like MVC model binding.

**Q: Can I use trimming with Entity Framework Core?**
A: EF Core has limited trimming support. Use compiled models where possible, avoid dynamic query construction, and test thoroughly. Consider alternative data access approaches like Dapper for better trim compatibility.

**Q: How does trimming interact with dependency injection?**
A: Use compile-time DI where possible, avoid dynamic type discovery, register services explicitly rather than by convention, and consider source-generated DI containers for better trim compatibility.

**Q: What's the relationship between trimming and globalization?**
A: Set `<InvariantGlobalization>true</InvariantGlobalization>` to remove culture-specific code and data, significantly reducing size. Only use this if your application doesn't need localization or culture-specific formatting.