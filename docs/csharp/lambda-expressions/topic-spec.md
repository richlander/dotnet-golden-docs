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

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 17753109691456815932 |
| technical | simhash | 17603784879850267516 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| csharp | csharp/csharp-14-features | 0.7600 |
| csharp | csharp | 0.7522 |
| libraries | libraries/system-collections-generic-ienumerable | 0.7338 |
| csharp | csharp/async-await | 0.7270 |
| csharp | csharp/collection-expressions | 0.7270 |
| libraries | libraries/system-threading-tasks-task | 0.7124 |
| libraries | libraries/system-collections-generic-iasyncenumerable | 0.7111 |
| csharp | csharp/properties-backing-fields | 0.6840 |
| libraries | libraries/string-search-operations | 0.6821 |
| libraries | libraries/system-text-json-jsonserializer | 0.6768 |
| csharp | csharp/collection-initialization | 0.6759 |
| libraries | libraries/dotnet-10-library-improvements | 0.6750 |

## APIs

| API | Type | Count |
|-----|------|-------|
| Console.WriteLine | method | 12 |
| Parse | method | 4 |

## Keywords

| Keyword | Score |
|---------|-------|
| lambda | 13.00 |
| delegate | 12.00 |
| lambdas | 11.00 |
| expression lambdas | 5.00 |
| expression trees | 5.00 |
| default parameters | 4.00 |
| natural type | 4.00 |
| statement lambdas | 4.00 |
| parameter | 7.00 |
| parameters | 7.00 |
| lambda expressions | 3.00 |
| explicit | 6.00 |

## Chunks

**Source**: `golden-reference.md`
**Count**: 5
**Baseline (Conceptual)**: 0
**Baseline (Technical)**: 1

| Index | Title | Conceptual Similarity | Technical Similarity |
|-------|-------|----------------------|---------------------|
| 0 | Overview | 1.000 | 0.713 |
| 1 | Expression Lambdas | 0.713 | 1.000 |
| 2 | Parameter Modifiers | 0.698 | 0.717 |
| 3 | Async Lambdas | 0.645 | 0.695 |
| 4 | Type Inference | 0.697 | 0.731 |
