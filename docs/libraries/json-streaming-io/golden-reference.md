# JSON Streaming and I/O

## Overview

JSON streaming and I/O capabilities in `System.Text.Json` enable efficient processing of JSON data from various sources including streams, pipes, and asynchronous operations. These features allow you to work with large JSON documents, real-time data streams, and high-throughput scenarios without loading entire documents into memory. By leveraging streaming, async patterns, and modern I/O types like `PipeReader`, you can build performant applications that handle JSON efficiently.

Key streaming and I/O capabilities include:

- **`PipeReader` support**: Deserialize JSON directly from `PipeReader` for high-performance pipeline scenarios
- **Stream-based serialization**: Read and write JSON incrementally using streams
- **Async patterns**: Asynchronous serialization and deserialization for non-blocking I/O
- **Large document handling**: Process JSON documents too large to fit in memory
- **UTF-8 direct processing**: Work with UTF-8 encoded JSON without string conversions
- **Memory-efficient parsing**: Minimize allocations through streaming APIs

These features are particularly valuable when:

1. Processing large JSON files or streams
2. Building high-throughput APIs or services
3. Working with real-time data pipelines
4. Implementing WebSocket or SignalR services with JSON payloads
5. Optimizing memory usage in memory-constrained environments

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

## Stream-Based Serialization

Work with streams for large JSON documents:

```csharp
using System.Text.Json;

// Write large JSON to stream
async Task WriteJsonToStreamAsync(Stream stream, IEnumerable<Record> records)
{
    using var writer = new Utf8JsonWriter(stream);
    
    writer.WriteStartArray();
    
    foreach (var record in records)
    {
        JsonSerializer.Serialize(writer, record);
    }
    
    writer.WriteEndArray();
    await writer.FlushAsync();
}

// Read large JSON from stream incrementally
async Task<List<Record>> ReadJsonFromStreamAsync(Stream stream)
{
    var records = new List<Record>();
    
    // Deserialize asynchronously
    var enumerable = JsonSerializer.DeserializeAsyncEnumerable<Record>(stream);
    
    await foreach (var record in enumerable)
    {
        if (record != null)
        {
            records.Add(record);
        }
    }
    
    return records;
}

record Record(int Id, string Name, decimal Value);
```

## Async File Processing

Process JSON files asynchronously:

```csharp
using System.Text.Json;

// Read JSON file asynchronously
async Task<MyData?> ReadJsonFileAsync(string path)
{
    using FileStream stream = File.OpenRead(path);
    return await JsonSerializer.DeserializeAsync<MyData>(stream);
}

// Write JSON file asynchronously
async Task WriteJsonFileAsync(string path, MyData data)
{
    using FileStream stream = File.Create(path);
    await JsonSerializer.SerializeAsync(stream, data, new JsonSerializerOptions 
    { 
        WriteIndented = true 
    });
}

// Process large JSON file without loading it all into memory
async Task ProcessLargeJsonFileAsync(string path)
{
    using FileStream stream = File.OpenRead(path);
    
    await foreach (var item in JsonSerializer
        .DeserializeAsyncEnumerable<DataItem>(stream))
    {
        if (item != null)
        {
            await ProcessItemAsync(item);
        }
    }
}

record MyData(string Name, List<DataItem> Items);
record DataItem(int Id, string Value);
```

## HTTP Response Streaming

Stream JSON responses in ASP.NET Core:

```csharp
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

[ApiController]
[Route("api/[controller]")]
public class DataController : ControllerBase
{
    // Stream large dataset as JSON
    [HttpGet("stream")]
    public async IAsyncEnumerable<DataItem> StreamData(
        [EnumeratorCancellation] CancellationToken ct)
    {
        await foreach (var item in _repository.GetDataAsync(ct))
        {
            yield return item;
        }
    }

    // Write directly to response body
    [HttpGet("direct")]
    public async Task StreamDirectly()
    {
        Response.ContentType = "application/json";
        
        using var writer = new Utf8JsonWriter(Response.Body);
        writer.WriteStartArray();
        
        await foreach (var item in _repository.GetDataAsync(HttpContext.RequestAborted))
        {
            JsonSerializer.Serialize(writer, item);
            await writer.FlushAsync();
        }
        
        writer.WriteEndArray();
        await writer.FlushAsync();
    }
}

record DataItem(int Id, string Name, DateTime Created);
```

## UTF-8 Direct Processing

Work with UTF-8 JSON without string conversions:

