# System.Text.Json.Utf8JsonReader
## Checking Current Position

Access position information for error reporting.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    "line1": "value",
    "line2": 42
}
""");

var reader = new Utf8JsonReader(utf8Json);

while (reader.Read())
{
    Console.WriteLine($"Position: {reader.Position}, " +
                     $"Line: {reader.CurrentState.Position.GetInteger()}, " +
                     $"Depth: {reader.CurrentDepth}");
}
```

## Using with Streaming Network Data

Process JSON as it arrives from network without buffering.

```csharp
public async Task ProcessStreamingJsonAsync(Stream networkStream)
{
    byte[] buffer = new byte[4096];
    var leftover = new List<byte>();
    
    while (true)
    {
        int bytesRead = await networkStream.ReadAsync(buffer);
        if (bytesRead == 0) break;
        
        // Combine leftover with new data
        var jsonData = leftover.Concat(buffer.Take(bytesRead)).ToArray();
        
        var reader = new Utf8JsonReader(jsonData, isFinalBlock: false, 
            new JsonReaderState());
        
        try
        {
            while (reader.Read())
            {
                // Process tokens
                if (reader.TokenType == JsonTokenType.PropertyName)
                {
                    string propertyName = reader.GetString()!;
                    reader.Read();
                    ProcessValue(reader);
                }
            }
            
            // Clear leftover if all consumed
            leftover.Clear();
        }
        catch (JsonException)
        {
            // Incomplete JSON - save for next read
            leftover = jsonData.Skip((int)reader.BytesConsumed).ToList();
        }
    }
}

void ProcessValue(Utf8JsonReader reader)
{
    switch (reader.TokenType)
    {
        case JsonTokenType.String:
            Console.WriteLine(reader.GetString());
            break;
        case JsonTokenType.Number:
            Console.WriteLine(reader.GetInt32());
            break;
    }
}
```

## Using for Custom Deserialization

Implement custom parsing logic for specific requirements.

```csharp
public class CustomDeserializer
{
    public Product DeserializeProduct(byte[] utf8Json)
    {
        var reader = new Utf8JsonReader(utf8Json);
        
        var product = new Product();
        
        while (reader.Read())
        {
            if (reader.TokenType == JsonTokenType.PropertyName)
            {
                string propertyName = reader.GetString()!;
                reader.Read();
                
                switch (propertyName)
                {
                    case "id":
                        product.Id = reader.GetInt32();
                        break;
                    case "name":
                        product.Name = reader.GetString()!;
                        break;
                    case "price":
                        product.Price = reader.GetDecimal();
                        break;
                    case "tags":
                        product.Tags = ReadStringArray(ref reader);
                        break;
                }
            }
        }
        
        return product;
    }
    
    private List<string> ReadStringArray(ref Utf8JsonReader reader)
    {
        var result = new List<string>();
        
        if (reader.TokenType == JsonTokenType.StartArray)
        {
            while (reader.Read() && reader.TokenType != JsonTokenType.EndArray)
            {
                result.Add(reader.GetString()!);
            }
        }
        
        return result;
    }
}

public class Product
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public List<string> Tags { get; set; } = new();
}
```
