# File-based Apps - Basics Q&A

## Getting Started

---
tags: ["beginner", "concept", "usage"]
validation: "Covers definition and use cases accurately"
---
Q: What are file-based apps in .NET and when should I use them?
A: File-based apps allow you to run and publish single .cs files directly without creating a traditional project structure. Use them for:
- Quick scripts and prototypes
- Learning and experimentation
- Single-file utilities
- Simple automation tasks

------

---
tags: ["beginner", "quickstart", "process"]
validation: "Instructions are complete and accurate"
---
Q: How do I create a minimal working file-based app?
A: Create a .cs file with your code and run it directly with `dotnet run filename.cs`. For example, create hello.cs with `Console.WriteLine("Hello, World!");` then run with `dotnet run hello.cs`.

------

---
tags: ["beginner", "example", "code"]
validation: "Code compiles and runs with dotnet run"
---
Q: Please create a minimal working file-based app.
A:
```csharp
Console.WriteLine("Hello, World!");
```
Save as hello.cs and run with `dotnet run hello.cs`

------

---
tags: ["beginner", "cli", "execution"]
validation: "Command executes successfully"
---
Q: How do I run a file-based app?
A: Use `dotnet run` followed by the .cs filename:
```bash
dotnet run hello.cs
```
Critical limitation: File-based apps only work when there is a single .cs file in the directory. If there are multiple .cs files, the command will fail with ambiguity errors.

------

---
tags: ["beginner", "cli", "execution", "limitations"]
validation: "Command executes successfully and produces expected output"
---
Q: How do I pass arguments to a file-based app?
A: Use `dotnet run` followed by the .cs filename:
```bash
dotnet run hello.cs -- --arg --arg2 "quoted argument"
```
Important: Use `--` to separate `dotnet run` options from your app's arguments. Without `--`, arguments might be interpreted as `dotnet run` options instead of being passed to your app, for example `dotnet run hello.cs -- --help`.

------

---
tags: ["intermediate", "limitations", "troubleshooting", "multi-file"]
validation: "Demonstrates the multi-file limitation and provides workarounds"
---
Q: What happens if I have multiple .cs files in the same directory?
A: File-based apps have a significant limitation: they only work when there is exactly one .cs file in the directory. If you have multiple .cs files, `dotnet run filename.cs` will fail because the runtime cannot determine which file to use as the entry point.

Example of the problem:
```bash
# Directory with multiple .cs files
ls *.cs
# output: hello.cs  world.cs  utils.cs

dotnet run hello.cs
# Error: Unable to determine the entry point
```

Solutions:
1. Use separate directories - Put each file-based app in its own directory
2. Combine into one file - Merge related functionality into a single .cs file
3. Convert to traditional project - Use `dotnet new console` for multi-file programs

This limitation is tracked in: https://github.com/dotnet/sdk/issues/48170

## Project References and Dependencies

---
tags: ["intermediate", "dependencies", "project-references"]
validation: "Code compiles with project reference and can use referenced types"
---
Q: How do I reference other projects from a file-based app?
A: Use the `#:project` directive at the top of your file:
```csharp
#:project ../MyLibrary/MyLibrary.csproj

using MyLibrary;

var service = new MyService();
service.DoWork();
```

------

---
tags: ["intermediate", "dependencies", "packages"]
validation: "Code compiles with package references and uses package functionality"
---
Q: Can I use NuGet packages in file-based apps?
A: Use the `#:package` directive at the top of your file:
```csharp
#:package Colorful.Console@1.2.15
#:package System.CommandLine@2.0.0-beta6

using Colorful.Console;
Console.WriteAscii("Hello World!");
```
For complex dependencies or multiple interconnected packages, consider using traditional projects instead.

## Project migraton

---
tags: ["intermediate", "migration", "project-conversion", "workflow"]
validation: "Conversion steps produce working traditional project"
---
Q: When should I convert a file-based app to a traditional project, and how do I do it?
A: Convert to a traditional project when you need:
- Multiple source files
- Complex dependencies or many NuGet packages
- Team collaboration with version control
- Advanced MSBuild features
- Integration with larger solutions

Use the built-in conversion command:
```bash
dotnet project convert app.cs
```

This command automatically:
- Creates a new directory named for your file
- Scaffolds a .csproj file
- Moves your code into Program.cs
- Translates any #: directives into MSBuild properties and references

Note: File-based apps are ideal for prototyping - start simple, convert when you outgrow the single-file format.

------

---
tags: ["intermediate", "migration", "project-conversion"]
validation: "Explains manual conversion limitation accurately"
---
Q: Can I convert a traditional project file-based?
A: You can convert a traditional project to the file-based app format manually. There is no CLI command for this conversion. The `dotnet project convert` command is conversion in the other direction, converting file-based apps to traditional projects.

## Configuration and Directives

---
tags: ["intermediate", "configuration", "directives"]
validation: "Properties are applied correctly during build/publish"
---
Q: How do I configure build settings for file-based apps?
A: Use `#:property` directives at the top of your file:
```csharp
#:property PublishAot=true
#:property SelfContained=true
#:property RuntimeIdentifier=linux-x64

Console.WriteLine("Configured for Linux deployment");
```

