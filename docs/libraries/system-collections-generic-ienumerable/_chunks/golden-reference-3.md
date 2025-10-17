# IEnumerable and IEnumerable&lt;T&gt;
## Relationships & Integration

### LINQ Integration

`IEnumerable<T>` is the foundation for LINQ to Objects. All standard LINQ operators are extension methods on `IEnumerable<T>`:

```csharp
using System.Linq;

IEnumerable<int> numbers = new[] { 1, 2, 3, 4, 5 };

// Extension methods from System.Linq
var result = numbers
    .Where(n => n > 2)      // Filtering
    .Select(n => n * 2)     // Transformation
    .OrderBy(n => n)        // Ordering
    .Take(3);               // Limiting

int sum = numbers.Sum();
double average = numbers.Average();
bool any = numbers.Any(n => n > 3);
```

### Collection Framework

Most .NET collections implement `IEnumerable<T>`:

```csharp
// Arrays
int[] array = { 1, 2, 3 };
IEnumerable<int> fromArray = array;

// Lists
List<string> list = new() { "a", "b", "c" };
IEnumerable<string> fromList = list;

// Sets
HashSet<int> set = new() { 1, 2, 3 };
IEnumerable<int> fromSet = set;

// Dictionaries (as KeyValuePair sequences)
Dictionary<string, int> dict = new() { ["a"] = 1, ["b"] = 2 };
IEnumerable<KeyValuePair<string, int>> fromDict = dict;
```

### JSON Serialization Integration

`IEnumerable<T>` works seamlessly with System.Text.Json:

```csharp
using System.Text.Json;

IEnumerable<string> names = new[] { "Alice", "Bob", "Charlie" };

// Serialize IEnumerable<T> directly
string json = JsonSerializer.Serialize(names);
// ["Alice","Bob","Charlie"]

// Deserialize to IEnumerable<T> (actually creates a list)
IEnumerable<string> deserialized = JsonSerializer.Deserialize<IEnumerable<string>>(json);
```

Note: Deserialization to `IEnumerable<T>` or `ICollection<T>` creates a `List<T>` internally. For read-only scenarios, deserialize to `IReadOnlyList<T>` or `List<T>` explicitly.
