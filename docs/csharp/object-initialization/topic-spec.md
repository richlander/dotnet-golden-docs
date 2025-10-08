# Object Initialization - Topic Specification

## Feature Description

Object initialization encompasses the various approaches for creating and initializing objects and their properties in C#, including constructor-based initialization, object initializer syntax, collection initializers within objects, anonymous types, init-only properties, and required members. This covers both object creation patterns and the initialization of collections as properties of those objects.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/object-and-collection-initializers | rendered | Object and collection initializers guide | 2025-09-20 |
| https://docs.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/how-to-initialize-objects-by-using-an-object-initializer | rendered | Object initialization patterns | 2025-09-20 |
| https://docs.microsoft.com/dotnet/csharp/language-reference/keywords/init | rendered | Init-only properties | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/programming-guide/classes-and-structs/object-and-collection-initializers.md | Object and collection initializers guide | 2025-09-24 |
| dotnet/docs | docs/csharp/programming-guide/classes-and-structs/how-to-initialize-objects-by-using-an-object-initializer.md | Object initialization how-to guide | 2025-09-24 |
| dotnet/docs | docs/csharp/language-reference/keywords/init.md | Init-only properties reference | 2025-09-24 |
| dotnet/docs | docs/csharp/language-reference/keywords/required.md | Required members reference | 2025-09-24 |
| dotnet/docs | docs/csharp/fundamentals/types/anonymous-types.md | Anonymous types guide | 2025-09-24 |
| dotnet/docs | docs/csharp/language-reference/builtin-types/record.md | Record types and initialization | 2025-09-24 |
| dotnet/docs | docs/csharp/language-reference/operators/new-operator.md | New operator and object creation | 2025-09-24 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/csharplang/issues/3630 | rendered | Init-only properties proposal | 2025-09-20 |
| https://github.com/dotnet/csharplang/issues/3793 | rendered | Required members proposal | 2025-09-20 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://devblogs.microsoft.com/dotnet/welcome-to-csharp-9-0/ | rendered | C# 9.0 init-only properties | 2025-09-20 |
| https://devblogs.microsoft.com/dotnet/early-peek-at-csharp-11-features/ | rendered | C# 11 required members | 2025-09-20 |
| https://docs.microsoft.com/dotnet/csharp/fundamentals/types/anonymous-types | rendered | Anonymous types documentation | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Object Initialization |
| ID | object-initialization |
| Category | C# Language |
| Namespace | (none) |
| Description | Comprehensive approaches for creating and initializing objects, properties, and collections within objects using various syntax patterns and modern language features. |
| Complexity | 0.20 |
| Audience | All C# developers |
| Priority | 1 (Fundamental - essential syntax) |
| Version | 1.0 |
| Year | 2000 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 7058325005360841626 |
| overview | simhash | 17751804552900313392 |
| technical | simhash | 17603925754777575800 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Object creation, Property initialization, Immutable object patterns, Anonymous data structures |
| Conflicts with | None (foundational language feature) |
| Alternative to | Constructor overloading, Builder patterns, Factory methods |
| Prerequisite | Basic C# syntax, Properties, Constructors |
| Synergistic with | Collection initialization, LINQ projections, Data transfer objects |

## Keywords

| Keyword | Score |
|---------|-------|
| object initialization | 9.00 |
| anonymous types | 8.00 |
| collection properties | 8.00 |
| init properties | 6.00 |
| required members | 5.00 |
| objects | 8.00 |
| constructor | 7.00 |
| initialization | 7.00 |
| initializers | 7.00 |
| properties | 7.00 |
| collection expressions | 5.00 |
| init-only properties | 3.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Person | method | 6 |
| PersonOld | method | 3 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| CS0200 | Property or indexer '{0}' cannot be assigned to -- it is read only |
| CS0272 | The property or indexer '{0}' cannot be used in this context because the set accessor is inaccessible |
| CS0747 | Invalid initializer member declarator |
| CS9035 | Required member '{0}' must be set in the object initializer or attribute constructor |
| CS8868 | A switch expression or with expression does not handle some possible values (it is not exhaustive) |
| CS0266 | Cannot implicitly convert type '{0}' to '{1}'. An explicit conversion exists (are you missing a cast?) |
## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp/collection-initialization | 0.8118 |
| csharp | csharp/csharp-14-features | 0.7591 |
| csharp | csharp/collection-expressions | 0.7142 |
| libraries | libraries/dotnet-10-library-improvements | 0.6824 |
| libraries | libraries/system-text-json | 0.6575 |
| libraries | libraries/string-search-operations | 0.6522 |
| libraries | libraries/system-buffers-searchvalues | 0.6416 |
| dotnet | dotnet | 0.6188 |
| cli | cli/file-based-apps | 0.5879 |
| cli | cli/assembly-trimming | 0.5856 |
| cli | cli/build-and-compilation | 0.5832 |
| cli | cli | 0.5822 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| csharp/collection-expressions | collection expressions | 1.375 |
| csharp/collection-initialization | collection expressions | 1.375 |

