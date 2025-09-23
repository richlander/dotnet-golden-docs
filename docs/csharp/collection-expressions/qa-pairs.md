# Collection Expressions - Q&A

## Getting Started

---

tags: ["beginner", "concept", "syntax"]
validation: "Covers basic syntax and use cases accurately"
---

Q: What are collection expressions in C# and when should I use them?
A: Collection expressions provide a concise syntax to create common collection values using square bracket notation `[...]`. They were introduced in C# 12 and extended in C# 13. Use them for:

- Creating arrays, lists, and spans with minimal syntax
- Initializing collections in a readable, data-focused way
- Working with spread operations and combining collections
- Making C# syntax more familiar to developers from Python, JavaScript, or Rust backgrounds

```csharp
int[] numbers = [1, 2, 3, 4, 5];
List<string> names = ["Alice", "Bob", "Charlie"];
```

------

---

tags: ["beginner", "syntax", "examples"]
validation: "Basic usage examples are correct"
---

Q: How do I create basic collections with collection expressions?
A: Use square brackets with comma-separated values. The compiler infers the type:

```csharp
// Arrays
int[] numbers = [1, 2, 3];
string[] names = ["Alice", "Bob"];

// Lists
List<int> list = [1, 2, 3];
var stringList = new List<string> ["a", "b", "c"];

// Spans
Span<int> span = [1, 2, 3];
ReadOnlySpan<char> chars = ['a', 'b', 'c'];
```

------

---

tags: ["intermediate", "spread", "combining"]
validation: "Spread operator usage is accurate"
---

Q: How do I combine existing collections using the spread operator?
A: Use the spread operator `..` to expand existing collections into new ones:

```csharp
int[] first = [1, 2, 3];
int[] second = [4, 5, 6];

// Combine collections
int[] combined = [..first, ..second];  // [1, 2, 3, 4, 5, 6]

// Mix individual values and collections
int[] mixed = [0, ..first, 10, ..second, 20];  // [0, 1, 2, 3, 10, 4, 5, 6, 20]

// Works with any IEnumerable
List<string> list = ["a", "b"];
string[] array = ["c", "d"];
var result = [..list, ..array];  // ["a", "b", "c", "d"]
```

------

---

tags: ["intermediate", "empty", "null"]
validation: "Empty collection handling is correct"
---

Q: How do I create empty collections and handle null values?
A: Use empty square brackets for empty collections, and the spread operator handles null gracefully:

```csharp
// Empty collections
int[] empty = [];
List<string> emptyList = [];

// Null handling with spread
int[]? nullArray = null;
int[] safe = [..nullArray ?? []];  // No exception, creates empty array

// Conditional inclusion
bool includeExtra = true;
int[] conditional = [1, 2, ..includeExtra ? [3, 4] : []];
```

------

---

tags: ["advanced", "params", "c#13"]
validation: "Params collections feature is accurate for C# 13"
---

Q: How do params collections work with collection expressions in C# 13?
A: C# 13 introduces params collections that accept collection expressions directly:

```csharp
// Method with params collection
void ProcessItems(params ReadOnlySpan<int> items)
{
    foreach (int item in items)
        Console.WriteLine(item);
}

// Call with collection expression
ProcessItems([1, 2, 3, 4]);

// Can also spread existing collections
int[] existing = [1, 2];
ProcessItems([..existing, 3, 4]);
```

------

---

tags: ["performance", "allocation", "spans"]
validation: "Performance characteristics are accurate"
---

Q: What are the performance implications of collection expressions?
A: Collection expressions are optimized by the compiler and can be very efficient:

```csharp
// Array creation - single allocation
int[] array = [1, 2, 3];  // Equivalent to new int[] {1, 2, 3}

// Span creation - stack allocated for literals
Span<int> span = [1, 2, 3];  // Very efficient, no heap allocation

// ReadOnlySpan - can reference static data
ReadOnlySpan<int> readOnly = [1, 2, 3];  // May reference compile-time constants

// List creation
List<int> list = [1, 2, 3];  // Creates List with appropriate capacity
```

------

---

tags: ["troubleshooting", "errors", "diagnostics"]
validation: "Common error scenarios are covered"
---

Q: What are common errors when using collection expressions?
A: Watch out for these compilation issues:

```csharp
// Error: Cannot infer type
var unknown = [];  // CS9176: Cannot determine type

// Solution: Specify type explicitly
int[] specified = [];
var typed = new List<int>[];

// Error: Incompatible types in collection
int[] mixed = [1, "string"];  // CS0029: Cannot convert

// Error: Using spread on non-enumerable
object obj = new object();
int[] invalid = [..obj];  // CS1929: Does not contain definition for GetEnumerator
```

------