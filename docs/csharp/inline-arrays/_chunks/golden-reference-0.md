# Inline Arrays

## Overview

Inline arrays provide a type-safe and ref-safe mechanism for creating fixed-size sequential data structures using the `InlineArrayAttribute`. Introduced in C# 12, inline arrays enable developers to create custom buffer types with compile-time known sizes, offering a safe alternative to unsafe fixed-size buffers while maintaining performance characteristics similar to arrays with full GC tracking and bounds checking.

Inline arrays eliminate the need for unsafe code when working with fixed-size buffers, making high-performance scenarios more accessible. They integrate seamlessly with `Span<T>` and `ReadOnlySpan<T>`, supporting efficient element access through indexers and slicing operations. The compiler and runtime work together to provide zero-overhead access patterns while maintaining safety guarantees.

```csharp
using System.Runtime.CompilerServices;

// Define an inline array with 10 elements
[InlineArray(10)]
public struct Buffer10<T>
{
    private T _element0;
}

// Use the inline array
Buffer10<int> buffer = default;
buffer[0] = 42;
buffer[9] = 100;

// Works with Span<T>
Span<int> span = buffer;
for (int i = 0; i < span.Length; i++)
{
    Console.WriteLine(span[i]);
}
```

### Key Advantages

- **Type safety**: Full compile-time type checking without unsafe code
- **Bounds checking**: Runtime bounds validation prevents buffer overruns
- **Span integration**: Seamless conversion to `Span<T>` and `ReadOnlySpan<T>`
- **GC tracking**: Full garbage collector support, no pinning required
- **Generic support**: Works with any type as the element type
- **Stack allocation**: Can be allocated on the stack for performance
- **Zero overhead**: Direct memory access with no indirection
