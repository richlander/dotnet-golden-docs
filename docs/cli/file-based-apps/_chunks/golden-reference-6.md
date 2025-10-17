# Use publish for deployable artifacts
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
