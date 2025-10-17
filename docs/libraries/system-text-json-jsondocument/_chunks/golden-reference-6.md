# System.Text.Json.JsonDocument
## Using with Response Filtering

Filter API responses before deserialization based on metadata.

```csharp
public async Task<List<Article>> GetRecentArticles(HttpClient client, int maxDays)
{
    var response = await client.GetAsync("/api/articles");
    await using Stream stream = await response.Content.ReadAsStreamAsync();
    
    using JsonDocument doc = await JsonDocument.ParseAsync(stream);
    JsonElement root = doc.RootElement;
    JsonElement articles = root.GetProperty("articles");
    
    DateTime cutoff = DateTime.UtcNow.AddDays(-maxDays);
    var recentArticles = new List<Article>();
    
    // Filter before deserializing individual articles
    foreach (JsonElement articleElement in articles.EnumerateArray())
    {
        DateTime published = articleElement
            .GetProperty("publishedAt")
            .GetDateTime();
        
        if (published >= cutoff)
        {
            // Only deserialize recent articles
            string articleJson = articleElement.GetRawText();
            Article article = JsonSerializer.Deserialize<Article>(articleJson)!;
            recentArticles.Add(article);
        }
    }
    
    return recentArticles;
}
```

## Using with Streaming Large Files

Combine JsonDocument with streaming to process large files incrementally.

```csharp
public async Task ProcessLargeJsonFile(string filePath)
{
    await using FileStream stream = File.OpenRead(filePath);
    using JsonDocument doc = await JsonDocument.ParseAsync(stream);
    JsonElement root = doc.RootElement;
    
    // Document is parsed, but can process incrementally
    JsonElement records = root.GetProperty("records");
    
    int count = 0;
    foreach (JsonElement record in records.EnumerateArray())
    {
        // Process one record at a time
        await ProcessRecord(record);
        count++;
        
        if (count % 1000 == 0)
        {
            Console.WriteLine($"Processed {count} records");
        }
    }
}

// For truly massive files, use Utf8JsonReader instead
// JsonDocument loads entire document into memory
```

## Writing JSON from JsonElement

Write JsonElement values to a stream or string.

```csharp
using JsonDocument doc = JsonDocument.Parse(originalJson);
JsonElement root = doc.RootElement;

// Write element to string (formatted)
var options = new JsonSerializerOptions { WriteIndented = true };
string formatted = JsonSerializer.Serialize(root, options);

// Write element to stream
await using var stream = File.Create("output.json");
await JsonSerializer.SerializeAsync(stream, root, options);

// Write specific element
JsonElement settings = root.GetProperty("settings");
string settingsJson = JsonSerializer.Serialize(settings, options);
```
