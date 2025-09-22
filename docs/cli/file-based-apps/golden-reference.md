# File-based Apps - Golden Reference

## Overview

File-based apps enable developers to run and publish single `.cs` files directly without creating traditional project structures. This .NET 10+ feature streamlines scripting, prototyping, and automation by eliminating project setup overhead while maintaining full .NET runtime capabilities.

What it is: A simplified approach where `dotnet run app.cs` executes standalone C# files. The dotnet host automatically builds these files in a temporary folder, supporting top-level statements or classic `Main` methods. File-based apps support a set of directives -- package and project references -- that otherwise would require a project file. These directives make file-based apps flexible and expressive while maintaining compatibility with MSBuild concepts. On Linux and macOS, file-based apps can be run as shebang-style scripts.

Core capabilities:

- Direct execution: Run `.cs` files without project files using `dotnet run app.cs`
- Package integration: Add NuGet packages with `#:package` directives
- Project references: Reference local projects with `#:project` directives
- Publishing flexibility: Create standalone executables with `dotnet publish app.cs` (Native AOT and single file capable)
- Cross-platform scripting: Unix shebang support for direct shell execution
- Seamless conversion: Transform scripts to full projects with `dotnet project convert app.cs`

When to use:

- Learning C# fundamentals and experimenting with language features
- Quick scripts and automation tasks
- Rapid prototyping and algorithm experimentation
- Command-line utilities with minimal setup overhead
- Cross-platform scripting (alternative to shell scripts or PowerShell)
- LLM-generated tools and single-purpose utilities

Key benefits:

- Reduced complexity: No `.csproj` files, solution management, or project structure
- Simplified workflow: Files run directly without explicit project setup or build commands
- Full .NET ecosystem: Access to all .NET libraries, NuGet packages, and language features
- Publishing options: Native AOT compilation available for published executables
- Gradual migration: Seamless path from simple scripts to complex projects
- Development velocity: Lower entry barriers for C# learning and experimentation

Key tradeoffs:

- Single file constraint: Only works with exactly one `.cs` file per directory
- Limited build artifacts: `dotnet build` intentionally doesn't create persistent outputs (use `dotnet publish` instead)
- Team collaboration: Not optimized for multi-developer workflows or complex project management
- Advanced scenarios: Better suited for simple utilities than enterprise applications with complex dependencies

## Relationships & Integration

Ecosystem positioning: File-based apps sit between simple scripts and full project structures, bridging the gap for .NET developers who need more than basic scripting but less than enterprise project complexity.

MSBuild integration: File-level directives (`#:package`, `#:project`, `#:property`) maintain full compatibility with MSBuild concepts while avoiding explicit project file creation. The dotnet host synthesizes temporary project files behind the scenes.

NuGet ecosystem: Direct package integration via `#:package` directives provides immediate access to the entire NuGet ecosystem without package.config or PackageReference management.

Cross-platform scripting: Can replace platform-specific scripting solutions (PowerShell on Windows, bash/Python on Unix) with a unified C# approach that works consistently across all .NET-supported platforms.

Migration pathways:

