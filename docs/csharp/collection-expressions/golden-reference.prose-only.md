# Collection Expressions
## Overview
Collection expressions provide an intuitive and ergonomic syntax for creating collection values in C#, matching the familiar syntax found in other popular languages like Python, JavaScript, and Rust. This syntax enables clear, readable code that focuses on the data rather than the construction mechanics.
This syntax was introduced in C# 12 and extended in C# 13 with params support. Collection expressions use the familiar square bracket notation  to create arrays, lists, spans, and other collection types with minimal syntax. This represents a significant step toward making C# syntax more concise and developer-friendly.
The following example demonstrates the syntax in common scenarios:
It will be very familiar for Python users:
And the same for Rust users:
## Why Collection Expressions Matter
### Simplicity by Design
Collection expressions provide a clean, data-focused syntax for working with collections in C#. The syntax lets you express your intent directly by listing the values you want:
### Language Familiarity
For developers coming from Python, JavaScript, or other modern languages, collection expressions feel immediately familiar. This reduces the learning curve and makes C# more approachable:
This syntax aligns with patterns developers know.
JavaScript:
And Swift:
### Reduced Boilerplate
The feature eliminates repetitive type declarations and constructor calls, letting you focus on your actual data rather than language mechanics. This is especially apparent when working with nested collections or complex initialization patterns.
## Basic Syntax
### Array Creation
### Collection Types
Collection expressions work with multiple collection types:
### Variable Elements
Collection expressions can include variables and expressions:
## Spread Element
The spread element  allows inlining existing collections:
### Spread with Different Collection Types
## Params Collection Expressions (C# 13)
C# 13 extends collection expressions to work with params parameters:
### Params with Collection Types
## Type Inference and Conversions
### Target Type Inference
Collection expressions use target type to determine the collection type:
### Interface Assignments
## Performance Characteristics
### Compiler Optimizations
Collection expressions are optimized by the compiler:
### Memory Efficiency
## Common Patterns
### Method Returns
### Conditional Elements
### LINQ Integration
## Alternative Syntax Options
Collection expressions provide a concise alternative to traditional initialization patterns:
### Combining Collections
The spread operator provides an elegant way to combine multiple collections:
## Best Practices
1. Use for readability: Collection expressions make code more concise and readable
2. Prefer for small collections: Most beneficial for small to medium-sized collections
3. Combine with spread: Use spread operator to combine existing collections elegantly
4. Target type clarity: Ensure target type is clear to avoid compilation errors
5. Performance awareness: Understand that spread operations may involve copying data
## Limitations and Considerations
### Compile-Time Constants
Collection expressions cannot be used where compile-time constants are required:
### Type Requirements
Target type must be known or inferrable:
### Inline Arrays
Collection expressions cannot initialize inline arrays: