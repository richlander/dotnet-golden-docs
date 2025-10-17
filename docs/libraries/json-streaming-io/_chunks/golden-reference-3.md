# JSON Streaming and I/O
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
