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

### Main Approaches

**As struct fields**: Embed fixed-size buffers directly in types
- Use inline arrays as struct fields for known-size data
- Replace unsafe fixed buffers with safe inline arrays
- Create efficient data structures with embedded buffers

**With Span conversion**: Convert to spans for flexible access
- Convert inline arrays to `Span<T>` for unified processing
- Use span indexers and slicing for element access
- Pass inline arrays as spans to avoid copying

**Stack allocated buffers**: Create temporary buffers without heap allocation
- Allocate inline arrays on the stack with `stackalloc`-like patterns
- Process fixed-size data without GC pressure
- Use for temporary buffers in performance-critical code

### When to Use

Use inline arrays when:
- You need a fixed-size buffer with known length at compile time
- You want type safety without using unsafe code
- You're replacing unsafe fixed-size buffers with safe alternatives
- You need efficient interop with native code requiring fixed layouts
- You want to embed small buffers directly in structs
- Performance matters and you want to avoid heap allocations

Avoid inline arrays when:
- The buffer size is only known at runtime (use `Span<T>` or arrays instead)
- You need dynamic resizing (use `List<T>` or `ArrayPool<T>`)
- The buffer is very large (consider heap allocation)
- You're targeting older runtimes that don't support inline arrays (requires .NET 8+)

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

### Unsafe Code Replacement

Inline arrays replace unsafe fixed buffers:

```csharp
// Old unsafe approach
public unsafe struct UnsafeBuffer
{
    public fixed byte Data[16];
}

// New safe approach with inline arrays
[InlineArray(16)]
public struct SafeBuffer
{
    private byte _element0;
}

// Usage is safer and doesn't require unsafe
SafeBuffer buffer = default;
buffer[0] = 0xFF;  // No unsafe keyword needed
Span<byte> span = buffer;  // Safe conversion
```

### Interop Scenarios

Inline arrays work well for interop with fixed-size native buffers:

```csharp
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

[InlineArray(4)]
public struct IPv4Address
{
    private byte _element0;
}

[StructLayout(LayoutKind.Sequential)]
public struct NetworkPacket
{
    public IPv4Address SourceIP;
    public IPv4Address DestinationIP;
    public ushort SourcePort;
    public ushort DestinationPort;
}

// Use with P/Invoke
[DllImport("network.dll")]
static extern void SendPacket(ref NetworkPacket packet);

NetworkPacket packet = default;
packet.SourceIP[0] = 192;
packet.SourceIP[1] = 168;
packet.SourceIP[2] = 1;
packet.SourceIP[3] = 100;
SendPacket(ref packet);
```

### Performance Patterns

Use inline arrays for high-performance scenarios:

```csharp
[InlineArray(256)]
public struct LookupTable
{
    private byte _element0;
}

public class FastProcessor
{
    private LookupTable _lookupTable;

    public FastProcessor()
    {
        // Initialize lookup table
        Span<byte> table = _lookupTable;
        for (int i = 0; i < 256; i++)
        {
            table[i] = (byte)(i * 2);
        }
    }

    public byte Transform(byte input)
    {
        ReadOnlySpan<byte> table = _lookupTable;
        return table[input];
    }
}
```

## Common Scenarios

### Fixed-Size String Buffers

**When to use**: Embed fixed-size string storage in structs without heap allocations.

```csharp
[InlineArray(64)]
public struct CharBuffer64
{
    private char _element0;
}

public struct FixedString64
{
    private CharBuffer64 _buffer;
    private int _length;

    public int Length => _length;

    public FixedString64(ReadOnlySpan<char> value)
    {
        _length = Math.Min(value.Length, 64);
        Span<char> buffer = _buffer;
        value[.._length].CopyTo(buffer);
    }

    public ReadOnlySpan<char> AsSpan() => ((ReadOnlySpan<char>)_buffer)[.._length];

    public override string ToString() => new string(AsSpan());
}

// Usage
FixedString64 name = new FixedString64("John Doe");
Console.WriteLine($"Name: {name}, Length: {name.Length}");
```

**Considerations**: Choose buffer size based on typical string lengths. Strings exceeding the buffer size are truncated.

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

### SIMD-Friendly Buffers

**When to use**: Create buffers aligned for SIMD operations.

