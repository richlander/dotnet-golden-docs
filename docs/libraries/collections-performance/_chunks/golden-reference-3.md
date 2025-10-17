# Collections Performance
## Understanding Stack Allocation

The runtime stack-allocates arrays when escape analysis proves they don't leave the method:

```csharp
// Stack allocated - doesn't escape
static void ProcessLocally()
{
    int[] data = { 1, 2, 3 };
    int sum = data.Sum();  // Inlined, array stays local
    Console.WriteLine(sum);
}

// Heap allocated - escapes via return
static int[] CreateArray()
{
    return new int[] { 1, 2, 3 };  // Must be heap allocated
}

// Heap allocated - escapes via assignment to field
class Container
{
    private int[] _data;
    
    void Initialize()
    {
        _data = new int[] { 1, 2, 3 };  // Escapes to field
    }
}

// Stack allocated - captured by struct, doesn't escape
static void ProcessWithStruct()
{
    int[] numbers = { 1, 2, 3 };
    
    var processor = new ArrayProcessor { Data = numbers };
    processor.Process();  // If ArrayProcessor is a struct and doesn't escape
}
```

### Escape Analysis for Struct Fields

The JIT tracks references through struct fields to enable more stack allocations:

```csharp
struct Container
{
    public int[] Numbers;
}

static void Process()
{
    int[] data = { 1, 2, 3, 4, 5 };  // Stack allocated
    var container = new Container { Numbers = data };
    
    // container doesn't escape, so data doesn't escape
    int sum = container.Numbers.Sum();
    Console.WriteLine(sum);
}
```
