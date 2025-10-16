# Collection Expressions - Topic Specification

## Feature Description

Collection expressions provide a concise syntax to create common collection values using square bracket notation. This feature combines collection expressions (introduced in C# 12) and params collection expressions (introduced in C# 13) to offer a unified, simplified approach to collection initialization and manipulation, replacing more verbose traditional syntax.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/language-reference/operators/collection-expressions.md | Collection expressions language reference | 0249c38f27 |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 what's new documentation | 0249c38f27 |
| dotnet/docs | docs/csharp/whats-new/csharp-13.md | C# 13 what's new documentation | 0249c38f27 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/language-reference/operators/collection-expressions | rendered | Main collection expressions documentation | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-csharp-12/ | rendered | C# 12 announcement with collection expressions | 2025-09-20 |
| https://github.com/dotnet/csharplang/issues/5354 | rendered | Collection expressions language proposal | 2025-09-20 |
| https://github.com/dotnet/csharplang/issues/7700 | rendered | Params collections language proposal | 2025-09-20 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://devblogs.microsoft.com/dotnet/refactor-your-code-with-collection-expressions/ | rendered | Refactoring guide and patterns | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/csharp13-calling-methods-is-easier-and-faster/ | rendered | C# 13 params collections | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/announcing-csharp-12/ | rendered | C# 12 announcement with collection expressions | 2025-09-20 |
| https://github.com/dotnet/roslyn | rendered | Compiler implementation | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Collection Expressions |
| ID | collection-expressions |
| Category | C# Language |
| Namespace | (none) |
| Description | Collection expressions provide a concise syntax to create common collection values using square bracket notation, including basic expressions and params collection support. |
| Complexity | 0.25 |
| Audience | All C# developers |
| Priority | 2 (Common usage - modern syntax improvement) |
| Version | 12.0 |
| Year | 2023 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 455161043282583691 |
| overview | simhash | 12992804884252795250 |
| technical | simhash | 12997308484954235260 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Simplified collection initialization, Cleaner method parameter passing, Spread operations |
| Conflicts with | None (additive language feature) |
| Alternative to | Traditional array initialization, Collection initializer syntax, Manual collection construction |
| Prerequisite | C# 12+ for basic expressions, C# 13+ for params collections |
| Synergistic with | LINQ operations, Span/ReadOnlySpan usage, Collection interfaces |

## Keywords

| Keyword | Score |
|---------|-------|
| collection expressions | 16.00 |
| syntax | 10.00 |
| collection types | 4.00 |
| target type | 4.00 |
| spread | 5.00 |
| familiar | 4.00 |
| spread element | 2.00 |
| using collection expressions | 2.00 |
| compile-time constants | 2.00 |
| inline arrays | 2.00 |
| collections | 4.00 |
| combine | 3.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| ProcessItems | method | 4 |
| PrintNumbers | method | 3 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| CS9176 | There is no target type for the collection expression. |
| CS9174 | Cannot initialize type '{0}' with a collection expression because the type is not constructible. |
| CS9188 | '{0}' has a CollectionBuilderAttribute but no element type. |
| CS9187 | Could not find an accessible '{0}' method with the expected signature: a static method with a single parameter of type 'ReadOnlySpan<{1}>' and return type '{2}'. |
| CS9185 | The CollectionBuilderAttribute builder type must be a non-generic class or struct. |
| CS9186 | The CollectionBuilderAttribute method name is invalid. |
| CS9175 | An expression tree may not contain a collection expression. |
## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp/collection-initialization | 0.8797 |
| csharp | csharp/csharp-14-features | 0.7522 |
| csharp | csharp | 0.7324 |
| libraries | libraries/string-search-operations | 0.7014 |
| libraries | libraries/dotnet-10-library-improvements | 0.6799 |
| libraries | libraries/system-buffers-searchvalues | 0.6790 |
| libraries | libraries/system-text-json-jsonserializer | 0.6492 |
| libraries | libraries/system-text-json-nodes | 0.6356 |
| libraries | libraries/system-text-json | 0.6322 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.6305 |
| libraries | libraries/system-commandline | 0.6209 |
| libraries | libraries | 0.6080 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| csharp/collection-initialization | collection expressions | 1.375 |
| csharp/collection-initialization | collection types | 1.356 |

