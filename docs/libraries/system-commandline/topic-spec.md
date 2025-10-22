# System.CommandLine

## Feature Description

System.CommandLine is a command-line parsing library for .NET that provides functionality commonly needed by command-line apps, such as parsing command-line input and displaying help text. It offers strongly-typed argument and option parsing, automatic help generation, tab completion, response files, and built-in validation according to POSIX or Windows conventions.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/commandline/index.md | System.CommandLine overview documentation | - |
| dotnet/docs | docs/standard/commandline/syntax.md | Command-line syntax overview | - |
| dotnet/docs | docs/standard/commandline/get-started-tutorial.md | Getting started tutorial | - |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://www.nuget.org/packages/System.CommandLine | rendered | Official NuGet package page | - |
| https://learn.microsoft.com/dotnet/standard/commandline/ | rendered | Official Microsoft Learn documentation | - |
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

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 4477352130680084748 |
| overview | simhash | 12991077554706678586 |
| technical | simhash | 17603784469680882044 |

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
| command-line | 6.00 |
| system.commandline | 4.00 |
| parsing | 7.00 |
| response files | 3.00 |
| binding | 4.00 |
| commandline | 4.00 |
| help | 4.00 |
| hierarchies | 4.00 |
| option | 4.00 |
| model binding | 2.00 |
| arguments | 3.00 |
| commands | 3.00 |

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
| libraries | libraries/system-text-json | 0.7253 |
| cli | cli/file-based-apps | 0.7239 |
| libraries | libraries/system-text-json-jsonserializer | 0.7107 |
| dotnet | dotnet | 0.7004 |
| csharp | csharp | 0.6995 |
| csharp | csharp/csharp-14-features | 0.6990 |
| libraries | libraries | 0.6963 |
| libraries | libraries/dotnet-10-library-improvements | 0.6932 |
| libraries | libraries/system-text-json-dotnet-10 | 0.6925 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.6901 |
| libraries | libraries/system-threading-tasks-task | 0.6846 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| cli | command-line | 1.600 |
| cli | commands | 1.300 |

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

## Chunks

**Source**: `golden-reference.md`
**Count**: 4
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.569 |
| 1 | Advanced Validation | 0.569 | 1.000 |
| 2 | Complex Type Binding | 0.569 | 0.701 |
| 3 | Error Handling Guidance | 0.600 | 0.670 |
