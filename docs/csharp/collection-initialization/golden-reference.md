# Collection Initialization - Comprehensive Reference

## Overview

Collection initialization in C# provides multiple approaches for creating and populating collections with initial data. These techniques range from traditional constructor-based patterns to modern target-typed expressions and collection initializer syntax. Understanding these patterns is fundamental to effective C# programming, as they form the foundation for working with data structures across all versions of the language.

Collection initialization has evolved significantly since C#'s inception, with each approach serving different scenarios and coding styles. The methods discussed here work across all C# versions and provide maximum compatibility.

```csharp
// Traditional constructor approach
List<string> names1 = new List<string>();
names1.Add("Alice");
names1.Add("Bob");

// Collection initializer syntax (C# 3.0+)
List<string> names2 = new List<string> { "Alice", "Bob" };

// Target-typed new (C# 9.0+)
List<string> names3 = new() { "Alice", "Bob" };
```

## Why Collection Initialization Matters

### Foundation for Data Management

Collection initialization is essential for effective data management in C# applications. Every application works with collections of data, and understanding how to create and populate them efficiently is crucial for writing maintainable code.

### Performance and Memory Efficiency

Different initialization approaches have varying performance characteristics. Choosing the right approach can impact both execution speed and memory usage:

```csharp
// Pre-sizing for known capacity improves performance
List<int> numbers = new List<int>(100);

// Collection initializer with known items
List<int> predefined = new List<int> { 1, 2, 3, 4, 5 };
```

### Code Readability and Maintenance

Well-chosen initialization patterns make code more readable and self-documenting:

```csharp
// Clear intent with initialization
var weekdays = new List<string> { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday" };

// versus building manually
var weekdays2 = new List<string>();
weekdays2.Add("Monday");
weekdays2.Add("Tuesday");
// ... more verbose
```

## Basic Constructor Syntax

### List Construction

The most fundamental approach uses explicit constructors:

```csharp
// Empty list construction
List<int> numbers = new List<int>();
List<string> names = new List<string>();
List<bool> flags = new List<bool>();

// Pre-sized construction for performance
List<int> numbersWithCapacity = new List<int>(50);
List<string> namesWithCapacity = new List<string>(100);
```

### Array Construction

Arrays offer multiple initialization patterns:

```csharp
// Empty array construction
int[] numbers = new int[5];           // Creates [0, 0, 0, 0, 0]
string[] names = new string[3];       // Creates [null, null, null]

// Direct value initialization
int[] values = new int[] { 1, 2, 3, 4, 5 };
string[] words = new string[] { "hello", "world" };

// Simplified array initialization
int[] simpleValues = { 1, 2, 3, 4, 5 };
string[] simpleWords = { "hello", "world" };
```

### Other Collection Types

```csharp
// HashSet construction
HashSet<int> uniqueNumbers = new HashSet<int>();
HashSet<string> uniqueWords = new HashSet<string>();

// Dictionary construction
Dictionary<string, int> ages = new Dictionary<string, int>();
Dictionary<int, string> lookup = new Dictionary<int, string>();

// Queue and Stack
Queue<string> queue = new Queue<string>();
Stack<int> stack = new Stack<int>();
```

## Target-Typed New Expressions (C# 9.0+)

Target-typed new expressions eliminate redundant type information:

```csharp
// Traditional approach with redundant type information
List<string> traditionalNames = new List<string>();
Dictionary<string, int> traditionalAges = new Dictionary<string, int>();

// Target-typed new - cleaner syntax
List<string> names = new();
Dictionary<string, int> ages = new();
HashSet<int> numbers = new();

// Works with capacity constructors
List<int> numbersWithCapacity = new(100);
Dictionary<string, string> cache = new(50);
```

### Method Parameters and Return Types

Target-typed new works seamlessly with method signatures:

