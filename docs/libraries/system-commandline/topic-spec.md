# System.CommandLine - Topic Specification

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

- System.CommandLine
- command-line parsing
- CLI applications
- argument parsing
- option parsing
- tab completion
- command-line interface
- console applications
- .NET CLI tools
- POSIX conventions
- response files
- command directives
- option bundling
- argument arity

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
