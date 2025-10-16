# Partial Classes - Topic Specification

## Feature Description

Partial classes split the definition of a type (class, struct, or interface) and its members across multiple source files. This enables separation between generated code and developer-written code, platform-specific implementations, and source generator integration. Partial types can contain partial members where the signature is declared in one file and the implementation in another.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/programming-guide/classes-and-structs/partial-classes-and-methods.md | Partial classes and methods guide | - |
| dotnet/docs | docs/csharp/language-reference/keywords/partial-type.md | Partial type keyword reference | - |
| dotnet/docs | docs/csharp/language-reference/keywords/partial-member.md | Partial member keyword reference | - |
| dotnet/docs | docs/csharp/whats-new/csharp-13.md | C# 13 partial properties and indexers | - |
| dotnet/docs | docs/csharp/whats-new/csharp-14.md | C# 14 partial events and constructors | - |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/partial-classes-and-methods | rendered | Official partial classes documentation | - |
| https://github.com/dotnet/csharplang/blob/main/proposals/csharp-13.0/partial-properties.md | rendered | Partial properties proposal | - |
| https://github.com/dotnet/csharplang/blob/main/proposals/csharp-14.0/partial-events-and-constructors.md | rendered | Partial events and constructors proposal | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/csharp/roslyn-sdk/source-generators-overview | rendered | Source generators overview | - |
| https://learn.microsoft.com/dotnet/standard/base-types/regular-expression-source-generators | rendered | Regex source generator example | - |

## Metadata

| Property | Value |
| --- | --- |
| Name | Partial Classes |
| ID | partial-classes |
| Category | C# Language |
| Namespace | (none) |
| Description | Partial classes split type and member definitions across multiple source files for code generation, platform-specific implementations, and source generator integration. |
| Complexity | 0.35 |
| Audience | C# developers, Library authors, Source generator users |
| Priority | 2 (Common usage - code generation scenarios) |
| Version | Multiple (2.0 for partial types, 13.0+ for all partial members) |
| Year | 2024 |