```csharp
using System.Text.Json;

// Read UTF-8 JSON directly
async Task<MyData?> ReadUtf8JsonAsync(byte[] utf8Json)
{
    return await JsonSerializer.DeserializeAsync<MyData>(
        new MemoryStream(utf8Json)
    );
}

// Write UTF-8 JSON directly
async Task<byte[]> WriteUtf8JsonAsync(MyData data)
{
    using var stream = new MemoryStream();
    await JsonSerializer.SerializeAsync(stream, data);
    return stream.ToArray();
}

// Process UTF-8 JSON from network
async Task ProcessNetworkJsonAsync(HttpClient client, string url)
{
    using var response = await client.GetAsync(url, HttpCompletionOption.ResponseHeadersRead);
    using var stream = await response.Content.ReadAsStreamAsync();
    
    // Deserialize UTF-8 directly without string conversion
    var data = await JsonSerializer.DeserializeAsync<MyData>(stream);
    ProcessData(data);
}

record MyData(string Name, int Value);
```

## Memory-Efficient Parsing

Parse large JSON with minimal memory:

```csharp
using System.Text.Json;

// Parse incrementally using JsonDocument
async Task ParseLargeDocumentAsync(Stream stream)
{
    using var document = await JsonDocument.ParseAsync(stream);
    
    var root = document.RootElement;
    
    if (root.TryGetProperty("items", out JsonElement items))
    {
        foreach (JsonElement item in items.EnumerateArray())
        {
            // Process each item without loading entire document
            if (item.TryGetProperty("id", out JsonElement id))
            {
                Console.WriteLine($"Processing item {id.GetInt32()}");
            }
        }
    }
}

// Use Utf8JsonReader for lowest-level, most efficient parsing
void ParseWithReader(ReadOnlySpan<byte> utf8Json)
{
    var reader = new Utf8JsonReader(utf8Json);
    
    while (reader.Read())
    {
        switch (reader.TokenType)
        {
            case JsonTokenType.PropertyName:
                string propertyName = reader.GetString() ?? "";
                break;
                
            case JsonTokenType.String:
                string value = reader.GetString() ?? "";
                ProcessValue(value);
                break;
                
            case JsonTokenType.Number:
                int number = reader.GetInt32();
                ProcessNumber(number);
                break;
        }
    }
}
```

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

## Performance Characteristics

JSON streaming provides significant performance benefits:

### Memory Efficiency
- **Stream deserialization**: Processes data incrementally, avoiding large allocations
- **`PipeReader` support**: Minimal buffering with pipeline semantics
- **UTF-8 processing**: No UTF-16 string conversion overhead
- **Async enumeration**: Processes one item at a time from arrays

### Throughput
- **Async I/O**: Non-blocking operations for high concurrency
- **Pipelining**: Producer and consumer can run concurrently
- **Buffer tuning**: Configurable buffer sizes for optimal throughput
- **Direct stream writing**: `Utf8JsonWriter` writes directly to streams

### Scalability
- **Constant memory**: Memory usage independent of JSON size
- **Cancellation support**: Graceful cancellation of long-running operations
- **Backpressure**: `PipeReader`/`PipeWriter` handle flow control automatically

## Best Practices

1. **Use async APIs**: Prefer `DeserializeAsync` over `Deserialize` for I/O operations
2. **Stream large documents**: Don't load large JSON into memory; use streaming APIs
3. **Configure buffer sizes**: Tune `DefaultBufferSize` based on your data patterns
4. **Use `IAsyncEnumerable<T>`**: For processing JSON arrays incrementally
5. **Leverage `PipeReader` for pipelines**: Maximum efficiency for streaming scenarios
6. **Handle cancellation**: Support cancellation tokens for responsive applications
7. **UTF-8 all the way**: Avoid string conversions when working with UTF-8 sources

## Migration & Compatibility

### Adopting Streaming APIs

Migrating from synchronous to streaming:

```csharp
// Before: Load entire file into memory
string json = await File.ReadAllTextAsync("data.json");
var data = JsonSerializer.Deserialize<List<Item>>(json);

// After: Stream from file
using var stream = File.OpenRead("data.json");
var items = new List<Item>();
await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<Item>(stream))
{
    if (item != null)
    {
        items.Add(item);
    }
}
```

### Using PipeReader

Migrating from streams to pipes:

```csharp
// Before: Stream-based
using var stream = GetDataStream();
var data = await JsonSerializer.DeserializeAsync<MyData>(stream);

// After: PipeReader-based
var pipeReader = PipeReader.Create(GetDataStream());
var data = await JsonSerializer.DeserializeAsync<MyData>(pipeReader);
```

**Version requirements**:
- `PipeReader` support: .NET 10+
- `DeserializeAsync` with `Stream`: .NET Core 3.0+
- `DeserializeAsyncEnumerable`: .NET Core 3.0+
- `IAsyncEnumerable<T>`: C# 8 (.NET Core 3.0+)
- `Utf8JsonReader`/`Utf8JsonWriter`: .NET Core 3.0+

## Related Topics

- **`System.IO.Pipelines`**: High-performance I/O pipelines
- **`System.Text.Json` serialization**: Core JSON serialization concepts
- **Async streams (`IAsyncEnumerable<T>`)**: Asynchronous iteration patterns
- **ASP.NET Core streaming**: HTTP streaming and SignalR
- **`Span<T>` and `Memory<T>`**: Memory-efficient buffer operations
