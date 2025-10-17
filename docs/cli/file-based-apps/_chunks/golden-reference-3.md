# File-based Apps
## ASCII Art Generator with File-Based Apps

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
