# System.Text.Json.Utf8JsonReader
## Using for Validation

Validate JSON structure and values during parsing.

```csharp
public class JsonValidator
{
    public ValidationResult ValidateConfiguration(byte[] utf8Json)
    {
        var reader = new Utf8JsonReader(utf8Json);
        var errors = new List<string>();
        var requiredFields = new HashSet<string> { "version", "name", "settings" };
        var foundFields = new HashSet<string>();
        
        try
        {
            while (reader.Read())
            {
                if (reader.TokenType == JsonTokenType.PropertyName)
                {
                    string propertyName = reader.GetString()!;
                    foundFields.Add(propertyName);
                    reader.Read(); // Move to value
                    
                    // Validate specific fields
                    if (propertyName == "version")
                    {
                        if (reader.TokenType != JsonTokenType.Number)
                        {
                            errors.Add("version must be a number");
                        }
                        else if (reader.GetInt32() < 1)
                        {
                            errors.Add("version must be positive");
                        }
                    }
                    else if (propertyName == "name")
                    {
                        if (reader.TokenType != JsonTokenType.String)
                        {
                            errors.Add("name must be a string");
                        }
                        else if (string.IsNullOrWhiteSpace(reader.GetString()))
                        {
                            errors.Add("name cannot be empty");
                        }
                    }
                }
            }
            
            // Check for missing required fields
            var missing = requiredFields.Except(foundFields);
            foreach (var field in missing)
            {
                errors.Add($"Missing required field: {field}");
            }
        }
        catch (JsonException ex)
        {
            errors.Add($"Invalid JSON: {ex.Message}");
        }
        
        return new ValidationResult
        {
            IsValid = errors.Count == 0,
            Errors = errors
        };
    }
}

public class ValidationResult
{
    public bool IsValid { get; set; }
    public List<string> Errors { get; set; } = new();
}
```

## Using for Streaming Array Processing

Process large JSON arrays with constant memory usage.

```csharp
public async Task ProcessLargeArrayAsync(Stream fileStream)
{
    byte[] buffer = ArrayPool<byte>.Shared.Rent(8192);
    
    try
    {
        int bytesRead = await fileStream.ReadAsync(buffer);
        var reader = new Utf8JsonReader(buffer.AsSpan(0, bytesRead));
        
        // Find array start
        while (reader.Read())
        {
            if (reader.TokenType == JsonTokenType.PropertyName && 
                reader.GetString() == "items")
            {
                reader.Read(); // Move to StartArray
                break;
            }
        }
        
        // Process array elements
        int count = 0;
        while (reader.Read() && reader.TokenType != JsonTokenType.EndArray)
        {
            if (reader.TokenType == JsonTokenType.StartObject)
            {
                var item = ReadItem(ref reader);
                await ProcessItemAsync(item);
                count++;
                
                if (count % 1000 == 0)
                {
                    Console.WriteLine($"Processed {count} items");
                }
            }
        }
    }
    finally
    {
        ArrayPool<byte>.Shared.Return(buffer);
    }
}

private object ReadItem(ref Utf8JsonReader reader)
{
    // Read single object from array
    var item = new Dictionary<string, object>();
    
    while (reader.Read() && reader.TokenType != JsonTokenType.EndObject)
    {
        if (reader.TokenType == JsonTokenType.PropertyName)
        {
            string name = reader.GetString()!;
            reader.Read();
            
            object value = reader.TokenType switch
            {
                JsonTokenType.String => reader.GetString()!,
                JsonTokenType.Number => reader.GetInt32(),
                JsonTokenType.True => true,
                JsonTokenType.False => false,
                _ => null!
            };
            
            item[name] = value;
        }
    }
    
    return item;
}

private Task ProcessItemAsync(object item) => Task.CompletedTask;
```
