# Inline Arrays
## Best Practices
### Provide Span Accessors

Expose span views of inline array fields:

```csharp
public struct FixedString32
{
    [InlineArray(32)]
    private struct CharBuffer
    {
        private char _element0;
    }

    private CharBuffer _buffer;
    private int _length;

    // Good: Provide span accessors
    public ReadOnlySpan<char> AsSpan() => ((ReadOnlySpan<char>)_buffer)[.._length];
    public Span<char> AsWriteableSpan() => ((Span<char>)_buffer)[.._length];

    public void Append(ReadOnlySpan<char> text)
    {
        int available = 32 - _length;
        int toCopy = Math.Min(text.Length, available);
        text[..toCopy].CopyTo(AsWriteableSpan()[_length..]);
        _length += toCopy;
    }
}
```

### Initialize with Default Values

Use span operations for efficient initialization:

```csharp
[InlineArray(16)]
public struct InitializedBuffer
{
    private int _element0;
}

// Good: Initialize with span operations
InitializedBuffer buffer = default;
Span<int> span = buffer;
span.Fill(42);  // All elements set to 42

// Or initialize specific pattern
for (int i = 0; i < span.Length; i++)
{
    span[i] = i;
}
```

### Consider Generic Constraints

Design inline array wrappers with appropriate generic constraints:

```csharp
// Good: Constraint ensures struct semantics
[InlineArray(8)]
public struct ValueBuffer<T> where T : struct
{
    private T _element0;
}

// Usage with value types
ValueBuffer<int> ints = default;
ValueBuffer<Guid> guids = default;

// Won't compile with reference types
// ValueBuffer<string> strings = default;  // Error!
```

### Bounds Check Once

Use span slicing to avoid repeated bounds checks:

```csharp
[InlineArray(100)]
public struct LargeBuffer
{
    private byte _element0;
}

// Good: Bounds check once with span
LargeBuffer buffer = default;
Span<byte> span = buffer;
Span<byte> region = span[10..20];  // Single bounds check
for (int i = 0; i < region.Length; i++)
{
    region[i] = (byte)i;  // No bounds check inside loop
}

// Less efficient: Multiple bounds checks
for (int i = 10; i < 20; i++)
{
    buffer[i] = (byte)(i - 10);  // Bounds check on each access
}
```
