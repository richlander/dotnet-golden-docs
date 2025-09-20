# File-based Apps - Golden Reference

## Overview

File-based apps enable developers to run and publish single `.cs` files directly without creating traditional project structures. This .NET 10+ feature streamlines scripting, prototyping, and automation by eliminating project setup overhead while maintaining full .NET runtime capabilities.

**What it is**: A simplified approach where `dotnet run app.cs` executes standalone C# files. The dotnet host automatically builds these files in a temporary folder, supporting top-level statements or classic `Main` methods. File-based apps support a set of directives -- package and project references -- that otherwise would require a project file. These directives make file-based apps flexible and expressive while maintaining compatibility with MSBuild concepts. On Linux and macOS, file-based apps can be run as shebang-style scripts.

**Core capabilities**:

- **Direct execution**: Run `.cs` files without project files using `dotnet run app.cs`
- **Package integration**: Add NuGet packages with `#:package` directives
- **Project references**: Reference local projects with `#:project` directives
- **Publishing flexibility**: Create standalone executables with `dotnet publish app.cs` (Native AOT and single file capable)
- **Cross-platform scripting**: Unix shebang support for direct shell execution
- **Seamless conversion**: Transform scripts to full projects with `dotnet project convert app.cs`

**When to use**:

- Learning C# fundamentals and experimenting with language features
- Quick scripts and automation tasks
- Rapid prototyping and algorithm experimentation
- Command-line utilities with minimal setup overhead
- Cross-platform scripting (alternative to shell scripts or PowerShell)
- LLM-generated tools and single-purpose utilities

**Key benefits**:

- **Reduced complexity**: No `.csproj` files, solution management, or project structure
- **Simplified workflow**: Files run directly without explicit project setup or build commands
- **Full .NET ecosystem**: Access to all .NET libraries, NuGet packages, and language features
- **Publishing options**: Native AOT compilation available for published executables
- **Gradual migration**: Seamless path from simple scripts to complex projects
- **Development velocity**: Lower entry barriers for C# learning and experimentation

**Key tradeoffs**:

- **Single file constraint**: Only works with exactly one `.cs` file per directory
- **Limited build artifacts**: `dotnet build` intentionally doesn't create persistent outputs (use `dotnet publish` instead)
- **Team collaboration**: Not optimized for multi-developer workflows or complex project management
- **Advanced scenarios**: Better suited for simple utilities than enterprise applications with complex dependencies

## Essential Syntax & Examples

TITLE: Basic Hello World Execution
DESCRIPTION: Simple file-based app with immediate execution
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/csharp/fundamentals/tutorials/file-based-programs.md>
LANGUAGE: C#
CODE:

```csharp
Console.WriteLine("Hello, World!");
```

------

TITLE: Command-Line Arguments Processing
DESCRIPTION: Handle arguments with proper separator syntax
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/csharp/fundamentals/tutorials/file-based-programs.md>
LANGUAGE: C#
CODE:

```csharp
if (args.Length == 0)
{
    Console.WriteLine("Hello, World!");
    return;
}

foreach (string name in args)
{
    Console.WriteLine($"Hello, {name}!");
}
```

------

TITLE: NuGet Package Integration
DESCRIPTION: Use external packages with file-level directive
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/csharp/fundamentals/tutorials/file-based-programs.md>
LANGUAGE: C#
CODE:

```csharp
#:package Newtonsoft.Json

using Newtonsoft.Json;

var data = new { Name = "Alice", Age = 30 };
string json = JsonConvert.SerializeObject(data, Formatting.Indented);
Console.WriteLine(json);
```

------

TITLE: Local Project Reference
DESCRIPTION: Reference local projects with file-level directive
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/core/whats-new/dotnet-10/sdk.md>
LANGUAGE: C#
CODE:

```csharp
#:project ../ClassLib/ClassLib.csproj

var greeter = new ClassLib.Greeter();
var greeting = greeter.Greet(args.Length > 0 ? args[0] : "World");
Console.WriteLine(greeting);
```

------

TITLE: Cross-Platform Shebang Script
DESCRIPTION: Direct execution with Unix shebang support
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/csharp/fundamentals/tutorials/file-based-programs.md>
LANGUAGE: C#
CODE:

```csharp
#!/usr/bin/env dotnet run --

if (args.Length == 0)
{
    Console.WriteLine("Usage: ./script.cs <name>");
    return 1;
}

Console.WriteLine($"Hello, {args[0]}!");
return 0;
```

------

TITLE: Native AOT Publishing
DESCRIPTION: Create standalone native executable
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/core/whats-new/dotnet-10/sdk.md>
LANGUAGE: C#
CODE:

```csharp
#:property PublishAot=true

Console.WriteLine("Application started");

string target = args.Length > 0 ? args[0] : "default";
Console.WriteLine($"Target: {target}");
```

------

TITLE: Single File Publishing
DESCRIPTION: Create self-contained single file executable
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/core/whats-new/dotnet-10/sdk.md>
LANGUAGE: C#
CODE:

```csharp
#:property PublishSingleFile=true

Console.WriteLine("Single file application started");

string mode = args.Length > 0 ? args[0] : "interactive";
Console.WriteLine($"Running in {mode} mode");
```

## Relationships & Integration

**Ecosystem positioning**: File-based apps sit between simple scripts and full project structures, bridging the gap for .NET developers who need more than basic scripting but less than enterprise project complexity.

**MSBuild integration**: File-level directives (`#:package`, `#:project`, `#:property`) maintain full compatibility with MSBuild concepts while avoiding explicit project file creation. The dotnet host synthesizes temporary project files behind the scenes.

**NuGet ecosystem**: Direct package integration via `#:package` directives provides immediate access to the entire NuGet ecosystem without package.config or PackageReference management.

**Cross-platform scripting**: Can replace platform-specific scripting solutions (PowerShell on Windows, bash/Python on Unix) with a unified C# approach that works consistently across all .NET-supported platforms.

**Migration pathways**:

- **From scripts**: Upgrade from .csx (C# Script) or shell scripts to full C# with complete IntelliSense and debugging
- **To projects**: Use `dotnet project convert app.cs` to transform growing file-based apps into traditional project structures when complexity increases

**IDE integration**: Works seamlessly with Visual Studio Code and other editors that support C# language services, providing full IntelliSense, debugging, and syntax highlighting without project setup.

**Publishing flexibility**: Integrates with all .NET publishing options including Native AOT, single-file deployment, framework-dependent deployment, and self-contained deployment through file-level property directives.
