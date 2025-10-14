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

## Why Collection Expressions Matter

### Simplicity by Design

Collection expressions provide a clean, data-focused syntax for working with collections in C#. The syntax lets you express your intent directly by listing the values you want:

```csharp
// Clear, expressive syntax that focuses on the data
var weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
```

### Language Familiarity

For developers coming from Python, JavaScript, or other modern languages, collection expressions feel immediately familiar. This reduces the learning curve and makes C# more approachable:

```csharp
string[] days = ["Mon", "Tue", "Wed"];
int[] nums = [1, 2, 3];
```

This syntax aligns with patterns developers know.

JavaScript:

```javascript
const days = ["Mon", "Tue", "Wed"];
const nums = [1, 2, 3];
```

And Swift:

```swift
let days = ["Mon", "Tue", "Wed"]
let nums = [1, 2, 3]
```

### Reduced Boilerplate

The feature eliminates repetitive type declarations and constructor calls, letting you focus on your actual data rather than language mechanics. This is especially apparent when working with nested collections or complex initialization patterns.

## Basic Syntax

### Array Creation

```csharp
// Arrays of various types
int[] integers = [1, 2, 3, 4, 5];
string[] fruits = ["apple", "banana", "orange"];
bool[] flags = [true, false, true];

// Empty arrays
int[] empty = [];
string[] emptyStrings = [];
```

### Collection Types

Collection expressions work with multiple collection types:

```csharp
// Lists
List<int> numbers = [1, 2, 3, 4, 5];

// Spans and ReadOnlySpans
Span<int> span = [1, 2, 3];
ReadOnlySpan<char> chars = ['a', 'b', 'c'];

// Any type supporting collection initializers
HashSet<string> unique = ["one", "two", "three"];
Queue<int> queue = [10, 20, 30];
```

### Variable Elements

Collection expressions can include variables and expressions:

```csharp
int x = 10;
int y = 20;
string name = "example";

int[] mixed = [x, y, x + y, 100];
string[] items = [name, name.ToUpper(), "constant"];
```

## Spread Element

The spread element `..` allows inlining existing collections:

```csharp
int[] first = [1, 2, 3];
int[] second = [4, 5, 6];

// Combine collections
int[] combined = [..first, ..second];           // [1, 2, 3, 4, 5, 6]
int[] withExtra = [0, ..first, 10, ..second];  // [0, 1, 2, 3, 10, 4, 5, 6]

// Works with any enumerable
string text = "hello";
char[] letters = [..text, '!'];  // ['h', 'e', 'l', 'l', 'o', '!']
```

### Spread with Different Collection Types

```csharp
List<int> list = [1, 2, 3];
HashSet<int> set = [4, 5, 6];
int[] array = [7, 8, 9];

// Spread from different sources
int[] all = [..list, ..set, ..array, 10];
```

## Params Collection Expressions (C# 13)

C# 13 extends collection expressions to work with params parameters:

```csharp
// Method with params
void PrintNumbers(params int[] numbers)
{
    foreach (int n in numbers)
        Console.Write($"{n} ");
}

// Call using collection expression
PrintNumbers([1, 2, 3, 4, 5]);

// Combine with spread
int[] existing = [10, 20];
PrintNumbers([..existing, 30, 40]);
```

### Params with Collection Types

```csharp
void ProcessItems<T>(params IEnumerable<T> items) { }
void HandleSpan(params ReadOnlySpan<int> span) { }

// Usage
ProcessItems([1, 2, 3, 4]);
HandleSpan([10, 20, 30]);
```

## Type Inference and Conversions

### Target Type Inference

Collection expressions use target type to determine the collection type:

```csharp
// Compiler infers int[] from assignment target
int[] numbers = [1, 2, 3];

// Compiler infers List<string> from assignment target
List<string> names = ["Alice", "Bob"];

// Explicit type needed for var
var items = new List<int> { 1, 2, 3 };  // Traditional syntax
List<int> items2 = [1, 2, 3];          // Collection expression
```

