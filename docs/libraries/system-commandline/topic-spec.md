# System.CommandLine

## Feature Description

System.CommandLine is a command-line parsing library for .NET that provides functionality commonly needed by command-line apps, such as parsing command-line input and displaying help text. It offers strongly-typed argument and option parsing, automatic help generation, tab completion, response files, and built-in validation according to POSIX or Windows conventions.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://www.nuget.org/packages/System.CommandLine | rendered | Official NuGet package page | - |
| https://learn.microsoft.com/dotnet/standard/commandline/ | rendered | Official Microsoft Learn documentation | - |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/commandline/index.md | System.CommandLine overview documentation | - |
| dotnet/docs | docs/standard/commandline/syntax.md | Command-line syntax overview | - |
| dotnet/docs | docs/standard/commandline/get-started-tutorial.md | Getting started tutorial | - |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/command-line-api | rendered | Official repository for System.CommandLine | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |

## Metadata

| Property | Value |
| --- | --- |
| Name | System.CommandLine |
| ID | system-commandline |
| Category | Libraries |
| Namespace | System.CommandLine |
| Description | Command-line parsing library for .NET that provides strongly-typed argument and option parsing, automatic help generation, and tab completion. |
| Complexity | 0.6 |
| Audience | CLI application developers, tool builders, console application developers |
| Priority | 2 (Important) |
| Version | 2.0 |
| Year | 2022 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Strongly-typed CLI applications, Automatic help generation, Tab completion support, Response files, Native AOT compatibility |
| Alternative to | CommandLineParser, McMaster.Extensions.CommandLineUtils, manual argument parsing |
| Prerequisite | NuGet package: System.CommandLine |
| Synergistic with | Microsoft.Extensions.Hosting, Microsoft.Extensions.DependencyInjection, .NET trimming and AOT |
| Powers | .NET CLI, dotnet global tools, dotnet local tools |

## Keywords

| Keyword | Score |
|---------|-------|
| system.commandline | 4.73 |
| response files | 4.68 |
| best practices | 4.67 |
| model binding | 4.67 |
| service-based | 4.67 |
| command-line | 3.26 |
| parsing | 3.18 |
| option | 3.16 |
| validation | 3.16 |
| commandline | 3.15 |
| binding | 3.13 |
| completion | 3.13 |

## APIs

| API | Type | Count |
|-----|------|-------|
| AddOption | method | 13 |
| SetHandler | method | 6 |
| AddArgument | method | 5 |
| Command | method | 5 |
| RootCommand | method | 5 |
| AddCommand | method | 4 |
| ProcessFile | method | 3 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| cli | cli | 0.7970 |
| cli | cli/file-based-apps | 0.7239 |
| libraries | libraries/system-text-json | 0.7216 |
| dotnet | dotnet | 0.7004 |
| csharp | csharp | 0.6995 |
| csharp | csharp/csharp-14-features | 0.6990 |
| libraries | libraries | 0.6963 |
| libraries | libraries/dotnet-10-library-improvements | 0.6932 |
| libraries | libraries/system-text-json-source-generation | 0.6746 |
| cli | cli/native-aot | 0.6697 |
| cli | cli/build-and-compilation | 0.6689 |
| csharp | csharp/object-initialization | 0.6333 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| cli | command-line | 1.312 |

## Common Parse Error Messages

System.CommandLine produces runtime parse error messages (not compile-time diagnostic codes) when command-line input cannot be parsed:

| Error Message | Description |
| --- | --- |
| Required argument missing for command: '{0}'. | A required argument was not provided for the specified command |
| Required argument missing for option: '{0}'. | A required argument was not provided for the specified option |
| Option '{0}' is required. | A required option was not specified on the command line |
| Unrecognized command or argument '{0}'. | Input token was not recognized as a valid command or argument |
| Argument '{0}' not recognized. Must be one of:{1} | Argument value is not in the allowed set of values |
| Cannot parse argument '{0}' as expected type '{1}'. | Argument value cannot be converted to the expected data type |
| Cannot parse argument '{0}' for option '{1}' as expected type '{2}'. | Option argument cannot be converted to the expected data type |
| Option '{0}' expects a single argument but {1} were provided. | Multiple arguments provided for an option that expects only one |
| File does not exist: '{0}'. | Specified file path does not exist (when using file validation) |
| Directory does not exist: '{0}'. | Specified directory path does not exist (when using directory validation) |
| Response file not found '{0}'. | Referenced response file (@file) could not be located |
