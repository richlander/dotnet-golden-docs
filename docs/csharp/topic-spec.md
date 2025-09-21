# C# Language - Topic Specification

## Feature Description

C# is a modern, safe, and general purpose language that makes developers productive while writing high-performance code. The C# language is the most popular language for the .NET platform, a free, cross-platform, open source development environment.

## Keywords

- C# language
- programming language
- object-oriented
- type-safe
- .NET language
- modern syntax

## Metadata

| Property | Value |
| --- | --- |
| Name | C# Language |
| ID | csharp |
| Category | C# Language |
| Description | C# is a modern, safe, and general purpose language that makes developers productive while writing high-performance code. |
| Complexity | 0.8 |
| Audience | all developers |
| Priority | 1 (Critical - core .NET programming language) |
| Version | 1.0 |
| Year | 2000 |

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/ | rendered | Main official C# documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-net-framework-4-6/ | rendered | C# 6 release announcement with .NET Framework 4.6 | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/whats-new-in-csharp-7-0/ | rendered | C# 7.0 release announcement | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/new-features-in-c-7-0/ | rendered | C# 7.0 new features announcement | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/building-c-8-0/ | rendered | C# 8.0 release announcement | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/welcome-to-c-9-0/ | rendered | C# 9.0 release announcement | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/welcome-to-csharp-10/ | rendered | C# 10 release announcement | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/welcome-to-csharp-11/ | rendered | C# 11 release announcement | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-csharp-12/ | rendered | C# 12 release announcement | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/index.yml | C# documentation index | - |
| dotnet/csharplang | README.md | C# language design repository | - |
| dotnet/roslyn | docs/Language Feature Status.md | Feature status tracking | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/roslyn | rendered | C# compiler implementation | 2025-09-20 |

## Source Discovery Workflow

For finding authoritative C# language feature content:

1. Language Feature Status: Check `docs/Language Feature Status.md` (dotnet/roslyn repo) for GitHub issue links
2. GitHub Proposals: Follow issue links to find detailed language proposals in dotnet/csharplang repo
3. Official Documentation: Look in `docs/csharp/language-reference/` (dotnet/docs repo) for language reference content
4. What's New: Check `docs/csharp/whats-new/csharp-X.md` (dotnet/docs repo) for feature announcements and examples
5. Raw Sources: Prefer raw.githubusercontent.com URLs for LLM-friendly markdown content

### Collection Expressions Sources (Example)

First, look for features in the repos.

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/language-reference/operators/collection-expressions.md | Language reference documentation | - |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 feature announcement section | - |
| dotnet/roslyn | docs/Language Feature Status.md | Feature status tracking | - |

Here's a GitHub issue discovered in "docs/Language Feature Status.md".

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/csharplang/issues/5354 | rendered | GitHub language proposal and discussion | 2025-09-20 |

That issue has links to many documents, such as https://github.com/dotnet/csharplang/blob/main/proposals/collection-expressions.md. This link 404s. The team appears to have moved to versioned links, such as: https://github.com/dotnet/csharplang/blob/main/proposals/csharp-12.0/collection-expressions.md. This link can be translated to a raw link for more efficient consumption: https://raw.githubusercontent.com/dotnet/csharplang/refs/heads/main/proposals/csharp-12.0/collection-expressions.md.

## Generation Hints

| Property | Value |
| --- | --- |
| Emphasize | Language syntax clarity, Developer productivity improvements, Performance improvements and characteristics, Migration patterns from older syntax |
| Avoid | Compiler implementation, Complex edge cases, Advanced generic scenarios |
| Cross-reference discover from | Related language features, Syntax alternatives, Prerequisite concepts |
| Cross-reference surface to | Complementary features, Common usage patterns, Framework integrations |