### Interface Assignments

```csharp
IEnumerable<int> enumerable = [1, 2, 3];
IReadOnlyList<string> readOnly = ["a", "b", "c"];
ICollection<bool> collection = [true, false];
```

## Performance Characteristics

### Compiler Optimizations

Collection expressions are optimized by the compiler:

```csharp
// These are equivalent in performance
int[] traditional = new int[] { 1, 2, 3, 4, 5 };
int[] expression = [1, 2, 3, 4, 5];

// Span creation is highly optimized
ReadOnlySpan<int> span = [1, 2, 3, 4, 5];  // Very efficient
```

### Memory Efficiency

```csharp
// No intermediate allocations with spread
int[] first = [1, 2, 3];
int[] second = [4, 5, 6];
int[] combined = [..first, ..second];  // Single allocation for result
```

## Using Collection Expressions in Method Returns

```csharp
public int[] GetFibonacci(int count)
{
    if (count <= 0) return [];
    if (count == 1) return [1];
    if (count == 2) return [1, 1];

    // Build and return using collection expression
    var fib = new int[count];
    fib[0] = fib[1] = 1;
    for (int i = 2; i < count; i++)
        fib[i] = fib[i-1] + fib[i-2];

    return [..fib];  // Return copy as collection expression
}
```

## Conditional Elements in Collection Expressions

```csharp
bool includeZero = true;
int[] numbers = includeZero ? [0, 1, 2, 3] : [1, 2, 3];

// More complex conditional spread
int[] baseNumbers = [1, 2, 3];
int[] extended = includeZero ? [0, ..baseNumbers] : baseNumbers;
```

## Using Collection Expressions with LINQ

```csharp
int[] numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// Collection expressions work naturally with LINQ
int[] evens = [..numbers.Where(n => n % 2 == 0)];
string[] strings = [..numbers.Select(n => n.ToString())];
```

## Alternative Syntax Options

Collection expressions provide a concise alternative to traditional initialization patterns:

```csharp
// Collection expressions
int[] numbers = [1, 2, 3];
List<string> names = ["a", "b", "c"];
HashSet<int> unique = [1, 2, 3];

// Traditional syntax (still fully supported)
int[] numbersTraditional = new int[] { 1, 2, 3 };
List<string> namesTraditional = new List<string> { "a", "b", "c" };
HashSet<int> uniqueTraditional = new HashSet<int> { 1, 2, 3 };
```

### Combining Collections

The spread operator provides an elegant way to combine multiple collections:

```csharp
int[] first = [1, 2, 3];
int[] second = [4, 5, 6];

// Using collection expressions with spread
int[] combined = [..first, ..second];
List<int> list = [..first, ..second];
```

## Best Practices

1. Use for readability: Collection expressions make code more concise and readable
2. Prefer for small collections: Most beneficial for small to medium-sized collections
3. Combine with spread: Use spread operator to combine existing collections elegantly
4. Target type clarity: Ensure target type is clear to avoid compilation errors
5. Performance awareness: Understand that spread operations may involve copying data

## Limitations and Considerations

### Compile-Time Constants

Collection expressions cannot be used where compile-time constants are required:

```csharp
// Not allowed - compile-time constant required
const int[] CONSTANT_ARRAY = [1, 2, 3];

// Not allowed - default parameter value
void Method(int[] values = [1, 2, 3]) { }

// Allowed - runtime initialization
static readonly int[] ReadOnlyArray = [1, 2, 3];
```

### Type Requirements

Target type must be known or inferrable:

```csharp
// Ambiguous - compiler can't determine type
var unclear = [1, 2, 3];

// Clear target type
List<int> clear = [1, 2, 3];
int[] alsoGood = [1, 2, 3];
```

### Inline Arrays

Collection expressions cannot initialize inline arrays:

```csharp
// Inline arrays require different syntax
[InlineArray(3)]
struct Buffer3<T> { private T _element0; }

// Not supported
Buffer3<int> buffer = [1, 2, 3];
```
