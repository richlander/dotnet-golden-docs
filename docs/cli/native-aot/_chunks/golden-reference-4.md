# Publish file-based app (new in .NET 10)
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
