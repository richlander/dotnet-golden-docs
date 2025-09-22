# C# 13 Features - Topic Specification

## Feature Description

C# 13 is the latest version of the C# programming language, released with .NET 9 in November 2024. It introduces significant enhancements to the params modifier with collection support, new lock object semantics, ref struct improvements, partial members expansion, and several syntax improvements that enhance developer productivity and performance.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/csharp/whats-new/csharp-13 | rendered | Official C# 13 features documentation | - |
| https://devblogs.microsoft.com/dotnet/announcing-dotnet-9/ | rendered | .NET 9 and C# 13 announcement | - |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/whats-new/csharp-13.md | C# 13 feature documentation | - |
| dotnet/csharplang | proposals/csharp-13.0/params-collections.md | Params collections proposal | - |
| dotnet/csharplang | proposals/csharp-13.0/lock-object.md | New lock object proposal | - |
| dotnet/csharplang | proposals/csharp-13.0/method-group-natural-type-improvements.md | Method group natural type improvements | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/csharplang/issues/140 | rendered | Field keyword feature discussion | - |

## Metadata

| Property | Value |
| --- | --- |
| Name | C# 13 Features |
| ID | csharp-13-features |
| Category | C# Language |
| Description | C# 13 introduces params collections, new lock semantics, ref struct improvements, partial properties, and enhanced syntax features for .NET 9. |
| Complexity | 0.7 |
| Audience | C# developers, Library authors, Performance-focused developers |
| Priority | 1 (Critical) |
| Version | 13.0 |
| Year | 2024 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Params collections with Span and IEnumerable, Enhanced ref struct usage, Improved lock performance, Partial properties and indexers |
| Prerequisite | .NET 9, Visual Studio 2022 17.8+ |
| Synergistic with | .NET 9 runtime improvements, System.Threading.Lock, Span and ReadOnlySpan |
| Alternative to | Manual collection handling, Monitor-based locking, Explicit backing fields |
| Conflicts with | Older C# language versions, .NET Framework |

## Keywords

- C# 13
- params collections
- lock object
- ref struct interfaces
- allows ref struct
- partial properties
- partial indexers
- field keyword
- escape sequence
- method group natural type
- implicit index access
- overload resolution priority
- .NET 9

## Key Features

### Core Language Enhancements

- **Params Collections**: Extend params modifier beyond arrays to collections like Span, IEnumerable
- **New Lock Object**: System.Threading.Lock for improved synchronization performance
- **Ref Struct Interfaces**: Allow ref struct types to implement interfaces with safety constraints
- **Allows Ref Struct**: Generic constraint to permit ref struct type arguments
- **Partial Properties**: Support for partial properties and indexers in partial types

### Syntax Improvements

- **Field Keyword**: Preview feature for accessing compiler-synthesized backing fields
- **Escape Sequence**: New \\e escape sequence for ESCAPE character
- **Implicit Index Access**: Support for ^ operator in object initializers
- **Method Group Natural Type**: Improved overload resolution for method groups
- **Overload Resolution Priority**: Attribute to guide compiler overload selection

### Safety and Performance Features

- **Ref and Unsafe in Async**: Allow ref locals and unsafe contexts in iterators and async methods
- **Enhanced Ref Safety**: Improved compiler analysis for ref struct usage patterns
- **Performance Optimizations**: Better code generation for collections and lock scenarios

## Common Use Cases

- High-performance collection operations with params Span parameters
- Thread-safe code with improved Lock semantics
- Generic algorithms that work with ref struct types
- Library design with overload resolution priority guidance
- Property implementations with field keyword for cleaner syntax