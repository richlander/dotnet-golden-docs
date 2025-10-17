# Collection Expressions
## Spread Element
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
