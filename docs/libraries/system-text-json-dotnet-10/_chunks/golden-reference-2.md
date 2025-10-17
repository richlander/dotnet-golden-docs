# System.Text.Json - What's New in .NET 10
## PipeReader Support

Deserialize JSON directly from `PipeReader` for high-performance pipeline scenarios:

```csharp
using System.IO.Pipelines;
using System.Text.Json;

async Task ProcessJsonPipelineAsync(PipeReader reader)
{
    MyData? data = await JsonSerializer.DeserializeAsync<MyData>(reader);
    
    if (data != null)
    {
        ProcessData(data);
    }
}

record MyData(string Name, int Value);
```

This is particularly useful for streaming scenarios:

```csharp
using System.IO.Pipelines;
using System.Text.Json;

// Producer writes JSON to pipe
async Task ProduceAsync(PipeWriter writer)
{
    for (int i = 0; i < 100; i++)
    {
        var message = new Message($"Item {i}", DateTime.UtcNow);
        await JsonSerializer.SerializeAsync(writer, message);
        await writer.FlushAsync();
    }
    await writer.CompleteAsync();
}

// Consumer reads JSON from pipe
async Task ConsumeAsync(PipeReader reader)
{
    await foreach (var message in JsonSerializer
        .DeserializeAsyncEnumerable<Message>(reader))
    {
        if (message != null)
        {
            Console.WriteLine($"{message.Text} at {message.Timestamp}");
        }
    }
    await reader.CompleteAsync();
}

var pipe = new Pipe();
await Task.WhenAll(
    ProduceAsync(pipe.Writer),
    ConsumeAsync(pipe.Reader)
);

record Message(string Text, DateTime Timestamp);
```

`PipeReader` provides better performance than streams in high-throughput scenarios due to:

- Reduced buffer allocations
- Built-in backpressure handling
- Efficient memory pooling
- Zero-copy reads when possible

## Combining New Features

Use multiple .NET 10 features together for secure, high-performance JSON processing:

```csharp
using System.IO.Pipelines;
using System.Text.Json;
using System.Text.Json.Serialization;

async Task SecurelyProcessApiStreamAsync(PipeReader reader)
{
    // Use source generation with strict validation and PipeReader streaming
    await foreach (var item in JsonSerializer
        .DeserializeAsyncEnumerable(reader, ApiJsonContext.Default.ApiRequest))
    {
        if (item != null)
        {
            // All validation passed
            await ProcessSecureRequestAsync(item);
        }
    }
}

// Configure source generation with all .NET 10 validation features
[JsonSourceGenerationOptions(
    AllowDuplicateProperties = false,
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow,
    RespectNullableAnnotations = true,
    ReferenceHandler = JsonKnownReferenceHandler.Preserve
)]
[JsonSerializable(typeof(ApiRequest))]
internal partial class ApiJsonContext : JsonSerializerContext
{
}

record ApiRequest(string Id, string Action, Dictionary<string, string> Metadata);
```

This approach provides:

- **Security**: Strict validation with duplicate detection and unmapped member handling
- **Performance**: `PipeReader` streaming with zero-copy reads
- **AOT compatibility**: Source generation eliminates reflection
- **Circular reference support**: `ReferenceHandler` handles object graphs
