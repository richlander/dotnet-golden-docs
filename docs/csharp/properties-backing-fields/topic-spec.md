# Properties and Backing Fields - Topic Specification

## Feature Description

Properties provide a flexible mechanism to read, write, or compute values using accessor methods while appearing as public data members. The compiler can auto-generate backing fields, or developers can use the `field` keyword to access compiler-synthesized backing fields for custom logic. Properties support auto-implementation, init-only accessors, required initialization, read-only patterns, and computed values.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/programming-guide/classes-and-structs/properties.md | Properties programming guide | - |
| dotnet/docs | docs/csharp/programming-guide/classes-and-structs/auto-implemented-properties.md | Auto-implemented properties guide | - |
| dotnet/docs | docs/csharp/language-reference/keywords/field.md | Field keyword reference | - |
| dotnet/docs | docs/csharp/language-reference/keywords/required.md | Required modifier reference | - |
| dotnet/docs | docs/csharp/whats-new/csharp-11.md | C# 11 required members | - |
| dotnet/docs | docs/csharp/whats-new/csharp-13.md | C# 13 field keyword preview | - |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/properties | rendered | Official properties documentation | - |
| https://learn.microsoft.com/dotnet/csharp/language-reference/keywords/field | rendered | Field keyword documentation | - |
| https://github.com/dotnet/csharplang/issues/140 | rendered | Field keyword proposal and discussion | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/using-properties | rendered | Using properties guide | - |

## Metadata

| Property | Value |
| --- | --- |
| Name | Properties and Backing Fields |
| ID | properties-backing-fields |
| Category | C# Language |
| Namespace | (none) |
| Description | Properties provide flexible data access through accessor methods, with support for auto-implementation, field keyword access, init-only setters, and required initialization. |
| Complexity | 0.30 |
| Audience | All C# developers |
| Priority | 1 (Critical - fundamental language feature) |
| Version | Multiple (auto-properties in 3.0, init in 9.0, required in 11.0, field in 14.0) |
| Year | 2024 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 8524071852922209080 |
| technical | simhash | 17748004640716161848 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp/csharp-14-features | 0.8054 |
| csharp | csharp/object-initialization | 0.7891 |
| csharp | csharp | 0.7118 |
| csharp | csharp/partial-classes | 0.6888 |
| libraries | libraries/json-validation-security | 0.6862 |
| csharp | csharp/lambda-expressions | 0.6840 |
| libraries | libraries/system-text-json-dotnet-10 | 0.6837 |
| csharp | csharp/collection-expressions | 0.6825 |
| libraries | libraries/dotnet-10-library-improvements | 0.6796 |
| libraries | libraries/collections-performance | 0.6777 |
| libraries | libraries/system-buffers-searchvalues | 0.6741 |
| libraries | libraries/system-collections-generic-ienumerable | 0.6740 |

## Authority Scores

| Topic | Keyword | Score |
|-------|---------|-------|
| csharp/csharp-14-features | keyword | 1.800 |
| csharp/object-initialization | records | 1.600 |
| csharp/object-initialization | init-only properties | 1.400 |
| csharp/partial-classes | keyword | 1.800 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Customer | method | 5 |
| ArgumentException | method | 3 |
| Product | method | 3 |

## Keywords

| Keyword | Score |
|---------|-------|
| accessor | 9.00 |
| backing | 8.00 |
| keyword | 8.00 |
| auto-implemented properties | 4.00 |
| computed properties | 4.00 |
| init-only properties | 4.00 |
| read-only | 5.00 |
| field | 7.00 |
| backing fields | 3.00 |
| primary | 6.00 |
| records | 6.00 |
| field-backed properties | 3.00 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 6
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.632 |
| 1 | Auto-Implemented Properties | 0.632 | 1.000 |
| 2 | Init-Only Properties | 0.624 | 0.708 |
| 3 | Required Properties | 0.536 | 0.654 |
| 4 | Computed Properties | 0.617 | 0.687 |
| 5 | Considerations | 0.646 | 0.684 |
