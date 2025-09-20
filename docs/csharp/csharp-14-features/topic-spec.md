# C# 14 Language Features - Topic Specification

## Feature Description

Collection topic covering key C# 14 language features including the `field` keyword in properties, first-class Span types, unbound generic types in `nameof`, enhanced lambda parameters, partial events and constructors, Extensions, null-conditional assignment, user-defined compound assignment operators, and expression tree improvements. Each feature enhances developer productivity and safety with modern syntax.

## Metadata

| Property | Value |
| --- | --- |
| Name | C# 14 Language Features |
| ID | csharp-14-features |
| Category | C# Language |
| Description | Collection topic covering key C# 14 language features including the `field` keyword in properties, first-class Span types, unbound generic types in `nameof`, enhanced lambda parameters, partial events and constructors, Extensions, null-conditional assignment, user-defined compound assignment operators, and expression tree improvements. |
| Complexity | 0.9 |
| Audience | C# developers |
| Priority | 2 (Common usage - language evolution and productivity improvements) |
| Version | 10.0 |
| Year | 2025 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | Simplified property implementations, zero-allocation patterns, type-safe extensions, improved null handling |
| Neutral | Cross-platform development, performance-critical scenarios |
| Conflicts with | Legacy C# patterns, older language versions |
| Alternative to | Manual backing field management, custom extension methods, verbose null checks |
| Synergistic with | Performance-oriented development, modern C# patterns, library design |
| Prerequisite | C# 14 / .NET 10 |

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/csharp/whats-new/csharp-14 | rendered | Main C# 14 features documentation | 2025-09-20 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/whats-new/csharp-14.md | C# 14 what's new documentation | - |
| dotnet/csharplang | proposals/csharp-14.0/README.md | C# 14 language proposals overview | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/roslyn/releases | rendered | Roslyn compiler releases | 2025-09-20 |

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
