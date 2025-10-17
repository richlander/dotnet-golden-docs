# Collection Expressions

## Overview

Collection expressions provide an intuitive and ergonomic syntax for creating collection values in C#, matching the familiar syntax found in other popular languages like Python, JavaScript, and Rust. This syntax enables clear, readable code that focuses on the data rather than the construction mechanics.

This syntax was introduced in C# 12 and extended in C# 13 with params support. Collection expressions use the familiar square bracket notation `[...]` to create arrays, lists, spans, and other collection types with minimal syntax. This represents a significant step toward making C# syntax more concise and developer-friendly.

The following example demonstrates the syntax in common scenarios:

```csharp
// Collection expressions - simple and intuitive
int[] numbers = [1, 2, 3, 4, 5];
List<string> names = ["Alice", "Bob", "Charlie"];
```

It will be very familiar for Python users:

```python
numbers = [1, 2, 3, 4, 5]
names = ["Alice", "Bob", "Charlie"]
```

And the same for Rust users:

```rust
let numbers = [1, 2, 3, 4, 5];
let names = vec!["Alice", "Bob", "Charlie"];
```
