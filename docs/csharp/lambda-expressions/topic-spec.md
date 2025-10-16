# Lambda Expressions - Topic Specification

## Feature Description

Lambda expressions create anonymous functions using the `=>` operator, with support for expression and statement bodies, natural type inference, parameter modifiers (ref, out, in, params), default parameters, static lambdas, and async operations. Lambdas integrate with LINQ, event handlers, and anywhere delegate or expression tree types are required.

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/language-reference/operators/lambda-expressions.md | Lambda expressions language reference | - |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 lambda default parameters | - |
| dotnet/docs | docs/csharp/whats-new/csharp-14.md | C# 14 simple lambda parameters with modifiers | - |
| dotnet/docs | docs/csharp/whats-new/csharp-version-history.md | Lambda natural type (C# 10) | - |

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/csharp/language-reference/operators/lambda-expressions | rendered | Official lambda expressions documentation | - |
| https://github.com/dotnet/csharplang/blob/main/proposals/csharp-12.0/lambda-method-group-defaults.md | rendered | Default parameters on lambda expressions proposal | - |
| https://github.com/dotnet/csharplang/blob/main/proposals/csharp-14.0/simple-lambda-parameters-with-modifiers.md | rendered | Simple lambda parameters with modifiers proposal | - |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://learn.microsoft.com/dotnet/csharp/advanced-topics/expression-trees | rendered | Expression trees documentation | - |

## Metadata

| Property | Value |
| --- | --- |
| Name | Lambda Expressions |
| ID | lambda-expressions |
| Category | C# Language |
| Namespace | (none) |
| Description | Lambda expressions create anonymous functions with expression or statement bodies, supporting natural type inference, parameter modifiers, default parameters, static lambdas, and async operations. |
| Complexity | 0.40 |
| Audience | All C# developers |
| Priority | 1 (Critical - fundamental language feature) |
| Version | Multiple (3.0 base, 9.0 static, 10.0 natural type, 12.0 defaults, 14.0 modifiers) |
| Year | 2024 |
