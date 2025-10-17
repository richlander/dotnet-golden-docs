# JSON Streaming and I/O
## PipeReader Deserialization

Deserialize JSON directly from `PipeReader` for efficient pipeline processing:

```csharp
using System.IO.Pipelines;
using System.Text.Json;

async Task ProcessJsonPipelineAsync(PipeReader reader)
{
    // Deserialize directly from PipeReader
    MyData? data = await JsonSerializer.DeserializeAsync<MyData>(reader);
    
    if (data != null)
    {
        ProcessData(data);
    }
}

record MyData(string Name, int Value, DateTime Timestamp);
```

This is particularly useful with chunked data:

```csharp
using System.IO.Pipelines;
using System.Text.Json;

async Task ProcessStreamingJsonAsync(PipeReader reader)
{
    try
    {
        // Process JSON as it arrives in chunks
        var messages = JsonSerializer.DeserializeAsyncEnumerable<Message>(
            reader,
            new JsonSerializerOptions { DefaultBufferSize = 4096 }
        );

        await foreach (var message in messages)
        {
            if (message != null)
            {
                await ProcessMessageAsync(message);
            }
        }
    }
    finally
    {
        await reader.CompleteAsync();
    }
}

record Message(string Id, string Content, DateTime Timestamp);
```

## Producer-Consumer Pipeline

Build efficient producer-consumer patterns with JSON and pipes:

```csharp
using System.IO.Pipelines;
using System.Text.Json;

// Producer: Write JSON to pipe
async Task ProduceMessagesAsync(PipeWriter writer, CancellationToken ct)
{
    try
    {
        for (int i = 0; i < 100; i++)
        {
            if (ct.IsCancellationRequested) break;

            var message = new Message(
                Id: Guid.NewGuid().ToString(),
                Content: $"Message {i}",
                Timestamp: DateTime.UtcNow
            );

            // Serialize to pipe
            await JsonSerializer.SerializeAsync(writer, message, ct);
            await writer.FlushAsync(ct);
            
            await Task.Delay(100, ct);  // Simulate work
        }
    }
    finally
    {
        await writer.CompleteAsync();
    }
}

// Consumer: Read JSON from pipe
async Task ConsumeMessagesAsync(PipeReader reader, CancellationToken ct)
{
    try
    {
        await foreach (var message in JsonSerializer
            .DeserializeAsyncEnumerable<Message>(reader, cancellationToken: ct))
        {
            if (message != null)
            {
                Console.WriteLine($"[{message.Timestamp:T}] {message.Content}");
            }
        }
    }
    finally
    {
        await reader.CompleteAsync();
    }
}

// Wire them together
var pipe = new Pipe();
var produceTask = ProduceMessagesAsync(pipe.Writer, cancellationToken);
var consumeTask = ConsumeMessagesAsync(pipe.Reader, cancellationToken);

await Task.WhenAll(produceTask, consumeTask);

record Message(string Id, string Content, DateTime Timestamp);
```
