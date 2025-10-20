# Inline Arrays - Topic Specification

## Feature Description

Inline arrays provide a type-safe and ref-safe mechanism for creating fixed-size sequential data structures using the `InlineArrayAttribute`. This C# 12 feature enables developers to create custom buffer types with compile-time known sizes, offering a safe alternative to unsafe fixed-size buffers while maintaining performance characteristics similar to arrays with full GC tracking and bounds checking.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/csharplang | proposals/csharp-12.0/inline-arrays.md | Inline arrays language proposal | 2025-09-21 |
| dotnet/runtime | docs/design/features/InlineArrayAttribute.md | Runtime implementation documentation | 2025-09-21 |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 what's new documentation | 2025-09-21 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/language-reference/builtin-types/struct#inline-arrays | rendered | Main inline arrays documentation | 2025-09-21 |
| https://devblogs.microsoft.com/dotnet/announcing-csharp-12/ | rendered | C# 12 announcement with inline arrays | 2025-09-21 |
| https://github.com/dotnet/csharplang/issues/7431 | rendered | Inline arrays champion issue | 2025-09-21 |
| https://github.com/dotnet/runtime/issues/61135 | rendered | Runtime InlineArrayAttribute issue | 2025-09-21 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/roslyn | rendered | Compiler implementation | 2025-09-21 |
| https://devblogs.microsoft.com/dotnet/performance-improvements-in-net-8/ | rendered | .NET 8 performance improvements including inline arrays | 2025-09-21 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Inline Arrays |
| ID | inline-arrays |
| Category | C# Language |
| Namespace | System.Runtime.CompilerServices |
| Description | Type-safe and ref-safe mechanism for creating fixed-size sequential data structures using the InlineArrayAttribute, providing a safe alternative to unsafe fixed-size buffers. |
| Complexity | 0.7 |
| Audience | Performance-focused developers, Systems programmers, Interop scenarios |
| Priority | 3 (Useful - specialized performance scenarios) |
| Version | 12.0 |
| Year | 2023 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 17923769528747046492 |
| overview | simhash | 12991110520862344052 |
| technical | simhash | 17748602795442725756 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Type-safe fixed-size buffer access, Span/ReadOnlySpan integration, Bounds-checked element access, Stack allocation patterns |
| Conflicts with | None (additive language feature) |
| Alternative to | Unsafe fixed-size buffers, Manual pointer arithmetic, Unsafe memory access patterns |
| Prerequisite | C# 12+, .NET 8+ runtime, System.Runtime.CompilerServices.InlineArrayAttribute |
| Synergistic with | Span/ReadOnlySpan, Memory<T>, Index and Range operators, Collection expressions (future) |

## Keywords

| Keyword | Score |
|---------|-------|
| inline arrays | 33.00 |
| buffers | 20.00 |
| inline array | 8.00 |
| fixed-size | 10.00 |
| use | 20.00 |
| buffer | 9.00 |
| unsafe | 7.00 |
| element access | 4.00 |
| considerations | 8.00 |
| heap | 6.00 |
| bounds | 5.00 |
| create | 5.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| InlineArray | attribute | 48 |
| Console.WriteLine | method | 12 |
| CopyTo | method | 6 |
| System.Runtime | namespace | 6 |
| AsSpan | method | 5 |
| System.Runtime.CompilerServices | type | 5 |
| Enqueue | method | 4 |
| ProcessData | method | 4 |
| Fill | method | 3 |
| Math.Min | method | 3 |
| Reverse | method | 3 |
| StructLayout | attribute | 3 |

## Diagnostic Codes

| Code | Message |
| --- | --- |
| CS9167 | Inline array length must be greater than 0. |
| CS9169 | Inline array struct must declare one and only one instance field. |
| CS9168 | Inline array struct must not have explicit layout. |
| CS9166 | Index is outside the bounds of the inline array. |
| CS9172 | Elements of an inline array type can be accessed only with a single argument implicitly convertible to 'int', 'System.Index', or 'System.Range'. |
| CS9189 | foreach statement on an inline array of type '{0}' is not supported. |
| CS9180 | Inline array element field cannot be declared as required, readonly, volatile, or as a fixed size buffer. |
| CS9173 | An inline array access may not have a named argument specifier. |
| CS9170 | An expression tree may not contain an inline array access or conversion. |
| CS9171 | Target runtime doesn't support inline array types. |
| CS9184 | 'Inline arrays' language feature is not supported for an inline array type that is not valid as a type argument, or has element type that is not valid as a type argument. |
| CS9181 | Inline array indexer will not be used for element access expression. |
| CS9182 | Inline array 'Slice' method will not be used for element access expression. |
| CS9183 | Inline array conversion operator will not be used for conversion from expression of the declaring type. |
