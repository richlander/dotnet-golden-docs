# Collection Expressions
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