```csharp
// Method with collection parameter
void ProcessNames(List<string> names) { }

// Call with target-typed new
ProcessNames(new() { "Alice", "Bob", "Charlie" });

// Method returning collections
List<int> GetNumbers()
{
    return new() { 1, 2, 3, 4, 5 };
}
```

## Collection Initializer Syntax

Collection initializers provide concise initialization with initial values:

### List Initializers

```csharp
// Basic list initialization
List<int> numbers = new List<int> { 1, 2, 3, 4, 5 };
List<string> fruits = new List<string> { "apple", "banana", "orange" };

// Combined with target-typed new
List<int> modernNumbers = new() { 1, 2, 3, 4, 5 };
List<string> modernFruits = new() { "apple", "banana", "orange" };
```

### Dictionary Initializers

Dictionary initializers use key-value pair syntax:

```csharp
// Traditional dictionary initialization
Dictionary<string, int> ages = new Dictionary<string, int>
{
    { "Alice", 30 },
    { "Bob", 25 },
    { "Charlie", 35 }
};

// Modern dictionary initialization with target-typed new
Dictionary<string, int> modernAges = new()
{
    { "Alice", 30 },
    { "Bob", 25 },
    { "Charlie", 35 }
};

// Index initializer syntax (C# 6.0+)
Dictionary<string, int> indexAges = new Dictionary<string, int>
{
    ["Alice"] = 30,
    ["Bob"] = 25,
    ["Charlie"] = 35
};
```

### HashSet and Other Collections

```csharp
// HashSet initialization
HashSet<string> uniqueWords = new HashSet<string> { "apple", "banana", "orange" };
HashSet<int> uniqueNumbers = new() { 1, 2, 3, 4, 5 };

// Queue initialization
Queue<string> queue = new Queue<string>(new[] { "first", "second", "third" });

// Stack initialization (reverse order due to LIFO nature)
Stack<int> stack = new Stack<int>(new[] { 3, 2, 1 }); // Pop order: 3, 2, 1
```

## Advanced Initialization Patterns

### Nested Collections

Complex data structures require careful initialization:

```csharp
// List of lists
List<List<int>> matrix = new List<List<int>>
{
    new List<int> { 1, 2, 3 },
    new List<int> { 4, 5, 6 },
    new List<int> { 7, 8, 9 }
};

// Dictionary with list values
Dictionary<string, List<string>> categories = new Dictionary<string, List<string>>
{
    { "Fruits", new List<string> { "apple", "banana" } },
    { "Colors", new List<string> { "red", "blue" } }
};

// Modern syntax
Dictionary<string, List<string>> modernCategories = new()
{
    { "Fruits", new() { "apple", "banana" } },
    { "Colors", new() { "red", "blue" } }
};
```

### Conditional Initialization

```csharp
bool includeDefaults = true;

// Conditional content
List<string> items = new List<string>();
if (includeDefaults)
{
    items.AddRange(new[] { "default1", "default2" });
}
items.AddRange(new[] { "item1", "item2" });

// Or using constructor with existing collection
List<string> baseItems = new() { "item1", "item2" };
List<string> allItems = includeDefaults
    ? new(new[] { "default1", "default2" }.Concat(baseItems))
    : new(baseItems);
```

## Performance Considerations

### Capacity Planning

Pre-sizing collections improves performance by avoiding internal resizing:

```csharp
// Efficient: Pre-sized for known capacity
List<int> efficientList = new List<int>(1000);
for (int i = 0; i < 1000; i++)
{
    efficientList.Add(i);
}

// Less efficient: Multiple internal resizes
List<int> inefficientList = new List<int>();
for (int i = 0; i < 1000; i++)
{
    inefficientList.Add(i);
}
```

### Collection Type Selection

Choose the right collection type for your use case:

```csharp
// For unique items
HashSet<string> uniqueItems = new() { "apple", "banana", "orange" };

// For key-value lookup
Dictionary<string, int> lookup = new()
{
    ["apple"] = 1,
    ["banana"] = 2
};

// For ordered iteration
List<string> orderedItems = new() { "first", "second", "third" };

// For FIFO operations
Queue<string> processing = new();

// For LIFO operations
Stack<string> undo = new();
```

