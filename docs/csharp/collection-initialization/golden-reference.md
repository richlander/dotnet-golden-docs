# Collection Initialization

## Overview

Collection initialization solves a fundamental programming task: creating a collection and specifying its initial values in a single statement. Rather than creating an empty collection and then adding elements one by one, you can declare the collection and populate it at the same time.

Different collection types have different requirements. Arrays, spans, and `IEnumerable` instances need their complete set of values upfront - once created, their size is fixed. Lists and dictionaries can start with an initial set of values and have more added later.

Collection expressions provide the simplest syntax for most scenarios. When you know the values as you write the code, collection expressions offer the clearest way to express your intent:

```csharp
// Values known upfront - use collection expressions
int[] numbers = [1, 2, 3, 4, 5];
List<string> names = ["Alice", "Bob", "Charlie"];

// Dictionary - use collection initializers
Dictionary<string, int> ages = new()
{
    ["Alice"] = 30,
    ["Bob"] = 25
};

// Dynamic construction - imperative approach
List<int> dynamicList = new();
for (int i = 0; i < count; i++)
{
    dynamicList.Add(ComputeValue(i));
}
```

## The Primary Collection Initialization Pattern: Collection Expressions

When you know the values upfront, collection expressions provide the clearest syntax for collection initialization:

```csharp
// Arrays
int[] numbers = [1, 2, 3, 4, 5];
string[] fruits = ["apple", "banana", "orange"];

// Lists
List<string> weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
List<int> primes = [2, 3, 5, 7, 11];

// Empty collections
int[] empty = [];
List<string> emptyList = [];
```

### Combining Collections

The spread operator `..` enables composing collections from existing ones:

```csharp
int[] first = [1, 2, 3];
int[] second = [4, 5, 6];

// Combine multiple sources
int[] combined = [..first, ..second];           // [1, 2, 3, 4, 5, 6]
int[] withExtras = [0, ..first, 10, ..second]; // [0, 1, 2, 3, 10, 4, 5, 6]

// Works with any enumerable
List<int> list = [1, 2, 3];
HashSet<int> set = [4, 5, 6];
int[] all = [..list, ..set, 7, 8];
```

### Other Collection Types

Collection expressions work with most collection types:

```csharp
// HashSet
HashSet<string> uniqueWords = ["apple", "banana", "orange"];

// Spans
Span<int> span = [1, 2, 3];
ReadOnlySpan<char> chars = ['a', 'b', 'c'];

// Queue and Stack
Queue<string> queue = ["first", "second", "third"];
Stack<int> stack = [1, 2, 3];

// Interface types
IEnumerable<int> enumerable = [1, 2, 3];
IReadOnlyList<string> readOnly = ["a", "b", "c"];
```

For comprehensive coverage of collection expressions including performance characteristics and advanced patterns, see the [Collection Expressions](../collection-expressions/golden-reference.md) documentation.

## Dictionary Initialization

Dictionaries don't support collection expressions, so they use collection initializer syntax:

```csharp
// Index initializer syntax
Dictionary<string, int> ages = new()
{
    ["Alice"] = 30,
    ["Bob"] = 25,
    ["Charlie"] = 35
};

// Alternative: Add method syntax
Dictionary<string, int> scores = new()
{
    { "Alice", 95 },
    { "Bob", 87 },
    { "Charlie", 92 }
};

// Empty dictionary
Dictionary<string, int> lookup = new();
```

### Nested Dictionary Values

```csharp
// Dictionary with list values
Dictionary<string, List<string>> categories = new()
{
    ["Fruits"] = ["apple", "banana"],
    ["Colors"] = ["red", "blue"]
};

// Dictionary with dictionary values
Dictionary<string, Dictionary<string, int>> nested = new()
{
    ["group1"] = new() { ["a"] = 1, ["b"] = 2 },
    ["group2"] = new() { ["c"] = 3, ["d"] = 4 }
};
```

