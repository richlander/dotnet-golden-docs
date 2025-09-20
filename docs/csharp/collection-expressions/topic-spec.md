# Collection Expressions - Topic Specification

## Feature Description

Collection expressions provide a concise syntax to create common collection values using square bracket notation. This feature combines collection expressions (introduced in C# 12) and params collection expressions (introduced in C# 13) to offer a unified, simplified approach to collection initialization and manipulation, replacing more verbose traditional syntax.

## Relationships

| Type | Target |
| --- | --- |
| Enables | Simplified collection initialization, Cleaner method parameter passing, Spread operations |
| Conflicts with | None (additive language feature) |
| Alternative to | Traditional array initialization, Collection initializer syntax, Manual collection construction |
| Prerequisite | C# 12+ for basic expressions, C# 13+ for params collections |
| Synergistic with | LINQ operations, Span/ReadOnlySpan usage, Collection interfaces |

## Metadata

| Property | Value |
| --- | --- |
| Name | Collection Expressions |
| ID | collection-expressions |
| Category | C# Language |
| Description | Collection expressions provide a concise syntax to create common collection values using square bracket notation, including basic expressions and params collection support. |
| Complexity | 0.6 |
| Audience | All C# developers |
| Priority | 2 (Common usage - modern syntax improvement) |
| Version | 12.0 |
| Year | 2023 |

## Keywords

- collection expressions
- params collection expressions
- collection initializers
- array syntax
- list initialization
- spread operator
- square bracket notation

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/language-reference/operators/collection-expressions | rendered | Main collection expressions documentation | - |
| https://devblogs.microsoft.com/dotnet/announcing-csharp-12/ | rendered | C# 12 announcement with collection expressions | - |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/language-reference/operators/collection-expressions.md | Collection expressions language reference | - |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 what's new documentation | - |
| dotnet/docs | docs/csharp/whats-new/csharp-13.md | C# 13 what's new documentation | - |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/csharplang/issues/5354 | rendered | Collection expressions language proposal | - |
| https://github.com/dotnet/csharplang/issues/7700 | rendered | Params collections language proposal | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://devblogs.microsoft.com/dotnet/refactor-your-code-with-collection-expressions/ | rendered | Refactoring guide and patterns | - |
| https://devblogs.microsoft.com/dotnet/csharp13-calling-methods-is-easier-and-faster/ | rendered | C# 13 params collections | - |
| https://devblogs.microsoft.com/dotnet/announcing-csharp-12/ | rendered | C# 12 announcement with collection expressions | - |
| https://github.com/dotnet/roslyn | rendered | Compiler implementation | - |
