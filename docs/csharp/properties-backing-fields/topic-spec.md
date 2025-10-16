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
