# String Search

## Feature Description

String search operations provide a comprehensive set of methods for locating substrings, characters, and patterns within text. These operations include Contains, IndexOf, LastIndexOf, StartsWith, EndsWith, and IndexOfAny, offering solutions ranging from simple existence checks to position-based extraction with both ordinal and culture-aware comparison modes.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/api/system.string | rendered | Official String class API documentation | - |
| https://learn.microsoft.com/dotnet/standard/base-types/best-practices-strings | rendered | Best practices for using strings in .NET | - |
| https://learn.microsoft.com/dotnet/standard/base-types/string-comparison-net-5-plus | rendered | String comparison behavior changes | - |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/standard/base-types/string-comparison-net-5-plus.md | String comparison behavior and best practices | - |
| dotnet/docs | docs/fundamentals/code-analysis/quality-rules/ca2249.md | CA2249: Use String.Contains instead of String.IndexOf | - |
| dotnet/docs | docs/fundamentals/code-analysis/quality-rules/ca1307.md | CA1307: Specify StringComparison for clarity | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/api/system.stringcomparison | rendered | StringComparison enumeration documentation | - |

## Metadata

| Property | Value |
| --- | --- |
| Name | String Search Operations |
| ID | string-search-operations |
| Category | Libraries |
| Namespace | System |
| Description | Comprehensive set of methods for locating and checking text within strings, including Contains, IndexOf, StartsWith, EndsWith, and IndexOfAny with ordinal and culture-aware comparison support. |
| Complexity | 0.4 |
| Audience | All .NET developers, beginners to advanced |
| Priority | 1 (Critical) |
| Version | 1.0 (base methods), continuous enhancements |
| Year | 2002 (initial), ongoing |

## Relationships

| Type | Target |
| --- | --- |
| Optimized by | SearchValues<T> for repeated multi-character searches |
| Alternative to | Regular expressions for simple pattern matching |
| Controlled by | StringComparison enumeration |
| Related to | String.Split, String.Replace, Span<char> operations |
| Validated by | Code analyzers CA1307, CA1309, CA1310, CA2249 |
| Prerequisite | Understanding of ordinal vs culture-aware comparison |

## Keywords

| Keyword | Score |
|---------|-------|
| string search operations | 9.36 |
| multi-value | 9.33 |
| string.contains | 9.33 |
| allocation-free | 7.40 |
| pattern-based | 7.31 |
| string | 6.46 |
| contains | 6.30 |
| indexof | 6.30 |
| repeated | 6.28 |
| regular | 6.24 |
| searchvalues | 5.18 |
| searches | 5.04 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| libraries | libraries/system-buffers-searchvalues | 0.7956 |
| libraries | libraries/dotnet-10-library-improvements | 0.7306 |
| csharp | csharp/csharp-14-features | 0.7160 |
| csharp | csharp/collection-expressions | 0.7014 |
| csharp | csharp | 0.6922 |
| libraries | libraries/system-text-json | 0.6651 |
| libraries | libraries | 0.6619 |
| dotnet | dotnet | 0.6550 |
| cli | cli/file-based-apps | 0.6012 |
| cli | cli/assembly-trimming | 0.5782 |
| cli | cli | 0.5744 |
| extensions | extensions/microsoft-extensions-ai-evaluation | 0.5720 |

## APIs

| API | Type | Count |
|-----|------|-------|
| IndexOf | method | 24 |
| Contains | method | 11 |
| AsSpan | method | 9 |
| IndexOfAny | method | 9 |
| SearchValues.Create | method | 8 |
| LastIndexOf | method | 6 |
| Substring | method | 5 |
| ContainsAny | method | 3 |
| Math.Min | method | 3 |
| StartsWith | method | 3 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| libraries | string.contains | 2.234 |
| libraries | string.indexof | 2.156 |
| libraries | stringcomparison | 1.845 |
| libraries | ordinal comparison | 1.623 |

## Code Analysis Rules

| Rule | Title | Severity |
| --- | --- | --- |
| CA2249 | Consider using String.Contains instead of String.IndexOf | Suggestion |
| CA1307 | Specify StringComparison for clarity | Warning |
| CA1309 | Use ordinal StringComparison | Warning |
| CA1310 | Specify StringComparison for correctness | Warning |

## Common Gotchas

| Issue | Description | Resolution |
| --- | --- | --- |
| Culture dependency | String overloads of IndexOf use CurrentCulture by default | Always specify StringComparison for strings |
| Character vs string behavior | Char overloads always use ordinal, string overloads may not | Understand default behavior or always specify comparison |
| Empty string search | IndexOf("") returns 0, not -1 | Check for empty strings before searching if needed |
| Unicode normalization | Composed vs decomposed characters may not match | Use culture-aware comparison or normalize strings first |
| Return value -1 | Indicates not found, using as index will throw | Always check for >= 0 before using result |
