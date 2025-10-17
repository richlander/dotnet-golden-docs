# Collection Initialization
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
