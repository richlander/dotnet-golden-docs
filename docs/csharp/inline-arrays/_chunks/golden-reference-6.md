# Inline Arrays
## Common Scenarios
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
