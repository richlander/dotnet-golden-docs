# C# Language - Topic Specification

## Feature Description

C# is a modern, safe, and general purpose language that makes developers productive while writing high-performance code. The C# language is the most popular language for the .NET platform, a free, cross-platform, open source development environment.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/index.yml | C# documentation index | 0249c38f27 |
| dotnet/csharplang | README.md | C# language design repository | 86c78a07 |
| dotnet/roslyn | docs/Language Feature Status.md | Feature status tracking | a4d213a6997 |

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

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/roslyn | rendered | C# compiler implementation | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | C# Language |
| ID | csharp |
| Category | C# Language |
| Namespace | (none) |
| Description | C# is a modern, safe, and general purpose language that makes developers productive while writing high-performance code. |
| Complexity | 0.8 |
| Audience | all developers |
| Priority | 1 (Critical - core .NET programming language) |
| Version | 1.0 |
| Year | 2000 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 13140259840106365750 |
| technical | simhash | 12995581704090288436 |

## Relationships

| Type | Target |
| --- | --- |

## Keywords

| Keyword | Score |
|---------|-------|
| language | 19.00 |
| features | 11.00 |
| libraries | 9.00 |
| like | 11.00 |
| programming | 8.00 |
| object-oriented | 5.00 |
| memory management | 6.00 |
| cross-platform | 5.00 |
| applications | 6.00 |
| enables | 6.00 |
| low-level | 4.00 |
| while | 6.00 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp/csharp-14-features | 0.8373 |
| dotnet | dotnet | 0.7851 |
| csharp | csharp/lambda-expressions | 0.7522 |
| libraries | libraries/dotnet-10-library-improvements | 0.7352 |
| csharp | csharp/collection-expressions | 0.7324 |
| csharp | csharp/async-await | 0.7305 |
| libraries | libraries/system-collections-generic-ienumerable | 0.7222 |
| csharp | csharp/object-initialization | 0.7142 |
| csharp | csharp/properties-backing-fields | 0.7118 |
| libraries | libraries/system-text-json-jsonserializer | 0.7075 |
| libraries | libraries/system-threading-tasks-task | 0.7073 |
| libraries | libraries | 0.7046 |

### Similarity Metadata

| Category | Threshold | Percentile | Total Pairs |
|----------|-----------|------------|-------------|
| cli | 0.6385 | P50 | 6 |
| csharp | 0.7118 | P70 | 8 |
| dotnet | 0.7851 | P50 | 1 |
| extensions | 0.5845 | P50 | 3 |
| libraries | 0.6614 | P70 | 21 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| dotnet | low-level | 1.356 |
| dotnet | object-oriented | 1.356 |

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
| dotnet/docs | docs/csharp/language-reference/operators/collection-expressions.md | Language reference documentation | 0249c38f27 |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 feature announcement section | 0249c38f27 |
| dotnet/roslyn | docs/Language Feature Status.md | Feature status tracking | a4d213a6997 |

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

## Chunks

**Source**: `golden-reference.md`
**Count**: 6
**Baseline (Conceptual)**: 0

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | - |
| 1 | Type System and Object Orientation | 0.654 | - |
| 2 | Asynchronous Programming | 0.616 | - |
| 3 | .NET Ecosystem Integration | 0.609 | - |
| 4 | Learning Curve | 0.606 | - |
| 5 | Core Language Concepts | 0.674 | - |
