# Collection Initialization
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
