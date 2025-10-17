# Collections Performance
## Automatic Stack Allocation for Small Arrays

The runtime automatically stack-allocates small arrays that don't escape their method scope:

```csharp
// Small arrays are stack allocated when they don't escape
static int CalculateSum()
{
    int[] numbers = { 1, 2, 3, 4, 5 };  // Stack allocated
    int sum = 0;
    
    foreach (int num in numbers)
    {
        sum += num;
    }
    
    return sum;
}

// Also works for reference type arrays
static void PrintMessages()
{
    string[] messages = { "Hello", "World", "!" };  // Stack allocated
    
    foreach (string msg in messages)
    {
        Console.WriteLine(msg);
    }
}
```

These arrays are allocated on the stack automatically because the compiler can prove they don't escape the method. No heap allocation or garbage collection is required.

**Note**: Stack allocation for value type arrays has been available in earlier .NET versions, while reference type arrays gained this optimization in .NET 10.

## Array Interface Performance Parity

Arrays accessed through interfaces have the same performance as direct array access due to devirtualization:

```csharp
// Both approaches have equivalent performance
static int SumDirect(int[] array)
{
    int sum = 0;
    for (int i = 0; i < array.Length; i++)
    {
        sum += array[i];
    }
    return sum;
}

static int SumViaInterface(int[] array)
{
    int sum = 0;
    IEnumerable<int> enumerable = array;  // No performance penalty
    
    foreach (int num in enumerable)
    {
        sum += num;
    }
    
    return sum;
}
```

The JIT devirtualizes the interface calls and applies the same optimizations (inlining, bounds check elimination, vectorization) to both versions.