## Common Initialization Patterns

### Factory Methods

```csharp
public static List<T> CreateList<T>(params T[] items)
{
    return new List<T>(items);
}

public static Dictionary<TKey, TValue> CreateDictionary<TKey, TValue>()
{
    return new Dictionary<TKey, TValue>();
}

// Usage
List<int> numbers = CreateList(1, 2, 3, 4, 5);
Dictionary<string, int> ages = CreateDictionary<string, int>();
```

### Builder Patterns

```csharp
public class ListBuilder<T>
{
    private readonly List<T> _list = new();

    public ListBuilder<T> Add(T item)
    {
        _list.Add(item);
        return this;
    }

    public ListBuilder<T> AddRange(IEnumerable<T> items)
    {
        _list.AddRange(items);
        return this;
    }

    public List<T> Build() => new(_list);
}

// Usage
List<string> names = new ListBuilder<string>()
    .Add("Alice")
    .Add("Bob")
    .AddRange(new[] { "Charlie", "David" })
    .Build();
```

### Initialization from Data Sources

```csharp
// From arrays
string[] sourceArray = { "a", "b", "c" };
List<string> fromArray = new List<string>(sourceArray);

// From other collections
HashSet<int> sourceSet = new() { 1, 2, 3 };
List<int> fromSet = new List<int>(sourceSet);

// From LINQ queries
List<int> evenNumbers = new List<int>(
    Enumerable.Range(1, 100).Where(n => n % 2 == 0)
);
```

## Integration with Modern Features

### Collection Expressions Compatibility

Understanding traditional initialization helps when working with modern collection expressions:

```csharp
// Traditional initialization
List<int> traditional = new List<int> { 1, 2, 3 };

// Collection expressions (C# 12+)
List<int> modern = [1, 2, 3];

// Both approaches can coexist
List<int> combined = new List<int>([1, 2, 3]);
```

### LINQ Integration

Collection initialization works seamlessly with LINQ:

```csharp
List<string> names = new() { "Alice", "Bob", "Charlie" };

// Transform to new collection
List<string> upperNames = new(names.Select(n => n.ToUpper()));

// Filter to new collection
List<string> longNames = new(names.Where(n => n.Length > 3));
```

## Best Practices

1. **Use appropriate capacity**: Pre-size collections when the approximate size is known
2. **Choose the right collection type**: Match the collection type to your usage patterns
3. **Prefer target-typed new**: Use `new()` for cleaner code in C# 9.0+
4. **Use collection initializers**: Initialize with known values using initializer syntax
5. **Consider performance**: Understand the performance implications of different approaches
6. **Maintain consistency**: Use consistent initialization patterns throughout your codebase

## Common Mistakes and Pitfalls

### Null Reference Issues

```csharp
// Potential issue: Array elements are null by default
string[] names = new string[3];
Console.WriteLine(names[0].Length); // NullReferenceException

// Better: Initialize with values or check for null
string[] safeNames = new string[] { "Alice", "Bob", "Charlie" };
```

### Collection Modification During Initialization

```csharp
// Careful with shared references
List<List<int>> matrix = new();
List<int> row = new() { 1, 2, 3 };

// This creates references to the same list
matrix.Add(row);
matrix.Add(row);  // Same reference!

// Better: Create separate instances
matrix.Add(new List<int> { 1, 2, 3 });
matrix.Add(new List<int> { 1, 2, 3 });
```

### Performance Considerations

```csharp
// Avoid: Multiple small additions without capacity planning
List<int> inefficient = new();
for (int i = 0; i < 10000; i++)
{
    inefficient.Add(i);  // May trigger multiple resizes
}

// Better: Pre-size or use bulk initialization
List<int> efficient = new(10000);
// or
List<int> bulk = new(Enumerable.Range(0, 10000));
```