# Inline Arrays
## Limitations and Considerations
### Field Cannot Be readonly, volatile, or required

The element field has restrictions:

```csharp
// Error: Field modifiers not allowed
[InlineArray(10)]
public struct InvalidBuffer1
{
    private readonly int _element0;  // Error CS9180
}

[InlineArray(10)]
public struct InvalidBuffer2
{
    private volatile int _element0;  // Error CS9180
}

[InlineArray(10)]
public struct InvalidBuffer3
{
    private required int _element0;  // Error CS9180
}

// Correct: Simple private field
[InlineArray(10)]
public struct ValidBuffer
{
    private int _element0;
}
```

### No foreach Support

Inline arrays don't directly support foreach iteration:

```csharp
[InlineArray(10)]
public struct Buffer10
{
    private int _element0;
}

Buffer10 buffer = default;

// Error: foreach not supported
foreach (int value in buffer)  // Error CS9189
{
    Console.WriteLine(value);
}

// Correct: Convert to span first
Span<int> span = buffer;
foreach (int value in span)
{
    Console.WriteLine(value);
}
```

### Expression Tree Limitations

Inline array operations cannot be used in expression trees:

```csharp
[InlineArray(10)]
public struct Buffer10
{
    private int _element0;
}

// Error: Can't use in expression trees
Expression<Func<Buffer10, int>> expr = b => b[0];  // Error CS9170
```

### Type Argument Constraints

Some generic scenarios have limitations:

```csharp
[InlineArray(10)]
public struct Buffer10<T>
{
    private T _element0;
}

// May not work as type argument in some contexts
// if T has constraints or is not valid as type argument
public class Generic<T> where T : class
{
    // Error CS9184 if used incorrectly
    // Buffer10<T> buffer;
}
```
