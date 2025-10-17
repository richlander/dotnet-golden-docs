# System.Text.Json.JsonSerializer
## Serializing Half, Int128, and UInt128

Serialize new numeric types.

```csharp
public class NumericData
{
    public Half HalfValue { get; set; }
    public Int128 LargeInt { get; set; }
    public UInt128 LargeUInt { get; set; }
}

var data = new NumericData
{
    HalfValue = (Half)3.14,
    LargeInt = Int128.Parse("170141183460469231731687303715884105727"),
    LargeUInt = UInt128.Parse("340282366920938463463374607431768211455")
};

string json = JsonSerializer.Serialize(data);
// {"HalfValue":3.14,"LargeInt":170141183460469231731687303715884105727,"LargeUInt":340282366920938463463374607431768211455}

NumericData? deserialized = JsonSerializer.Deserialize<NumericData>(json);
```

## Serializing Memory and ReadOnlyMemory

Serialize memory types efficiently.

```csharp
public class MemoryData
{
    public Memory<byte> ByteMemory { get; set; }
    public Memory<int> IntMemory { get; set; }
    public ReadOnlyMemory<byte> ReadOnlyBytes { get; set; }
}

var data = new MemoryData
{
    ByteMemory = new byte[] { 1, 2, 3, 4 },
    IntMemory = new int[] { 10, 20, 30 },
    ReadOnlyBytes = new byte[] { 255, 254, 253 }
};

string json = JsonSerializer.Serialize(data);
// {"ByteMemory":"AQIDBA==","IntMemory":[10,20,30],"ReadOnlyBytes":"//79"}
// Note: byte Memory serializes as Base64, other types as arrays

MemoryData? deserialized = JsonSerializer.Deserialize<MemoryData>(json);
```

## Using with PipeReader and PipeWriter

Serialize and deserialize directly with System.IO.Pipelines.

```csharp
using System.IO.Pipelines;

public async Task SerializeToPipeAsync<T>(PipeWriter writer, T value)
{
    await JsonSerializer.SerializeAsync(writer, value);
    await writer.CompleteAsync();
}

public async Task<T?> DeserializeFromPipeAsync<T>(PipeReader reader)
{
    T? result = await JsonSerializer.DeserializeAsync<T>(reader);
    await reader.CompleteAsync();
    return result;
}

// Usage with Pipe
var pipe = new Pipe();

var user = new User { Id = 1, Name = "Alice" };
await SerializeToPipeAsync(pipe.Writer, user);

User? deserialized = await DeserializeFromPipeAsync<User>(pipe.Reader);

// Efficient for network protocols and high-performance scenarios
```
