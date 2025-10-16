# System.Text.Json
## Configuration Files

Configuration files require strict validation to catch malformed JSON early. Use `JsonSerializerOptions.Strict` when loading application configuration to reject common errors.

**Strict mode validation:**

```csharp
var options = JsonSerializerOptions.Strict;
AppConfig config;

try
{
    string configJson = await File.ReadAllTextAsync("appsettings.json");
    config = JsonSerializer.Deserialize<AppConfig>(configJson, options)
        ?? throw new InvalidOperationException("Configuration is null");
}
catch (JsonException ex)
{
    logger.LogError(ex, "Invalid configuration file");
    throw;
}
```

**What strict mode rejects:**

- Duplicate property names
- Trailing commas in arrays/objects
- Comments (`// ...` or `/* ... */`)
- Leading/trailing whitespace inconsistencies

**Configuration model:**

```csharp
public class AppConfig
{
    public DatabaseConfig Database { get; set; } = new();
    public LoggingConfig Logging { get; set; } = new();
    public required string Environment { get; set; }
}

public class DatabaseConfig
{
    public required string ConnectionString { get; set; }
    public int MaxConnections { get; set; } = 100;
}
```

Strict validation provides the first line of defense against configuration errors. Layer additional validation (required properties, value ranges) on top of JSON deserialization.

## Large File Streaming

Process large JSON arrays without loading entire files into memory using `DeserializeAsyncEnumerable<T>()`. This enables constant memory usage regardless of file size.

**Streaming arrays:**

```csharp
await using var stream = File.OpenRead("large-dataset.json");
var items = JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream);

int processedCount = 0;
await foreach (var item in items)
{
    await ProcessItemAsync(item);
    processedCount++;

    if (processedCount % 1000 == 0)
    {
        logger.LogInformation("Processed {Count} items", processedCount);
    }
}
```

**When to use streaming:**

- JSON files larger than 100MB
- Arrays with thousands of items
- ETL and data migration pipelines
- Batch processing scenarios
- Memory-constrained environments

**PipeReader integration:**

For maximum performance with custom data pipelines:

```csharp
var reader = PipeReader.Create(networkStream);
var obj = await JsonSerializer.DeserializeAsync<MyObject>(reader);
```

Streaming works with source generation for optimal performance on each deserialized item.