## Imperative Construction Patterns

When values aren't known statically, the imperative construction initialization syntax the flexibility you need:

```csharp
// Build based on computation
List<int> squares = new();
for (int i = 1; i <= 10; i++)
{
    squares.Add(i * i);
}

// Conditional population
List<string> items = new();
if (includeDefaults)
{
    items.AddRange(["default1", "default2"]);
}
items.AddRange(["item1", "item2"]);

// Dictionary population
Dictionary<int, string> lookup = new();
foreach (var item in source)
{
    lookup[item.Id] = item.Name;
}
```

### Capacity Planning

Pre-sizing collections improves performance when you know the approximate size:

```csharp
// List with initial capacity
List<int> efficientList = new(1000);
for (int i = 0; i < 1000; i++)
{
    efficientList.Add(i);
}

// Dictionary with capacity
Dictionary<string, int> largeLookup = new(500);

// Avoid multiple internal resizes
List<int> inefficient = new();  // Starts small, grows as needed
```

## Target-Typed New

The `new()` syntax eliminates redundant type information:

```csharp
// With explicit type
List<string> explicitNames = new List<string>();
Dictionary<string, int> explicitAges = new Dictionary<string, int>();

// Target-typed - cleaner
List<string> names = new();
Dictionary<string, int> ages = new();

// Works with initializers
List<int> numbers = new() { 1, 2, 3 };
Dictionary<string, int> scores = new() { ["Alice"] = 95 };

// Works with capacity
List<int> capacityList = new(100);
```

### Method Calls

Target-typed new works naturally with method parameters and returns:

```csharp
void ProcessNames(List<string> names) { }

// Call with target-typed new
ProcessNames(new() { "Alice", "Bob" });

// Return with target-typed new
List<int> GetNumbers()
{
    return new() { 1, 2, 3, 4, 5 };
}
```

## Collection Initializer Syntax

Collection initializers provide an alternative to collection expressions:

```csharp
// Collection expressions (preferred when values are known)
List<int> numbers1 = [1, 2, 3, 4, 5];

// Collection initializers (alternative syntax)
List<int> numbers2 = new List<int> { 1, 2, 3, 4, 5 };
List<int> numbers3 = new() { 1, 2, 3, 4, 5 };

// Both work identically
HashSet<string> set1 = ["apple", "banana"];
HashSet<string> set2 = new() { "apple", "banana" };
```

## Array Initialization

Arrays offer multiple syntax options:

```csharp
// Collection expressions (concise)
int[] numbers = [1, 2, 3, 4, 5];

// Array initializer
int[] values = new int[] { 1, 2, 3, 4, 5 };

// Simplified syntax
int[] simple = { 1, 2, 3, 4, 5 };

// Empty array with size
int[] zeros = new int[5];        // [0, 0, 0, 0, 0]
string[] nulls = new string[3];  // [null, null, null]
```

## Span Initialization

Spans offer similar syntax options, with collection expressions as the preferred approach:

```csharp
// Collection expressions (preferred)
Span<int> span = [1, 2, 3, 4, 5];
ReadOnlySpan<char> chars = ['h', 'e', 'l', 'l', 'o'];

// stackalloc (alternative for stack allocation)
Span<int> stackSpan = stackalloc int[] { 1, 2, 3, 4, 5 };
ReadOnlySpan<char> stackChars = stackalloc char[] { 'h', 'e', 'l', 'l', 'o' };

// Simplified stackalloc
Span<int> simpleStack = stackalloc[] { 1, 2, 3, 4, 5 };
```

## Initialization from Data Sources

Collections can be initialized from existing data:

```csharp
// From arrays
string[] sourceArray = { "a", "b", "c" };
List<string> fromArray = new(sourceArray);

// From other collections
HashSet<int> sourceSet = [1, 2, 3];
List<int> fromSet = new(sourceSet);

// From LINQ queries
List<int> evenNumbers = new(
    Enumerable.Range(1, 100).Where(n => n % 2 == 0)
);

// Using collection expressions with spread
int[] source = [1, 2, 3];
List<int> list = [..source];
int[] filtered = [..source.Where(x => x > 1)];
```

