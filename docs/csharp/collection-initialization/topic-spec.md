# Collection Initialization - Topic Specification

## Feature Description

Collection initialization encompasses the traditional and modern approaches to creating and initializing collections in C#, including constructor-based initialization, target-typed constructors, and collection initializer syntax. This covers the foundational patterns for working with collections before the introduction of collection expressions, and represents the established, widely-compatible approaches to collection creation.

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/collection-initializers | rendered | Collection initializers programming guide | 2025-09-20 |
| https://docs.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/how-to-initialize-objects-by-using-an-object-initializer | rendered | Object and collection initialization | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/programming-guide/classes-and-structs/object-and-collection-initializers.md | Object and collection initializers guide | 2025-09-24 |
| dotnet/docs | docs/csharp/programming-guide/classes-and-structs/how-to-initialize-a-dictionary-with-a-collection-initializer.md | Dictionary initialization guide | 2025-09-24 |
| dotnet/docs | docs/csharp/language-reference/operators/new-operator.md | New operator reference | 2025-09-24 |
| dotnet/docs | docs/csharp/language-reference/builtin-types/arrays.md | Array initialization patterns | 2025-09-24 |
| dotnet/docs | docs/csharp/language-reference/builtin-types/collections.md | Collection types and initialization | 2025-09-24 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/csharplang/issues/100 | rendered | Target-typed new expressions proposal | 2025-09-20 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://devblogs.microsoft.com/dotnet/welcome-to-csharp-9-0/ | rendered | C# 9.0 target-typed new expressions | 2025-09-20 |
| https://docs.microsoft.com/dotnet/api/system.collections.generic.list-1 | rendered | List<T> class documentation | 2025-09-20 |
| https://docs.microsoft.com/dotnet/api/system.array | rendered | Array class documentation | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Collection Initialization |
| ID | collection-initialization |
| Category | C# Language |
| Namespace | (none) |
| Description | Traditional and modern approaches to creating and initializing collections using constructors, target-typed new expressions, and collection initializer syntax. |
| Complexity | 0.15 |
| Audience | All C# developers |
| Priority | 1 (Fundamental - essential syntax) |
| Version | 1.0 |
| Year | 2000 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Collection creation, Data structure population, Type instantiation |
| Conflicts with | None (foundational language feature) |
| Alternative to | Manual item-by-item addition, Factory patterns, Builder patterns |
| Prerequisite | Basic C# syntax, Generic types |
| Synergistic with | LINQ operations, Collection expressions, Object initialization |

## Keywords

| Keyword | Score |
|---------|-------|
| collection initialization | 4.58 |
| collection type | 4.54 |
| initialization patterns | 4.54 |
| 9.0 | 4.52 |
| collection initializer syntax | 4.52 |
| data management | 4.52 |
| dictionary initializers | 4.52 |
| performance considerations | 4.52 |
| target-typed new | 4.52 |
| target-typed new expressions | 4.52 |
| target-typed | 3.05 |
| approach | 3.03 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Add | method | 15 |
| AddRange | method | 5 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| CS0143 | The type '{0}' has no constructors defined |
| CS0144 | Cannot create an instance of the abstract type or interface '{0}' |
| CS0266 | Cannot implicitly convert type '{0}' to '{1}'. An explicit conversion exists (are you missing a cast?) |
| CS0029 | Cannot implicitly convert type '{0}' to '{1}' |
| CS0246 | The type or namespace name '{0}' could not be found |
| CS1729 | '{0}' does not contain a constructor that takes '{1}' arguments |
## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp/object-initialization | 0.8825 |
| csharp | csharp/collection-expressions | 0.8672 |
| csharp | csharp/csharp-14-features | 0.7800 |
| libraries | libraries/dotnet-10-library-improvements | 0.7191 |
| libraries | libraries | 0.6949 |
| libraries | libraries/system-text-json | 0.6831 |
| dotnet | dotnet | 0.6516 |
| cli | cli/assembly-trimming | 0.6366 |
| cli | cli/file-based-apps | 0.6257 |
| cli | cli | 0.5979 |
| cli | cli/build-and-compilation | 0.5934 |
| extensions | extensions/microsoft-extensions-ai | 0.5802 |

