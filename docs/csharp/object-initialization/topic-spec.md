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
| anonymous types | 4.58 |
| object initialization | 4.58 |
| init properties | 4.54 |
| required members | 4.54 |
| anti-patterns | 4.52 |
| collection initialization within | 4.52 |
| init-only properties | 4.52 |
| initialization within objects | 4.52 |
| object initializer syntax | 4.52 |
| properties | 3.06 |
| constructor | 3.04 |
| object | 3.04 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| CS0200 | Property or indexer '{0}' cannot be assigned to -- it is read only |
| CS0272 | The property or indexer '{0}' cannot be used in this context because the set accessor is inaccessible |
| CS0747 | Invalid initializer member declarator |
| CS9035 | Required member '{0}' must be set in the object initializer or attribute constructor |
| CS8868 | A switch expression or with expression does not handle some possible values (it is not exhaustive) |
| CS0266 | Cannot implicitly convert type '{0}' to '{1}'. An explicit conversion exists (are you missing a cast?) |
