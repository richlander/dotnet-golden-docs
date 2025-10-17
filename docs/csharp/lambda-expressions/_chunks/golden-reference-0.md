# Lambda Expressions

## Overview

Lambda expressions create anonymous functions using the `=>` operator to separate parameters from the function body. Lambdas can be expression-bodied (`x => x * 2`) or statement-bodied (`x => { return x * 2; }`). The compiler infers delegate types from lambda signatures, eliminating explicit type declarations in most scenarios.

Lambdas integrate with LINQ queries, event handlers, Task-based async methods, and anywhere delegate or expression tree types are required. C# supports natural type inference, parameter modifiers (ref, out, in, params), default parameters, and static lambdas for avoiding unintended closures.
