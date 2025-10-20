# Inline Arrays
## Common Scenarios
### Lookup Tables

**When to use**: Create efficient lookup tables for fast transformations.

```csharp
[InlineArray(256)]
public struct HexCharLookup
{
    private char _element0;
}

public class HexConverter
{
    private static HexCharLookup _hexChars;

    static HexConverter()
    {
        Span<char> chars = _hexChars;
        for (int i = 0; i < 16; i++)
        {
            chars[i] = "0123456789ABCDEF"[i];
        }
    }

    public static void ToHex(byte value, Span<char> output)
    {
        ReadOnlySpan<char> lookup = _hexChars;
        output[0] = lookup[value >> 4];
        output[1] = lookup[value & 0x0F];
    }
}

// Usage
Span<char> hex = stackalloc char[2];
HexConverter.ToHex(0xAB, hex);
Console.WriteLine(hex);  // "AB"
```

**Considerations**: Inline array lookup tables are cache-friendly and avoid heap allocations.

### Ring Buffers

**When to use**: Implement fixed-size circular buffers for streaming data.

```csharp
[InlineArray(8)]
public struct RingBuffer<T>
{
    private T _element0;
}

public struct CircularBuffer<T>
{
    private RingBuffer<T> _buffer;
    private int _head;
    private int _tail;
    private int _count;
    private const int Capacity = 8;

    public void Enqueue(T item)
    {
        if (_count == Capacity)
            throw new InvalidOperationException("Buffer full");

        Span<T> buffer = _buffer;
        buffer[_tail] = item;
        _tail = (_tail + 1) % Capacity;
        _count++;
    }

    public T Dequeue()
    {
        if (_count == 0)
            throw new InvalidOperationException("Buffer empty");

        Span<T> buffer = _buffer;
        T item = buffer[_head];
        _head = (_head + 1) % Capacity;
        _count--;
        return item;
    }

    public bool TryDequeue(out T item)
    {
        if (_count == 0)
        {
            item = default;
            return false;
        }
        item = Dequeue();
        return true;
    }
}

// Usage
CircularBuffer<int> buffer = default;
buffer.Enqueue(1);
buffer.Enqueue(2);
buffer.Enqueue(3);

if (buffer.TryDequeue(out int value))
{
    Console.WriteLine(value);  // 1
}
```

**Considerations**: Ring buffers with inline arrays are stack-allocatable and cache-efficient for small buffer sizes.
