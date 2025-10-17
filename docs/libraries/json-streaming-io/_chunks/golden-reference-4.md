# JSON Streaming and I/O
## Relationships & Integration

JSON streaming integrates with several .NET features:

- **`System.IO.Pipelines`**: High-performance pipeline processing with `PipeReader`/`PipeWriter`
- **ASP.NET Core**: Streaming responses and request processing
- **`IAsyncEnumerable<T>`**: Async iteration over JSON arrays
- **`HttpClient`**: Efficient HTTP response deserialization
- **`Stream` APIs**: File, network, and memory stream processing
- **`Utf8JsonReader`/`Utf8JsonWriter`**: Low-level streaming APIs

Common integration patterns:

```csharp
using System.IO.Pipelines;
using System.Net.Http;
using System.Text.Json;

// HTTP streaming with PipeReader
async Task<MyData?> FetchFromApiAsync(HttpClient client, string url)
{
    using var response = await client.GetAsync(url, HttpCompletionOption.ResponseHeadersRead);
    using var stream = await response.Content.ReadAsStreamAsync();
    
    var pipeReader = PipeReader.Create(stream);
    return await JsonSerializer.DeserializeAsync<MyData>(pipeReader);
}

// WebSocket with JSON streaming
async Task ProcessWebSocketMessagesAsync(WebSocket webSocket)
{
    var pipe = new Pipe();
    
    var readTask = Task.Run(async () =>
    {
        var buffer = new byte[4096];
        while (webSocket.State == WebSocketState.Open)
        {
            var result = await webSocket.ReceiveAsync(buffer, CancellationToken.None);
            await pipe.Writer.WriteAsync(buffer.AsMemory(0, result.Count));
            
            if (result.EndOfMessage)
            {
                await pipe.Writer.FlushAsync();
            }
        }
        await pipe.Writer.CompleteAsync();
    });
    
    await foreach (var message in JsonSerializer
        .DeserializeAsyncEnumerable<ChatMessage>(pipe.Reader))
    {
        if (message != null)
        {
            await ProcessChatMessageAsync(message);
        }
    }
}

record MyData(string Name, int Value);
record ChatMessage(string User, string Text, DateTime Timestamp);
```

## Large File Processing

Handle multi-gigabyte JSON files efficiently:

```csharp
using System.Text.Json;

async Task ProcessLargeDatasetAsync(string filePath)
{
    using var stream = new FileStream(
        filePath,
        FileMode.Open,
        FileAccess.Read,
        FileShare.Read,
        bufferSize: 81920,  // 80KB buffer
        useAsync: true
    );

    long recordsProcessed = 0;
    long totalBytes = 0;

    await foreach (var record in JsonSerializer
        .DeserializeAsyncEnumerable<LargeRecord>(stream))
    {
        if (record != null)
        {
            await ProcessRecordAsync(record);
            
            recordsProcessed++;
            if (recordsProcessed % 10000 == 0)
            {
                Console.WriteLine($"Processed {recordsProcessed:N0} records");
            }
        }
    }

    Console.WriteLine($"Complete: {recordsProcessed:N0} total records");
}

record LargeRecord(
    int Id, 
    string Data, 
    Dictionary<string, object> Metadata
);
```
