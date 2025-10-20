# Inline Arrays
## See Also
### Size Considerations

Large inline arrays can cause stack overflow when stack-allocated:

```csharp
[InlineArray(10000)]
public struct HugeBuffer
{
    private int _element0;  // 40KB buffer
}

public void ProcessData()
{
    HugeBuffer buffer = default;  // Stack overflow risk!
}

// Better: Allocate on heap for large sizes
public class LargeBufferWrapper
{
    private HugeBuffer _buffer;  // Heap allocated
}
```

Keep stack-allocated inline arrays under 512 bytes to avoid stack overflow.

### No Dynamic Sizing

Inline array size must be known at compile time:

```csharp
// Error: Cannot use runtime value
public struct DynamicBuffer
{
    public static int Size { get; set; } = 10;
    
    [InlineArray(Size)]  // Error: Not a constant
    public struct Buffer
    {
        private int _element0;
    }
}

// Use arrays or Span<T> for dynamic sizing
public void ProcessData(int size)
{
    Span<int> buffer = size <= 128 
        ? stackalloc int[size]
        : new int[size];
}
```

## See Also

- **Span&lt;T&gt; and ReadOnlySpan&lt;T&gt;**: Primary types for working with inline arrays
- **InlineArrayAttribute**: The attribute that enables inline array behavior
- **unsafe fixed buffers**: The unsafe feature that inline arrays replace
- **stackalloc**: Stack allocation keyword, useful with spans
- **System.Runtime.InteropServices**: Interop features that work with inline arrays
- **SIMD operations**: Vector operations that benefit from inline arrays
- **Memory&lt;T&gt;**: Managed memory abstraction that complements inline arrays
- **ArrayPool&lt;T&gt;**: Alternative for reusable buffers with dynamic sizing

