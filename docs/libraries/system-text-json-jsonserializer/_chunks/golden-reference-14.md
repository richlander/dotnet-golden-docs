# System.Text.Json.JsonSerializer
## Reading Multiple JSON Documents

Read multiple whitespace-separated JSON documents from a single buffer.

```csharp
string multipleDocuments = """
{"id": 1, "name": "First"}
{"id": 2, "name": "Second"}
{"id": 3, "name": "Third"}
""";

byte[] utf8Bytes = Encoding.UTF8.GetBytes(multipleDocuments);
var readerOptions = new JsonReaderOptions
{
    AllowMultipleValues = true
};

var reader = new Utf8JsonReader(utf8Bytes, readerOptions);

var documents = new List<Dictionary<string, JsonElement>>();

while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.StartObject)
    {
        // Position reader at the start
        var readerCopy = reader;
        
        // Read complete document
        using JsonDocument doc = JsonDocument.ParseValue(ref reader);
        var dict = new Dictionary<string, JsonElement>();
        
        foreach (var property in doc.RootElement.EnumerateObject())
        {
            dict[property.Name] = property.Value.Clone();
        }
        
        documents.Add(dict);
    }
}

Console.WriteLine($"Read {documents.Count} documents");
```

## Generating JSON Schema

Export JSON schema for .NET types, useful for OpenAPI specifications and AI tool calling.

```csharp
using System.Text.Json.Schema;
using System.Text.Json.Nodes;

public class Person
{
    public required string Name { get; set; }
    public int Age { get; set; }
    public string? Email { get; set; }
}

// Generate schema for type
var options = new JsonSerializerOptions();
JsonNode schema = JsonSchemaExporter.GetJsonSchemaAsNode(options, typeof(Person));

// Schema describes the shape of Person
string schemaJson = schema.ToJsonString(new JsonSerializerOptions { WriteIndented = true });
// {
//   "type": "object",
//   "properties": {
//     "Name": { "type": "string" },
//     "Age": { "type": "integer" },
//     "Email": { "type": ["string", "null"] }
//   },
//   "required": ["Name"]
// }
```
