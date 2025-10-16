# Collection Initialization - Topic Specification

## Feature Description

Collection initialization encompasses the traditional and modern approaches to creating and initializing collections in C#, including constructor-based initialization, target-typed constructors, and collection initializer syntax. This covers the foundational patterns for working with collections before the introduction of collection expressions, and represents the established, widely-compatible approaches to collection creation.

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
| https://docs.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/collection-initializers | rendered | Collection initializers programming guide | 2025-09-20 |
| https://docs.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/how-to-initialize-objects-by-using-an-object-initializer | rendered | Object and collection initialization | 2025-09-20 |
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

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 13507085838896505194 |
| overview | simhash | 13135758833430233394 |
| technical | simhash | 17604488704731014524 |

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
| collection expressions | 12.00 |
| collection initialization | 6.00 |
| syntax | 8.00 |
| target-typed new | 3.00 |
| collection types | 3.00 |
| collection initializer syntax | 2.00 |
| values | 6.00 |
| collections | 4.00 |
| capacity | 3.00 |
| dictionaries | 3.00 |
| dictionary | 3.00 |
| elements | 3.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Add | method | 5 |
| Where | method | 4 |

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
| csharp | csharp/collection-expressions | 0.8797 |
| csharp | csharp/object-initialization | 0.8118 |
| csharp | csharp/csharp-14-features | 0.7180 |
| libraries | libraries/system-buffers-searchvalues | 0.6978 |
| libraries | libraries/dotnet-10-library-improvements | 0.6777 |
| libraries | libraries/string-search-operations | 0.6635 |
| libraries | libraries/system-text-json-nodes | 0.6523 |
| libraries | libraries/system-text-json-jsonserializer | 0.6426 |
| libraries | libraries | 0.6305 |
| libraries | libraries/system-text-json | 0.6231 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.6188 |
| libraries | libraries/system-text-json-jsondocument | 0.6115 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| csharp/collection-expressions | collection types | 1.356 |
| csharp/collection-expressions | collection expressions | 1.333 |
| csharp/object-initialization | collection expressions | 1.333 |