------

---
tags: ["intermediate", "cross-platform", "scripting", "automation", "shebang"]
validation: "File executes directly on Unix-like systems and processes arguments correctly"
---
Q: How do I create shebang-style scripts with file-based apps on Linux/macOS?
A: Add a shebang line at the top and make the file executable. This is one of the most powerful features for creating cross-platform automation scripts:

```csharp
#!/usr/bin/env dotnet run
using System.IO;

// Process command line arguments
var args = Environment.GetCommandLineArgs().Skip(1);
Console.WriteLine($"Processing {args.Count()} arguments...");

foreach (var arg in args)
{
    Console.WriteLine($"  - {arg}");
}

// Example: Simple file processing script
if (args.Any())
{
    var fileName = args.First();
    if (File.Exists(fileName))
    {
        var lines = File.ReadAllLines(fileName);
        Console.WriteLine($"File {fileName} has {lines.Length} lines");
    }
}
```

Make it executable and run:
```bash
chmod +x process-files.cs
./process-files.cs file1.txt file2.txt
```

This allows you to create powerful .NET-based shell scripts that work just like traditional bash/Python scripts but with full C# capabilities.

------

## Publishing and Deployment

---
tags: ["intermediate", "publishing", "executables"]
validation: "Commands execute and produce working executables"
---
Q: How do I publish a file-based app to create an executable?
A: Use `dotnet publish` with the filename:
```bash
# Create executable
dotnet publish hello.cs -o ./output

# Target Windows x64
dotnet publish hello.cs -r win-x64 -o ./output

# Target Linux arm64
dotnet publish hello.cs -r linux-arm64 -o ./output

```

------

---
tags: ["advanced", "publishing", "native-aot", "performance"]
validation: "Produces native executable with AOT compilation"
---
Q: How do I publish a file-based app with Native AOT?
A: Use the `#:property PublishAot=true` directive in your file:
```csharp
#:property PublishAot=true

Console.WriteLine("Native AOT application started");
```
Then publish normally:
```bash
dotnet publish app.cs -o ./output
```

------

---
tags: ["intermediate", "publishing", "single-file", "deployment"]
validation: "Produces self-contained single file executable"
---
Q: How do I publish a file-based app as a single file?
A: Use the `#:property PublishSingleFile=true` directive in your file:
```csharp
#:property PublishSingleFile=true

Console.WriteLine("Single file application started");
string mode = args.Length > 0 ? args[0] : "interactive";
Console.WriteLine($"Running in {mode} mode");
```
Then publish:
```bash
dotnet publish app.cs -o ./output
```

------

## Migration and Alternatives

---
tags: ["migration", "alternatives", "dotnet-script", "comparison"]
validation: "Test migration examples work with both approaches"
---
Q: Should I use `dotnet script` or file-based apps for single-file C# programs?
A: Use .NET 10 file-based apps for new development:

File-based apps advantages:
- Built into .NET 10 (no external tool installation)
- Uses standard .cs files (not .csx)
- Full .NET runtime and library support
- Integrated with dotnet CLI
- Project references via #:project
- Package references via #:package
- Cross-platform shebang script support

dotnet script is still useful for:
- Legacy .csx scripts that already exist
- REPL-style development and experimentation
- .NET versions before 10

Before (script.csx -- dotnet script)
```csharp
#r "nuget: Humanizer, 2.14.1"
Console.WriteLine("Hello".Humanize());
```

After (script.cs -- file-based apps):
```csharp
#:package Humanizer@2.14.1
Console.WriteLine("Hello".Humanize());
```

------

## Troubleshooting

---
tags: ["troubleshooting", "cli", "arguments"]
validation: "Test both forms to show the difference"
---
Q: Why isn't my file-based app receiving command-line arguments?
A: You're likely missing the `--` separator. The `dotnet run` command needs `--` to distinguish between dotnet options and your app's arguments.

Perfect example with `--help`:
```bash
# Wrong - shows dotnet run help, not your app's help
dotnet run myapp.cs --help

# Right - passes --help to your app
dotnet run myapp.cs -- --help
```

Other common gotchas:
```bash
# Wrong - dotnet interprets these options
dotnet run myapp.cs --verbose --configuration Release

# Right - your app receives these arguments
dotnet run myapp.cs -- --verbose --configuration Release
```

The official explanation: "The `--` option indicates that all following command arguments should be passed to the [app] program."

------

---
tags: ["troubleshooting", "project-references", "debugging"]
validation: "Manual review - covers common issues and solutions"
---
Q: Why isn't my file-based app finding project references?
A: Common issues:
1. Incorrect path: Ensure `#:project` path is relative to the .cs file location
2. Missing project file: Verify the referenced .csproj exists
3. Build order: Referenced projects are built automatically, but check for circular dependencies

```csharp
#:project ../MyLibrary/MyLibrary.csproj
#:project ../../Shared/Utilities/Utilities.csproj
```
