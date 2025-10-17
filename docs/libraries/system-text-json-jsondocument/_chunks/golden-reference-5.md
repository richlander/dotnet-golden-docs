# System.Text.Json.JsonDocument
## Using with Conditional Deserialization

Check JSON structure before committing to full deserialization.

```csharp
public async Task<IActionResult> ProcessRequest(string jsonPayload)
{
    using JsonDocument doc = JsonDocument.Parse(jsonPayload);
    JsonElement root = doc.RootElement;
    
    // Check version field
    if (!root.TryGetProperty("version", out JsonElement versionElement))
    {
        return BadRequest("Missing version field");
    }
    
    int version = versionElement.GetInt32();
    
    // Deserialize using version-specific type
    return version switch
    {
        1 => ProcessV1(JsonSerializer.Deserialize<RequestV1>(jsonPayload)!),
        2 => ProcessV2(JsonSerializer.Deserialize<RequestV2>(jsonPayload)!),
        3 => ProcessV3(JsonSerializer.Deserialize<RequestV3>(jsonPayload)!),
        _ => BadRequest($"Unsupported version: {version}")
    };
}
```

## Using with Configuration Validation

Validate configuration files without loading into strongly-typed objects.

```csharp
public bool ValidateConfiguration(string configJson)
{
    using JsonDocument doc = JsonDocument.Parse(configJson);
    JsonElement root = doc.RootElement;
    
    // Check required sections exist
    if (!root.TryGetProperty("Database", out JsonElement db))
    {
        Console.WriteLine("Missing Database section");
        return false;
    }
    
    if (!db.TryGetProperty("ConnectionString", out JsonElement connStr))
    {
        Console.WriteLine("Missing ConnectionString");
        return false;
    }
    
    if (connStr.GetString()?.Length == 0)
    {
        Console.WriteLine("ConnectionString is empty");
        return false;
    }
    
    // Validate optional sections
    if (root.TryGetProperty("Logging", out JsonElement logging))
    {
        if (!logging.TryGetProperty("LogLevel", out JsonElement logLevel))
        {
            Console.WriteLine("Warning: Logging section missing LogLevel");
        }
    }
    
    // Check for duplicate properties (requires enumeration)
    var propertyNames = new HashSet<string>();
    foreach (JsonProperty property in root.EnumerateObject())
    {
        if (!propertyNames.Add(property.Name))
        {
            Console.WriteLine($"Duplicate property: {property.Name}");
            return false;
        }
    }
    
    return true;
}
```

## Using with Metadata Extraction

Extract specific metadata fields from large JSON documents without parsing everything.

```csharp
public async Task<DocumentMetadata> ExtractMetadata(Stream documentStream)
{
    using JsonDocument doc = await JsonDocument.ParseAsync(documentStream);
    JsonElement root = doc.RootElement;
    
    // Extract only needed fields
    string id = root.GetProperty("id").GetString()!;
    string title = root.GetProperty("title").GetString()!;
    DateTime created = root.GetProperty("createdAt").GetDateTime();
    
    // Count items without deserializing them
    int itemCount = 0;
    if (root.TryGetProperty("items", out JsonElement items))
    {
        itemCount = items.GetArrayLength();
    }
    
    // Check for specific flags
    bool isArchived = root.TryGetProperty("archived", out JsonElement archived) 
        && archived.GetBoolean();
    
    return new DocumentMetadata
    {
        Id = id,
        Title = title,
        CreatedAt = created,
        ItemCount = itemCount,
        IsArchived = isArchived
    };
}

public record DocumentMetadata
{
    public string Id { get; init; } = string.Empty;
    public string Title { get; init; } = string.Empty;
    public DateTime CreatedAt { get; init; }
    public int ItemCount { get; init; }
    public bool IsArchived { get; init; }
}
```
