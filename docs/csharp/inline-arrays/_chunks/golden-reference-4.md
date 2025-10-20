# Inline Arrays
## Common Scenarios
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
