# Collection Expressions
## Alternative Syntax Options
### Memory Efficiency

```csharp
// No intermediate allocations with spread
int[] first = [1, 2, 3];
int[] second = [4, 5, 6];
int[] combined = [..first, ..second];  // Single allocation for result
```

## Using Collection Expressions in Method Returns

```csharp
public int[] GetFibonacci(int count)
{
    if (count <= 0) return [];
    if (count == 1) return [1];
    if (count == 2) return [1, 1];

    // Build and return using collection expression
    var fib = new int[count];
    fib[0] = fib[1] = 1;
    for (int i = 2; i < count; i++)
        fib[i] = fib[i-1] + fib[i-2];

    return [..fib];  // Return copy as collection expression
}
```

## Conditional Elements in Collection Expressions

```csharp
bool includeZero = true;
int[] numbers = includeZero ? [0, 1, 2, 3] : [1, 2, 3];

// More complex conditional spread
int[] baseNumbers = [1, 2, 3];
int[] extended = includeZero ? [0, ..baseNumbers] : baseNumbers;
```

## Using Collection Expressions with LINQ

```csharp
int[] numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// Collection expressions work naturally with LINQ
int[] evens = [..numbers.Where(n => n % 2 == 0)];
string[] strings = [..numbers.Select(n => n.ToString())];
```

## Alternative Syntax Options

Collection expressions provide a concise alternative to traditional initialization patterns:

```csharp
// Collection expressions
int[] numbers = [1, 2, 3];
List<string> names = ["a", "b", "c"];
HashSet<int> unique = [1, 2, 3];

// Traditional syntax (still fully supported)
int[] numbersTraditional = new int[] { 1, 2, 3 };
List<string> namesTraditional = new List<string> { "a", "b", "c" };
HashSet<int> uniqueTraditional = new HashSet<int> { 1, 2, 3 };
```
