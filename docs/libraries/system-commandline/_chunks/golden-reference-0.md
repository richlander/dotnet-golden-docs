# System.CommandLine

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