- From scripts: Upgrade from .csx (C# Script) or shell scripts to full C# with complete IntelliSense and debugging
- To projects: Use `dotnet project convert app.cs` to transform growing file-based apps into traditional project structures when complexity increases

IDE integration: Works seamlessly with Visual Studio Code and other editors that support C# language services, providing full IntelliSense, debugging, and syntax highlighting without project setup.

Publishing flexibility: Integrates with all .NET publishing options including Native AOT, single-file deployment, framework-dependent deployment, and self-contained deployment through file-level property directives.

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
#!/usr/bin/env dotnet

if (args.Length == 0)
{
    Console.WriteLine("Usage: ./script.cs <name>");
    return 1;
}

Console.WriteLine($"Hello, {args[0]}!");
return 0;
```

------

TITLE: Standard Input Processing
DESCRIPTION: Handle both command line arguments and standard input
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/csharp/fundamentals/tutorials/file-based-programs.md>
LANGUAGE: C#
CODE:

```csharp
if (args.Length > 0)
{
    string message = string.Join(' ', args);
    Console.WriteLine(message);
}
else
{
    while (Console.ReadLine() is string line && line.Length > 0)
    {
        Console.WriteLine(line);
    }
}
```

------

TITLE: ASCII Art with Packages
DESCRIPTION: Using external packages for enhanced functionality
SOURCE: <https://raw.githubusercontent.com/dotnet/docs/main/docs/csharp/fundamentals/tutorials/file-based-programs.md>
LANGUAGE: C#
CODE:

```csharp
#:package Colorful.Console/1.2.15

using System.Drawing;

if (args.Length > 0)
{
    string message = string.Join(' ', args);
    Colorful.Console.WriteAscii(message, Color.Blue);
}
else
{
    while (Console.ReadLine() is string line && line.Length > 0)
    {
        Colorful.Console.WriteAscii(line, Color.Blue);
    }
}
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

## Common Scenarios

### ASCII Art Generator

File-based apps excel for creative utilities like text-to-ASCII art converters using external packages:

```csharp
#!/usr/bin/env dotnet
#:package Colorful.Console/1.2.15
#:package System.CommandLine/2.0.0-beta6

using System.CommandLine;
using System.Drawing;

var delayOption = new Option<int>("--delay", "Delay between lines in milliseconds");
var messagesArgument = new Argument<string[]>("messages", "Text to convert to ASCII art");

var rootCommand = new RootCommand("Convert text to ASCII art");
rootCommand.AddOption(delayOption);
rootCommand.AddArgument(messagesArgument);

var parseResult = rootCommand.Parse(args);
if (parseResult.Errors.Count > 0)
{
    foreach (var error in parseResult.Errors)
        Console.WriteLine(error.Message);
    return 1;
}

var options = ProcessArgs(parseResult);
await WriteAsciiArt(options);
return 0;

AsciiOptions ProcessArgs(ParseResult parseResult)
{
    var delay = parseResult.GetValueForOption(delayOption);
    var messages = parseResult.GetValueForArgument(messagesArgument);

    if (messages?.Length > 0)
        return new AsciiOptions(messages, delay);

    // Read from standard input
    var inputLines = new List<string>();
    while (Console.ReadLine() is string line && line.Length > 0)
        inputLines.Add(line);

    return new AsciiOptions(inputLines.ToArray(), delay);
}

async Task WriteAsciiArt(AsciiOptions options)
{
    foreach (string message in options.Messages)
    {
        Colorful.Console.WriteAscii(message, Color.Blue);
        if (options.Delay > 0)
            await Task.Delay(options.Delay);
    }
}

record AsciiOptions(string[] Messages, int Delay);
```

### File Path Detection at Runtime

Access the source file location during execution for debugging or configuration:

```csharp
#:property LangVersion=preview

Console.WriteLine("From [CallerFilePath] attribute:");
Console.WriteLine($" - Entry-point path: {Path.EntryPointFilePath()}");
Console.WriteLine($" - Entry-point directory: {Path.EntryPointFileDirectoryPath()}");

Console.WriteLine("From AppContext data:");
Console.WriteLine($" - Entry-point path: {AppContext.EntryPointFilePath()}");
Console.WriteLine($" - Entry-point directory: {AppContext.EntryPointFileDirectoryPath()}");

static class PathEntryPointExtensions
{
    extension(Path)
    {
        public static string EntryPointFilePath() => EntryPointImpl();
        public static string EntryPointFileDirectoryPath() => Path.GetDirectoryName(EntryPointImpl()) ?? "";
        private static string EntryPointImpl([System.Runtime.CompilerServices.CallerFilePath] string filePath = "") => filePath;
    }
}

static class AppContextExtensions
{
    extension(AppContext)
    {
        public static string? EntryPointFilePath() => AppContext.GetData("EntryPointFilePath") as string;
        public static string? EntryPointFileDirectoryPath() => AppContext.GetData("EntryPointFileDirectoryPath") as string;
    }
}
```

### Command Line Processing

Handle both arguments and standard input with proper validation:

```csharp
if (args.Length > 0)
{
    string message = string.Join(' ', args);
    Console.WriteLine(message);
}
else
{
    while (Console.ReadLine() is string line && line.Length > 0)
    {
        Console.WriteLine(line);
    }
}
```

### Learning and Experimentation

Perfect for exploring C# language features without project setup:

```csharp
// Demonstrate top-level statements with local functions
var testData = new[] { "hello", "world", "123", "" };

foreach (var item in testData)
{
    Console.WriteLine($"{item} -> {ClassifyInput(item)}");
}

string ClassifyInput(string input) => input switch
{
    "" => "Empty",
    var s when int.TryParse(s, out _) => "Number",
    var s when s.Length < 5 => "Short text",
    _ => "Long text"
};
```

## Alternative Syntax Options

File-based apps complement traditional project structures rather than replacing them. Both approaches remain valid for different scenarios:

### Traditional Project Structure

```csharp
// Traditional approach with .csproj file
// MyUtility.csproj
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net9.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Newtonsoft.Json" Version="13.0.3" />
  </ItemGroup>
</Project>

// Program.cs
using Newtonsoft.Json;

var data = new { Name = "Alice", Age = 30 };
string json = JsonConvert.SerializeObject(data);
Console.WriteLine(json);
```

### File-based App Equivalent

```csharp
// utility.cs - Same functionality with file-based approach
#:package Newtonsoft.Json

using Newtonsoft.Json;

var data = new { Name = "Alice", Age = 30 };
string json = JsonConvert.SerializeObject(data);
Console.WriteLine(json);
```

### Migration Path

Transform file-based apps to traditional projects when complexity grows:

```bash
# Convert file-based app to traditional project
dotnet project convert utility.cs

# This creates:
# - utility.csproj with appropriate package references
# - Preserves existing code in Program.cs
# - Maintains all functionality while enabling multi-file development
```

### Command Line Usage Patterns

```bash
# File-based execution
dotnet run utility.cs -- arg1 arg2

# Traditional project execution
dotnet run --project ./MyUtility -- arg1 arg2

# Both support the same publishing options
dotnet publish utility.cs -o ./dist
dotnet publish ./MyUtility -o ./dist
```

## Best Practices

### Argument Handling

Always use the `--` separator when passing arguments that might conflict with dotnet commands:

```bash
# Correct - prevents argument conflicts
dotnet run script.cs -- --verbose --output results.txt

# Incorrect - arguments may be interpreted by dotnet run
dotnet run script.cs --verbose --output results.txt
```

### Package Management

Use specific package versions for production scripts to ensure consistency:

```csharp
// Recommended for production scripts
#:package Newtonsoft.Json/13.0.3
#:package Microsoft.Extensions.Logging/8.0.0

// Acceptable for experimentation
#:package Newtonsoft.Json
```

### Error Handling and Exit Codes

Implement proper error handling and return meaningful exit codes:

```csharp
try
{
    // Script logic here
    Console.WriteLine("Script completed successfully");
    return 0;
}
catch (FileNotFoundException ex)
{
    Console.Error.WriteLine($"File not found: {ex.FileName}");
    return 1;
}
catch (Exception ex)
{
    Console.Error.WriteLine($"Unexpected error: {ex.Message}");
    return 2;
}
```

### Publishing Strategy

Use `dotnet publish` rather than `dotnet build` for deployment artifacts:

```bash
# For distribution - creates executable
dotnet publish script.cs -o ./bin

# For Native AOT (smaller, faster startup)
dotnet publish script.cs -p:PublishAot=true -o ./bin

# For single-file deployment
dotnet publish script.cs -p:PublishSingleFile=true -o ./bin
```

### Cross-Platform Considerations

Design scripts with cross-platform compatibility in mind:

```csharp
// Use Path.Combine for file paths
string configPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "myapp", "config.json");

// Check platform when needed
if (OperatingSystem.IsWindows())
{
    // Windows-specific code
}
else if (OperatingSystem.IsLinux() || OperatingSystem.IsMacOS())
{
    // Unix-like specific code
}
```

## Limitations and Considerations

### Single File Constraint

File-based apps work only with exactly one `.cs` file per directory:

```bash
# This works - single file
/scripts/
  utility.cs

# This doesn't work - multiple .cs files
/scripts/
  utility.cs
  helper.cs    # Not supported
```

### Build Command Behavior

`dotnet build` intentionally doesn't create persistent artifacts for file-based apps:

```bash
# Doesn't create lasting build outputs
dotnet build script.cs

# Use publish for deployable artifacts
dotnet publish script.cs -o ./output
```

### Directive Syntax Requirements

File-level directives must follow specific syntax patterns:

```csharp
// Package references require version separator
#:package Newtonsoft.Json/13.0.3
#:package System.CommandLine/2.0.0-beta6

// SDK references require @ separator
#:sdk Aspire.AppHost.Sdk@9.3.1

// Properties require = separator
#:property LangVersion=preview
#:property PublishAot=false

// Project references support both file and directory paths
#:project ../ClassLib/ClassLib.csproj
#:project ../ClassLib
```

### Package Reference Limitations

File-level directives support basic package scenarios but may not cover all MSBuild capabilities:

```csharp
// Supported
#:package Newtonsoft.Json/13.0.3
#:project ../MyLibrary/MyLibrary.csproj

// Not supported - complex MSBuild properties
// Use traditional projects for advanced scenarios
```

### Team Development Considerations

File-based apps optimize for individual productivity rather than team collaboration:

- No solution file integration
- Limited support for shared build configurations
- Basic IntelliSense compared to full project structure
- Consider migration to traditional projects as team size grows

### Debugging Experience

While debugging works, some advanced debugging features require traditional project structure:

```bash
# Basic debugging works
dotnet run script.cs

# For advanced debugging scenarios, convert to project
dotnet project convert script.cs
```
