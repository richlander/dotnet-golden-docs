# Collection Initialization

## Overview

Collection initialization solves a fundamental programming task: creating a collection and specifying its initial values in a single statement. Rather than creating an empty collection and then adding elements one by one, you can declare the collection and populate it at the same time.

Different collection types have different requirements. Arrays, spans, and `IEnumerable` instances need their complete set of values upfront - once created, their size is fixed. Lists and dictionaries can start with an initial set of values and have more added later.

Collection expressions provide the simplest syntax for most scenarios. When you know the values as you write the code, collection expressions offer the clearest way to express your intent:

```csharp
// Values known upfront - use collection expressions
int[] numbers = [1, 2, 3, 4, 5];
List<string> names = ["Alice", "Bob", "Charlie"];

// Dictionary - use collection initializers
Dictionary<string, int> ages = new()
{
    ["Alice"] = 30,
    ["Bob"] = 25
};

// Dynamic construction - imperative approach
List<int> dynamicList = new();
for (int i = 0; i < count; i++)
{
    dynamicList.Add(ComputeValue(i));
}
```
