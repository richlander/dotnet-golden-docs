# Inline Arrays
## Best Practices
### Stack-Allocated Work Buffers

**When to use**: Temporary buffers for processing without heap allocations.

```csharp
public static class StringProcessor
{
    public static string Reverse(string input)
    {
        if (input.Length > 128)
            throw new ArgumentException("String too long");

        [InlineArray(128)]
        struct CharBuffer
        {
            private char _element0;
        }

        CharBuffer buffer = default;
        Span<char> span = buffer;
        input.AsSpan().CopyTo(span);
        
        span[..input.Length].Reverse();
        return new string(span[..input.Length]);
    }
}

// Usage
string reversed = StringProcessor.Reverse("Hello");
Console.WriteLine(reversed);  // "olleH"
```

**Considerations**: Stack allocation is fast but limited in size. Use for small, temporary buffers only.

## Best Practices

### Choose Appropriate Buffer Sizes

Size inline arrays based on expected usage:

```csharp
// Good: Common sizes for typical use cases
[InlineArray(8)]   // Small buffer - good for stack allocation
public struct SmallBuffer { private byte _element0; }

[InlineArray(32)]  // Medium buffer - names, small strings
public struct MediumBuffer { private char _element0; }

[InlineArray(128)] // Larger buffer - temporary work space
public struct WorkBuffer { private byte _element0; }

// Avoid: Extremely large inline arrays
[InlineArray(10000)]  // Too large for stack, defeats purpose
public struct HugeBuffer { private int _element0; }
```

Keep inline arrays small enough for stack allocation (typically < 512 bytes).

### Use Span for Iteration

Convert to span for efficient element access and iteration:

```csharp
[InlineArray(10)]
public struct Buffer10<T>
{
    private T _element0;
}

// Good: Convert to span for iteration
Buffer10<int> buffer = default;
Span<int> span = buffer;
for (int i = 0; i < span.Length; i++)
{
    span[i] = i * 2;
}

// Less efficient: Direct indexing in loops
for (int i = 0; i < 10; i++)
{
    buffer[i] = i * 2;  // Multiple bounds checks
}
```
