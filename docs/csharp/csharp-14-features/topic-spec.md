# C# 14 Language Features - Topic Specification

## Feature Description

Collection topic covering key C# 14 language features including the `field` keyword in properties, first-class Span types, unbound generic types in `nameof`, enhanced lambda parameters, partial events and constructors, Extensions, null-conditional assignment, user-defined compound assignment operators, and expression tree improvements. Each feature enhances developer productivity and safety with modern syntax.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/whats-new/csharp-14.md | C# 14 what's new documentation | 0249c38f27 |
| dotnet/csharplang | proposals/csharp-14.0/ | C# 14 language proposals overview | 86c78a07 |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/whats-new/csharp-14 | rendered | Main C# 14 features documentation | 2025-09-20 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/roslyn/releases | rendered | Roslyn compiler releases | 2025-09-20 |

## Metadata

| Property | Value |
| --- | --- |
| Name | C# 14 Language Features |
| ID | csharp-14-features |
| Category | C# Language |
| Description | Collection topic covering key C# 14 language features including the `field` keyword in properties, first-class Span types, unbound generic types in `nameof`, enhanced lambda parameters, partial events and constructors, Extensions, null-conditional assignment, user-defined compound assignment operators, and expression tree improvements. |
| Complexity | 0.8 |
| Audience | C# developers |
| Priority | 2 (Common usage - language evolution and productivity improvements) |
| Version | 14.0 |
| Year | 2025 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| error-codes | bloom | 7262411006152912613 |
| overview | simhash | 12991679535167439672 |
| technical | simhash | 12704008812590162300 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Simplified property implementations, zero-allocation patterns, type-safe extensions, improved null handling |
| Neutral | Cross-platform development, performance-critical scenarios |
| Conflicts with | Legacy C# patterns, older language versions |
| Alternative to | Manual backing field management, custom extension methods, verbose null checks |
| Synergistic with | Performance-oriented development, modern C# patterns, library design |
| Prerequisite | C# 14 / .NET 10 |

## Keywords

| Keyword | Score |
|---------|-------|
| assignment | 6.00 |
| extension | 5.00 |
| zero-allocation | 3.00 |
| enhanced | 4.00 |
| keyword | 4.00 |
| params collections | 2.00 |
| expression trees | 2.00 |
| first-class span | 2.00 |
| named arguments | 2.00 |
| compile-time | 4.00 |
| patterns | 6.00 |
| first-class | 3.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Console.WriteLine | method | 8 |
| LastIndexOf | method | 4 |
| LogMessage | method | 4 |
| MyClass | method | 4 |
| ArgumentNullException | method | 3 |
| CelebrateBirthday | method | 3 |
| GetFileExtension | method | 3 |
| Trim | method | 3 |
| TryParse | method | 3 |

## Critical limitations

- `field` keyword: Only available in property accessors, preview feature status
- First-class Span: Requires careful lifetime management, ref safety rules apply
- Extensions: New syntax that may not be familiar to all developers
- Null-conditional assignment: Limited to assignment contexts, not general expressions
- User-defined operators: Must follow operator precedence and associativity rules

## Key scenarios to cover

1. Property simplification: Using `field` keyword for custom property logic while maintaining auto-implemented convenience
2. Zero-allocation patterns: First-class Span types for high-performance memory operations
3. Generic type operations: `nameof` with unbound generic types for reflection and code generation
4. Lambda enhancements: Simple parameters with modifiers (ref, out, in, params)
5. Partial member completion: Events and constructors in partial types for code generation scenarios
6. Type-safe extensions: Extensions feature for augmenting types without inheritance
7. Null-safe patterns: Null-conditional assignment for cleaner null handling
8. Operator overloading: User-defined compound assignment operators (+=, -=, etc.)
9. Expression trees: Optional and named arguments in LINQ expression trees

## Anti-patterns to avoid

- Using `field` keyword outside of property accessors
- Span lifetime violations and ref safety errors
- Overusing null-conditional assignment where traditional patterns are clearer
- Complex compound assignment operators that reduce readability
- Extensions that violate type safety or expected behavior

## Diagnostic Codes

| Code | Message |
| --- | --- |
| CS9273 | In language version {0}, 'field' is a keyword within a property accessor. Rename the variable or use the identifier '@field' instead. |
| CS9327 | Feature '{0}' is not available in C# 14.0. Please use language version {1} or greater. |
| CS9316 | Extension members are not allowed as an argument to 'nameof'. |
| CS9281 | Extension declarations may not have a name. |
| CS9282 | This member is not allowed in an extension block. |
| CS9283 | Extensions must be declared in a static class. |
| CS9286 | Extension resolution failed. |
| CS9317 | User-defined operator '{0}' must be declared as 'public static'. |
| CS9318 | Binary operator '{0}' has the wrong signature for a compound assignment operator. |
| CS9319 | Operator '{0}' cannot be used as a compound assignment operator because its return type is not assignable to its first parameter type. |
| CS9320 | User-defined operator '{0}' cannot be used as a compound assignment operator with operands of type '{1}' and '{2}'. |
| CS9321 | Conversion operator '{0}' cannot be used in a compound assignment because it has the wrong return type. |
| CS9322 | Binary operator '{0}' has a ref return but is not valid for compound assignment. |
| CS9323 | User-defined compound assignment operator '{0}' has invalid signature. |
| CS9324 | Operator '{0}' is not valid for compound assignment with operands of type '{1}' and '{2}'. |
| CS9329 | Extension block collision with type '{0}'.
## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp | 0.8373 |
| libraries | libraries/dotnet-10-library-improvements | 0.7967 |
| csharp | csharp/object-initialization | 0.7591 |
| csharp | csharp/collection-expressions | 0.7522 |
| libraries | libraries/system-text-json | 0.7342 |
| libraries | libraries/system-buffers-searchvalues | 0.7328 |
| libraries | libraries | 0.7280 |
| dotnet | dotnet | 0.7274 |
| libraries | libraries/system-text-json-jsonserializer | 0.7259 |
| libraries | libraries/system-text-json-migrate-from-newtonsoft | 0.7255 |
| libraries | libraries/string-search-operations | 0.7160 |
| libraries | libraries/system-text-json-nodes | 0.7090 |

