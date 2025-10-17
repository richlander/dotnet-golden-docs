# File-based Apps
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
