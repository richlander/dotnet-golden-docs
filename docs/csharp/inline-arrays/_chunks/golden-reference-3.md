# Inline Arrays
## Relationships & Integration
### Struct Field Usage

```csharp
using System.Runtime.CompilerServices;

[InlineArray(32)]
public struct CharBuffer32
{
    private char _element0;
}

public struct FixedString32
{
    private CharBuffer32 _buffer;
    private int _length;

    public FixedString32(string value)
    {
        _length = Math.Min(value.Length, 32);
        Span<char> bufferSpan = _buffer;
        value.AsSpan(0, _length).CopyTo(bufferSpan);
    }

    public override string ToString()
    {
        ReadOnlySpan<char> span = _buffer;
        return new string(span[.._length]);
    }
}

// Usage
FixedString32 str = new FixedString32("Hello, World!");
Console.WriteLine(str);  // "Hello, World!"
```

### Generic Inline Arrays

```csharp
[InlineArray(4)]
public struct QuadBuffer<T>
{
    private T _element0;
}

// Works with any type
QuadBuffer<int> ints = default;
ints[0] = 1;
ints[1] = 2;
ints[2] = 3;
ints[3] = 4;

QuadBuffer<string> strings = default;
strings[0] = "A";
strings[1] = "B";

QuadBuffer<(int, string)> tuples = default;
tuples[0] = (1, "one");
tuples[1] = (2, "two");
```

## Relationships & Integration

### Span and Memory Integration

Inline arrays integrate seamlessly with the span ecosystem:

```csharp
[InlineArray(16)]
public struct Buffer16<T>
{
    private T _element0;
}

Buffer16<byte> buffer = default;

// Convert to Span<T>
Span<byte> span = buffer;
span.Fill(0xFF);

// Convert to ReadOnlySpan<T>
ReadOnlySpan<byte> readOnlySpan = buffer;

// Pass to span-accepting methods
ProcessData(buffer);  // Implicit conversion

void ProcessData(Span<byte> data)
{
    // Process the data
}
```

### Range and Index Operators

Inline arrays support modern indexing syntax:

```csharp
[InlineArray(10)]
public struct Buffer10<T>
{
    private T _element0;
}

Buffer10<int> buffer = default;
for (int i = 0; i < 10; i++)
{
    buffer[i] = i;
}

// Index operator
int last = buffer[^1];        // Last element (9)
int secondLast = buffer[^2];  // Second to last (8)

// Range operator (via span conversion)
Span<int> span = buffer;
Span<int> slice = span[2..7];  // Elements 2-6
Span<int> fromStart = span[..5];  // First 5 elements
Span<int> toEnd = span[5..];   // Elements 5-9
```
