# Collections Performance
## Array Enumeration Performance

### Direct vs. Interface Enumeration

Both patterns perform equivalently with devirtualization:

```csharp
static void ProcessArray(int[] data)
{
    // Direct enumeration
    foreach (int value in data)
    {
        Process(value);
    }
}

static void ProcessEnumerable(IEnumerable<int> data)
{
    // Interface enumeration - same performance when data is an array
    foreach (int value in data)
    {
        Process(value);
    }
}

// Both calls are equally efficient
int[] numbers = { 1, 2, 3, 4, 5 };
ProcessArray(numbers);
ProcessEnumerable(numbers);  // No virtualization overhead
```

### LINQ Performance on Arrays

LINQ queries on arrays benefit from devirtualization:

```csharp
int[] numbers = Enumerable.Range(1, 100).ToArray();

// Efficient - JIT devirtualizes and optimizes
var evenNumbers = numbers.Where(n => n % 2 == 0).ToArray();

// Also efficient - no abstraction penalty
IEnumerable<int> enumerable = numbers;
var squares = enumerable.Select(n => n * n).ToArray();
```

## Performance Characteristics

### Stack Allocation

- **Benefit**: Eliminates heap allocation and GC pressure
- **Applies to**: Small arrays (typically < 100 elements) that don't escape
- **Types**: Both value types and reference types (reference types store references on stack)
- **Automatic**: No code changes required, runtime optimization

### Array Interface Devirtualization

- **Benefit**: Eliminates virtual call overhead (typically 5-10ns per call)
- **Applies to**: Arrays accessed through IEnumerable<T> and related interfaces
- **Enables**: Inlining, bounds check elimination, SIMD vectorization
- **Automatic**: JIT optimization, no code changes required
