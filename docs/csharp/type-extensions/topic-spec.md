# Type Extensions - Topic Specification

## Feature Description

Type extensions in C# enable developers to add methods, properties, and operators to existing types without modifying source code or creating derived types. C# 14 introduces modern extension block syntax that supports both instance and static members, expanding upon the traditional extension method pattern from C# 3.0. Both syntaxes remain fully supported and binary compatible.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/whats-new/tutorials/extension-members.md | Extension members tutorial | 0249c38f27 |
| dotnet/docs | docs/csharp/programming-guide/classes-and-structs/extension-methods.md | Extension methods programming guide | 0249c38f27 |
| dotnet/docs | docs/csharp/whats-new/csharp-14.md | C# 14 what's new documentation | 0249c38f27 |
| dotnet/csharplang | proposals/csharp-14.0/extensions.md | Extension members language proposal | 86c78a07 |
| dotnet/csharplang | proposals/csharp-14.0/extension-operators.md | Extension operators proposal | 86c78a07 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/programming-guide/classes-and-structs/extension-methods | rendered | Extension methods guide | 2025-10-22 |
| https://docs.microsoft.com/dotnet/csharp/whats-new/csharp-14 | rendered | C# 14 features overview | 2025-10-22 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/csharplang/issues/8697 | rendered | Extension members champion issue | 2025-10-22 |
| https://docs.microsoft.com/dotnet/csharp/linq/ | rendered | LINQ query operators (extension methods) | 2025-10-22 |

## Metadata

| Property | Value |
| --- | --- |
| Name | Type Extensions |
| ID | type-extensions |
| Category | C# Language |
| Description | Language feature enabling developers to add methods, properties, and operators to existing types using extension blocks (C# 14) or traditional extension methods (C# 3.0+). Works across all .NET versions when using appropriate C# language version. |
| Complexity | 0.45 |
| Audience | All C# developers |
| Priority | 1 (Fundamental - widely used pattern) |
| Version | 3.0 (extension methods), 14.0 (extension blocks) |
| Year | 2007 (extension methods), 2025 (extension blocks) |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 9554870716459120207 |
| overview | simhash | 12991676237840548218 |
| technical | simhash | 12704008262834332024 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | LINQ query operators, fluent APIs, adapter pattern, domain-specific extensions |
| Neutral | Cross-platform development, any .NET version (with appropriate C# version) |
| Conflicts with | Private member access, sealed type restrictions |
| Alternative to | Inheritance, wrapper classes, helper utilities |
| Synergistic with | LINQ, static classes, interface implementation, generic programming |
| Prerequisite | C# 3.0 for extension methods, C# 14 for extension blocks |

## Keywords

| Keyword | Score |
|---------|-------|
| extension | 16.00 |
| extension members | 8.00 |
| extensions | 10.00 |
| extension methods | 5.00 |
| operators | 7.00 |
| extension method | 3.00 |
| extension operators | 3.00 |
| type extensions | 2.00 |
| blocks | 4.00 |
| operator | 4.00 |
| static | 4.00 |
| modern syntax | 2.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Point | method | 20 |
| Console.WriteLine | method | 10 |
| WordCount | method | 10 |
| IsNumeric | method | 8 |
| Split | method | 7 |
| Add | method | 6 |
| IsNullOrEmpty | method | 6 |
| Reset | method | 6 |
| IsEmpty | method | 5 |
| Length | method | 5 |
| Batch | method | 4 |
| Process | method | 4 |

## Critical limitations

- **Extension resolution**: Instance methods always take precedence over extension members
- **Namespace scoping**: Extensions require explicit `using` directive to be visible
- **Type inference**: All type parameters must be inferrable from receiver or member parameters
- **Ref extensions**: Only allowed for value types and struct-constrained generics
- **Access restrictions**: Cannot access private or protected members of extended type
- **C# version requirement**: Extension blocks require C# 14; extension methods work from C# 3.0+
- **Runtime compatibility**: C# 14 extensions work on any .NET version (language-only feature)

## Key scenarios to cover

1. **Modern extension syntax**: Using extension blocks to group related members for a type
2. **Traditional extension methods**: Classic `this` modifier pattern for backward compatibility
3. **Static extensions**: Type-level properties and methods on existing types
4. **Extension operators**: Adding operator overloads to framework types
5. **Ref extensions**: Modifying struct instances without creating copies
6. **Generic extensions**: Type-parameterized extensions for collections and interfaces
7. **LINQ-style queries**: Custom query operators for domain-specific collections
8. **Fluent APIs**: Method chaining patterns for readable code
9. **Migration path**: Converting traditional extension methods to modern extension blocks
10. **Domain-specific utilities**: Adding business logic methods to framework types

## Anti-patterns to avoid

- Using extensions when you control the source type (add methods directly instead)
- Extending types to access private members (use proper encapsulation)
- Creating extensions with non-inferrable type parameters
- Overusing ref extensions on structs (consider if struct is appropriate)
- Name conflicts with instance methods (extension won't be called)
- Missing namespace imports causing confusion about missing methods
- Using extensions for tightly-coupled functionality (violates separation of concerns)

## Diagnostic Codes

| Code | Message |
| --- | --- |
| CS1061 | Type does not contain a definition for method and no accessible extension method accepting a first argument of type could be found |
| CS1501 | No overload for method takes N arguments |
| CS1503 | Argument type cannot convert from source to target type |
| CS1928 | Type does not contain a definition for method and the best extension method overload has some invalid arguments |
| CS1929 | Instance argument: cannot convert from source to target |
| CS8652 | The feature 'extension' is currently in Preview and unsupported. To use Preview features, use the 'preview' language version. |
| CS9273 | In language version 14.0, 'field' is a keyword within a property accessor |
| CS9281 | Extension declarations may not have a name |
| CS9282 | This member is not allowed in an extension block |
| CS9283 | Extensions must be declared in a static class |
| CS9286 | Extension resolution failed |
| CS9327 | Feature 'extension' is not available in C# 14.0. Please use language version preview or greater |
| CS9329 | Extension block collision with type |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp | TBD |
| csharp | csharp/csharp-14-features | TBD |
| csharp | csharp/lambda-expressions | TBD |
| libraries | libraries/system-linq | TBD |
| csharp | csharp/object-initialization | TBD |

## Chunks

**Source**: `golden-reference.md`
**Count**: TBD
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 2

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| TBD | TBD | TBD | TBD |
