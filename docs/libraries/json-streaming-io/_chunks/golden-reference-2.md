# JSON Streaming and I/O
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
