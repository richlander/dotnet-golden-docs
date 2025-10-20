# Inline Arrays
## Essential Syntax & Examples

### Basic Inline Array Declaration

```csharp
using System.Runtime.CompilerServices;

// Inline array with 5 elements of type T
[InlineArray(5)]
public struct FixedBuffer5<T>
{
    private T _element0;
}

// Inline array for specific type
[InlineArray(8)]
public struct ByteBuffer8
{
    private byte _element0;
}

// Usage
FixedBuffer5<int> numbers = default;
numbers[0] = 1;
numbers[4] = 5;

ByteBuffer8 bytes = default;
bytes[0] = 0xFF;
```

### Element Access

```csharp
[InlineArray(10)]
public struct Buffer10<T>
{
    private T _element0;
}

Buffer10<int> buffer = default;

// Index access
buffer[0] = 42;
buffer[5] = 100;
int value = buffer[0];

// Index operator
buffer[^1] = 999;  // Last element
buffer[^2] = 888;  // Second to last

// Bounds checking
try
{
    buffer[10] = 0;  // Throws IndexOutOfRangeException
}
catch (IndexOutOfRangeException)
{
    Console.WriteLine("Out of bounds!");
}
```

### Span Conversion

```csharp
[InlineArray(10)]
public struct Buffer10<int>
{
    private int _element0;
}

Buffer10<int> buffer = default;

// Implicit conversion to Span<T>
Span<int> span = buffer;
span[0] = 42;

// Implicit conversion to ReadOnlySpan<T>
ReadOnlySpan<int> readOnlySpan = buffer;
int first = readOnlySpan[0];

// Use span operations
span.Fill(0);
span.Reverse();
span.Sort();

// Slicing
Span<int> slice = span[2..7];
```

### Iteration

```csharp
[InlineArray(5)]
public struct Buffer5<T>
{
    private T _element0;
}

Buffer5<int> buffer = default;
for (int i = 0; i < 5; i++)
{
    buffer[i] = i * 10;
}

// Convert to span for easier iteration
Span<int> span = buffer;
foreach (ref int value in span)
{
    value *= 2;
}

// Read-only iteration
ReadOnlySpan<int> readOnlySpan = buffer;
foreach (int value in readOnlySpan)
{
    Console.WriteLine(value);
}
```
