# System.Text.Json - What's New in .NET 10
## Performance Considerations

### Strict Options

Strict validation has minimal performance overhead:

- Duplicate detection: Small cost during property name comparison
- Unmapped member handling: Negligible overhead during normal deserialization
- Nullable validation: No runtime overhead
- Overall impact: < 5% in typical scenarios

The security benefits far outweigh the minimal performance cost.

### PipeReader Performance

`PipeReader` provides better performance than streams:

- **Reduced allocations**: Buffer pooling and reuse
- **Backpressure**: Automatic flow control prevents memory bloat
- **Zero-copy**: Read operations can avoid copying in many scenarios
- **Benchmark results**: 10-30% throughput improvement in streaming scenarios

Use `PipeReader` for:

- High-throughput APIs
- Real-time data processing
- WebSocket or SignalR JSON payloads
- Large file processing

## ReferenceHandler in Source Generation

Specify `ReferenceHandler` in source generation to handle circular references:

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

// Object with circular reference
SelfReference selfRef = new SelfReference();
selfRef.Me = selfRef;

// Serialize with generated context that preserves references
Console.WriteLine(JsonSerializer.Serialize(
    selfRef, 
    ContextWithPreserveReference.Default.SelfReference));
// Output: {"$id":"1","Me":{"$ref":"1"}}

// Configure ReferenceHandler in source generation options
[JsonSourceGenerationOptions(ReferenceHandler = JsonKnownReferenceHandler.Preserve)]
[JsonSerializable(typeof(SelfReference))]
internal partial class ContextWithPreserveReference : JsonSerializerContext
{
}

internal class SelfReference
{
    public SelfReference? Me { get; set; }
}
```

Available `ReferenceHandler` options:

- `JsonKnownReferenceHandler.Preserve` - Preserve object references (handles cycles)
- `JsonKnownReferenceHandler.IgnoreCycles` - Ignore circular references (write null)

This feature brings source generation to parity with runtime serialization for reference handling.
