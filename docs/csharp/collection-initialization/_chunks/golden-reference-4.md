# Collection Initialization
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
