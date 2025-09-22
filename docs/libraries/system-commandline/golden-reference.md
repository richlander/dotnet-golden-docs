# System.CommandLine - Golden Reference

## Overview

System.CommandLine is a command-line parsing library for .NET that provides functionality commonly needed by command-line apps, such as parsing command-line input and displaying help text. It handles the complex details of command-line parsing according to POSIX or Windows conventions, allowing developers to focus on their application logic.

Key advantages include:

- Strongly-typed parsing: Automatic conversion of command-line arguments to .NET types
- Automatic help generation: Built-in help text generation with minimal configuration
- Tab completion support: Shell completion for commands, options, and arguments
- Response files: Support for @file syntax to read arguments from files
- POSIX and Windows conventions: Flexible parsing rules for different platforms
- Native AOT compatibility: Works with trimmed and AOT-compiled applications

The library provides three main approaches:

1. Imperative API: Programmatic construction of command hierarchies
2. Model binding: Automatic binding to method parameters or classes
3. Handler delegates: Direct invocation of lambda expressions or methods

Use System.CommandLine when building console applications that need robust command-line parsing, especially when you want automatic help generation, tab completion, or plan to distribute as a .NET global tool.

## Essential Syntax & Examples

### Basic Command Definition

```csharp
var rootCommand = new RootCommand("Sample app for System.CommandLine");

var fileOption = new Option<FileInfo?>(
    name: "--file",
    description: "The file to read and display on the console.");

var delayOption = new Option<int>(
    name: "--delay",
    description: "Delay between lines, specified as milliseconds per character in a line.",
    getDefaultValue: () => 42);

rootCommand.AddOption(fileOption);
rootCommand.AddOption(delayOption);

rootCommand.SetHandler((file, delay) =>
{
    ReadFile(file!, delay);
}, fileOption, delayOption);

return rootCommand.Invoke(args);
```

### Subcommands and Hierarchies

```csharp
var rootCommand = new RootCommand("Git-like CLI");

var addCommand = new Command("add", "Add files to the repository");
var fileArgument = new Argument<string[]>("files", "Files to add");
addCommand.AddArgument(fileArgument);

var commitCommand = new Command("commit", "Commit changes");
var messageOption = new Option<string>("--message", "Commit message") { IsRequired = true };
commitCommand.AddOption(messageOption);

rootCommand.AddCommand(addCommand);
rootCommand.AddCommand(commitCommand);
```

### Model Binding

```csharp
public class Settings
{
    public FileInfo? File { get; set; }
    public int Delay { get; set; } = 42;
    public bool Verbose { get; set; }
}

var fileOption = new Option<FileInfo?>("--file");
var delayOption = new Option<int>("--delay");
var verboseOption = new Option<bool>("--verbose");

var rootCommand = new RootCommand();
rootCommand.AddOption(fileOption);
rootCommand.AddOption(delayOption);
rootCommand.AddOption(verboseOption);

rootCommand.SetHandler<Settings>(ProcessFile);

static void ProcessFile(Settings settings)
{
    // Use settings.File, settings.Delay, settings.Verbose
}
```

### Advanced Validation

```csharp
var fileOption = new Option<FileInfo>("--file");
fileOption.AddValidator(result =>
{
    var file = result.GetValueForOption(fileOption);
    if (file?.Exists != true)
    {
        result.ErrorMessage = $"File does not exist: {file?.FullName}";
    }
});

var rangeOption = new Option<int>("--count");
rangeOption.AddValidator(result =>
{
    var value = result.GetValueForOption(rangeOption);
    if (value < 1 || value > 100)
    {
        result.ErrorMessage = "Count must be between 1 and 100";
    }
});
```

## Relationships & Integration

System.CommandLine integrates with the broader .NET ecosystem:

