# System.CommandLine
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
