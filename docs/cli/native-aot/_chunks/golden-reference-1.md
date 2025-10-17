# Publish file-based app (new in .NET 10)
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