## Nested Collections

Complex data structures combine initialization patterns:

```csharp
// List of lists with collection expressions
List<List<int>> matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
];

// Dictionary with collection expression values
Dictionary<string, List<string>> categories = new()
{
    ["Fruits"] = ["apple", "banana"],
    ["Vegetables"] = ["carrot", "celery"]
};

// Combining patterns
Dictionary<string, int[]> lookup = new()
{
    ["evens"] = [2, 4, 6, 8],
    ["odds"] = [1, 3, 5, 7]
};
```

## Performance Considerations

### Collection Type Selection

Choose the collection type that matches your usage:

```csharp
// For unique items
HashSet<string> uniqueItems = ["apple", "banana", "orange"];

// For key-value lookup
Dictionary<string, int> lookup = new() { ["key"] = 1 };

// For ordered iteration
List<string> orderedItems = ["first", "second", "third"];

// For FIFO operations
Queue<string> processing = new();

// For LIFO operations
Stack<string> undo = new();
```

### Capacity and Allocation

```csharp
// Pre-size when the count is known
List<int> sized = new(1000);

// Efficient for small known collections
int[] small = [1, 2, 3];

// Avoid repeated allocations
List<int> growing = new();  // Will resize as it grows
```

## Conditional Elements in Collection Initialization

```csharp
bool includeZero = true;

// Ternary with collection expressions
int[] numbers = includeZero ? [0, 1, 2, 3] : [1, 2, 3];

// Spread pattern
int[] baseNumbers = [1, 2, 3];
int[] extended = includeZero ? [0, ..baseNumbers] : baseNumbers;
```

## Collection Initialization in Method Returns

```csharp
public int[] GetValues(bool empty)
{
    if (empty) return [];
    return [1, 2, 3, 4, 5];
}

public Dictionary<string, int> GetLookup()
{
    return new()
    {
        ["key1"] = 1,
        ["key2"] = 2
    };
}
```

## LINQ Integration with Collection Initialization

```csharp
List<string> names = ["Alice", "Bob", "Charlie"];

// Transform to new collection
List<string> upperNames = [..names.Select(n => n.ToUpper())];

// Filter with collection expressions
int[] numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
int[] evens = [..numbers.Where(n => n % 2 == 0)];

// Traditional LINQ
List<string> filtered = new(names.Where(n => n.Length > 3));
```

## Best Practices

1. **Use collection expressions for known values**: Most direct syntax when elements are known upfront
2. **Use initializers for dictionaries**: Collection expressions don't support dictionary syntax
3. **Pre-size for large collections**: Specify capacity when building collections imperatively
4. **Choose appropriate collection types**: Match the collection to your access patterns
5. **Use target-typed new**: Eliminate redundant type information with `new()`
6. **Leverage spread operator**: Compose collections cleanly from existing sources

## Common Pitfalls

### Null Reference Issues

```csharp
// Array elements default to default values
string[] names = new string[3];  // [null, null, null]
Console.WriteLine(names[0].Length);  // NullReferenceException

// Initialize with values
string[] safeNames = ["Alice", "Bob", "Charlie"];
```

### Shared References

```csharp
// Creates references to the same list
List<int> row = [1, 2, 3];
List<List<int>> matrix = new();
matrix.Add(row);
matrix.Add(row);  // Same reference!

// Create separate instances
List<List<int>> correct = [
    [1, 2, 3],
    [1, 2, 3]  // Different instance
];
```

### Type Inference Limitations

```csharp
// Collection expressions require a target type
var unclear = [1, 2, 3];  // Error: can't infer type

// Provide explicit type
int[] clear = [1, 2, 3];
List<int> alsoGood = [1, 2, 3];
```
