# System.CommandLine
## Building Simple Console Tools

For basic file processing tools with options and validation:

```csharp
var fileArgument = new Argument<FileInfo>("file", "File to process");
var outputOption = new Option<DirectoryInfo>("--output", "Output directory");
var verboseOption = new Option<bool>("--verbose", "Enable verbose logging");

var rootCommand = new RootCommand("File processor");
rootCommand.AddArgument(fileArgument);
rootCommand.AddOption(outputOption);
rootCommand.AddOption(verboseOption);

rootCommand.SetHandler((file, output, verbose) =>
{
    ProcessFile(file, output, verbose);
}, fileArgument, outputOption, verboseOption);

return await rootCommand.InvokeAsync(args);
```

## Building Multi-Command Applications

For tools with subcommands like git, npm, or dotnet:

```csharp
var rootCommand = new RootCommand("Package manager");

// add command
var addCommand = new Command("add", "Add a package");
var packageArg = new Argument<string>("package", "Package name");
var versionOption = new Option<string>("--version", "Package version");
addCommand.AddArgument(packageArg);
addCommand.AddOption(versionOption);
addCommand.SetHandler(AddPackage, packageArg, versionOption);

// remove command
var removeCommand = new Command("remove", "Remove a package");
var removePackageArg = new Argument<string>("package", "Package to remove");
removeCommand.AddArgument(removePackageArg);
removeCommand.SetHandler(RemovePackage, removePackageArg);

rootCommand.AddCommand(addCommand);
rootCommand.AddCommand(removeCommand);
```

## Complex Type Binding

For applications with rich configuration objects:

```csharp
public record BuildOptions(
    string Project,
    string Configuration = "Debug",
    string? Output = null,
    bool NoRestore = false,
    LogLevel Verbosity = LogLevel.Normal);

var projectArg = new Argument<string>("project");
var configOption = new Option<string>("--configuration") { GetDefaultValue = () => "Debug" };
var outputOption = new Option<string?>("--output");
var noRestoreOption = new Option<bool>("--no-restore");
var verbosityOption = new Option<LogLevel>("--verbosity");

var buildCommand = new Command("build");
buildCommand.AddArgument(projectArg);
buildCommand.AddOption(configOption);
buildCommand.AddOption(outputOption);
buildCommand.AddOption(noRestoreOption);
buildCommand.AddOption(verbosityOption);

buildCommand.SetHandler<BuildOptions>(Build);
```
