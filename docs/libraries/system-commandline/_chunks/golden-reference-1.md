# System.CommandLine
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