```csharp
using System.Runtime.Intrinsics;

[InlineArray(4)]
public struct FloatVector4
{
    private float _element0;
}

public static class VectorMath
{
    public static FloatVector4 Add(FloatVector4 a, FloatVector4 b)
    {
        Span<float> spanA = a;
        Span<float> spanB = b;
        FloatVector4 result = default;
        Span<float> spanResult = result;

        Vector128<float> vecA = Vector128.Create(spanA);
        Vector128<float> vecB = Vector128.Create(spanB);
        Vector128<float> vecResult = Vector128.Add(vecA, vecB);

        vecResult.CopyTo(spanResult);
        return result;
    }
}

// Usage
FloatVector4 v1 = default;
FloatVector4 v2 = default;
Span<float> s1 = v1;
Span<float> s2 = v2;

s1[0] = 1.0f; s1[1] = 2.0f; s1[2] = 3.0f; s1[3] = 4.0f;
s2[0] = 5.0f; s2[1] = 6.0f; s2[2] = 7.0f; s2[3] = 8.0f;

FloatVector4 result = VectorMath.Add(v1, v2);
ReadOnlySpan<float> resultSpan = result;
Console.WriteLine($"({resultSpan[0]}, {resultSpan[1]}, {resultSpan[2]}, {resultSpan[3]})");
// (6, 8, 10, 12)
```

**Considerations**: Use inline arrays sized for SIMD vectors (4, 8, 16 elements) to maximize performance.

### Network Protocol Buffers

**When to use**: Define fixed-size protocol headers and data structures.

```csharp
[InlineArray(6)]
public struct MacAddress
{
    private byte _element0;
}

[InlineArray(4)]
public struct IPv4
{
    private byte _element0;
}

[StructLayout(LayoutKind.Sequential)]
public struct EthernetHeader
{
    public MacAddress Destination;
    public MacAddress Source;
    public ushort EtherType;

    public void SetDestination(ReadOnlySpan<byte> mac)
    {
        mac.CopyTo(Destination);
    }

    public ReadOnlySpan<byte> GetDestination() => Destination;
}

// Usage
EthernetHeader header = default;
header.SetDestination([0x00, 0x11, 0x22, 0x33, 0x44, 0x55]);

ReadOnlySpan<byte> dest = header.GetDestination();
Console.WriteLine($"Destination: {dest[0]:X2}:{dest[1]:X2}:{dest[2]:X2}");
```

**Considerations**: Inline arrays with `StructLayout` provide predictable memory layout for interop and serialization.

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

## Limitations and Considerations

### Runtime and Language Version Requirements

Inline arrays require C# 12 and .NET 8 or later:

```csharp
// Requires:
// - C# 12 language version
// - .NET 8+ runtime
// - System.Runtime.CompilerServices.InlineArrayAttribute

[InlineArray(10)]  // Error if not C# 12+
public struct Buffer10
{
    private int _element0;
}
```

Older runtimes and compilers don't support inline arrays.

### Single Field Requirement

Inline array types must declare exactly one instance field:

```csharp
// Error: Multiple fields
[InlineArray(10)]
public struct InvalidBuffer
{
    private int _element0;
    private int _element1;  // Error CS9169
}

// Error: No fields
[InlineArray(10)]
public struct InvalidBuffer2
{
    // Error CS9169
}

// Correct: Single field
[InlineArray(10)]
public struct ValidBuffer
{
    private int _element0;
}
```

### No Explicit Layout

Inline arrays cannot use explicit struct layout:

```csharp
// Error: Explicit layout not allowed
[StructLayout(LayoutKind.Explicit)]
[InlineArray(10)]
public struct InvalidBuffer
{
    [FieldOffset(0)]
    private int _element0;  // Error CS9168
}

// Correct: Use sequential or auto layout
[InlineArray(10)]
public struct ValidBuffer
{
    private int _element0;
}
```

### Length Must Be Constant

The inline array length must be a constant expression greater than zero:

```csharp
// Error: Non-constant length
public struct InvalidBuffer1
{
    const int Size = GetSize();  // Not constant
    
    [InlineArray(Size)]  // Error
    public struct Buffer
    {
        private int _element0;
    }
}

// Error: Zero or negative length
[InlineArray(0)]  // Error CS9167
public struct InvalidBuffer2
{
    private int _element0;
}

[InlineArray(-1)]  // Error CS9167
public struct InvalidBuffer3
{
    private int _element0;
}

// Correct: Positive constant
[InlineArray(10)]
public struct ValidBuffer
{
    private int _element0;
}
```

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

