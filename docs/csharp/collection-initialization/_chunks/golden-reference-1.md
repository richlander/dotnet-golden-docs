# Collection Initialization
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
