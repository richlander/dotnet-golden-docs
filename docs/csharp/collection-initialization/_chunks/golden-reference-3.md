# Collection Initialization
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