- **.NET CLI**: Powers the dotnet command-line interface
- **Global Tools**: Ideal foundation for .NET global and local tools
- **Dependency Injection**: Works with Microsoft.Extensions.DependencyInjection
- **Hosting**: Integrates with Microsoft.Extensions.Hosting for service-based apps
- **Native AOT**: Full compatibility with ahead-of-time compilation and trimming

Migration from other command-line libraries typically involves:

- Replacing CommandLineParser with System.CommandLine namespace
- Converting option definitions to new Option<T> syntax
- Updating handler methods to use SetHandler pattern
- Leveraging built-in validation instead of custom attributes

## Common Scenarios

### Simple Console Tool

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

### Multi-Command Application

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

### Complex Type Binding

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

## Alternative Syntax Options

### Handler Functions vs Lambda Expressions

```csharp
// Lambda expression approach
rootCommand.SetHandler((file, delay) =>
{
    ProcessFile(file, delay);
}, fileOption, delayOption);

// Method reference approach
rootCommand.SetHandler(ProcessFile, fileOption, delayOption);

// Class-based handler
rootCommand.SetHandler<FileProcessor>();
```

### Argument vs Option Patterns

```csharp
// Required positional argument
var fileArgument = new Argument<FileInfo>("file", "Input file");

// Optional named option
var fileOption = new Option<FileInfo?>("--file", "Input file");

// Required named option
var requiredOption = new Option<string>("--name", "Your name") { IsRequired = true };
```

### Response Files and Configuration

```csharp
// Enable response files
var parser = new CommandLineBuilder(rootCommand)
    .UseDefaults()  // Includes response file support
    .Build();

// Custom configuration
var parser = new CommandLineBuilder(rootCommand)
    .UseVersionOption()
    .UseHelp()
    .UseEnvironmentVariableDirective()
    .UseParseDirective()
    .UseSuggestDirective()
    .RegisterWithDotnetSuggest()
    .UseTypoCorrections()
    .UseParseErrorReporting()
    .CancelOnProcessTermination()
    .Build();
```

## Best Practices

### Command Design Patterns

- Use clear, descriptive command and option names following platform conventions
- Provide helpful descriptions for all commands, options, and arguments
- Group related functionality into subcommands rather than many options
- Use required options sparingly; prefer required arguments when possible

### Performance Optimization

- Minimize work in option validators; perform expensive validation in handlers
- Use async handlers for I/O-bound operations
- Consider lazy initialization for expensive resources
- Cache CommandLineBuilder instances when parsing multiple inputs

### Error Handling Guidance

- Let System.CommandLine handle parsing errors; focus on business logic errors
- Use custom validators for domain-specific validation rules
- Provide helpful error messages that suggest corrections
- Return appropriate exit codes (0 for success, non-zero for errors)

### Integration Recommendations

- Use Microsoft.Extensions.Hosting for long-running console applications
- Integrate with dependency injection for testable command handlers
- Consider configuration providers for complex settings management
- Use structured logging for better debugging and monitoring

## Limitations and Considerations

### Technical Constraints

- Cannot modify command structure after parser creation
- Limited support for dynamic command discovery at runtime
- No built-in support for interactive prompts or terminal manipulation
- Response files must exist at parse time; cannot be generated dynamically

### Performance Considerations

- Parser creation has overhead; cache when parsing multiple inputs
- Reflection-based binding has modest performance cost compared to direct handlers
- Large command hierarchies may impact startup time
- Validation runs before command execution; expensive validation affects parse time

### Common Pitfalls

- Forgetting to call SetHandler results in no-op commands
- Using wrong generic types on Option<T> causes runtime binding failures
- Not handling async methods properly in SetHandler
- Circular references in command hierarchies cause stack overflow
- Case sensitivity differences between platforms can affect option matching

## See Also

- Command-line design guidance: Best practices for CLI application design
- .NET Global Tools: Packaging and distribution of command-line tools
- Microsoft.Extensions.Hosting: Service-based console application patterns
- Native AOT: Deployment considerations for ahead-of-time compiled apps
- Tab completion: Shell integration for enhanced user experience