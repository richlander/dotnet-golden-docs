# System.Text.Json.JsonDocument
## Quick Start

```csharp
using System.Text.Json;

// Parse JSON into read-only DOM
string json = """{"name":"Alice","age":30,"active":true}""";
using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Read values
string name = root.GetProperty("name").GetString()!;
int age = root.GetProperty("age").GetInt32();
bool active = root.GetProperty("active").GetBoolean();

// Check if property exists
if (root.TryGetProperty("email", out JsonElement emailElement))
{
    string email = emailElement.GetString()!;
}

// Dispose releases pooled memory
// (using statement handles this automatically)
```

## Parsing JSON

Parse JSON text or streams into a read-only document. JsonDocument must be disposed to return pooled memory.

```csharp
// Parse from string
string json = """{"id":1,"name":"Product","price":99.99}""";
using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Parse from ReadOnlyMemory<byte> (UTF-8)
ReadOnlyMemory<byte> utf8Json = Encoding.UTF8.GetBytes(json);
using JsonDocument doc2 = JsonDocument.Parse(utf8Json);

// Parse from stream
await using Stream stream = File.OpenRead("data.json");
using JsonDocument doc3 = await JsonDocument.ParseAsync(stream);

// Parse with options
var options = new JsonDocumentOptions
{
    AllowTrailingCommas = true,
    CommentHandling = JsonCommentHandling.Skip,
    MaxDepth = 32
};
using JsonDocument doc4 = JsonDocument.Parse(json, options);
```

## Reading Property Values

Access object properties using `GetProperty()` and extract strongly-typed values.

```csharp
string json = """
{
    "userId": 123,
    "username": "alice",
    "score": 98.5,
    "verified": true,
    "metadata": null
}
""";

using JsonDocument doc = JsonDocument.Parse(json);
JsonElement root = doc.RootElement;

// Read primitive values
int userId = root.GetProperty("userId").GetInt32();
string username = root.GetProperty("username").GetString()!;
double score = root.GetProperty("score").GetDouble();
bool verified = root.GetProperty("verified").GetBoolean();

// Handle null values
JsonElement metadata = root.GetProperty("metadata");
if (metadata.ValueKind == JsonValueKind.Null)
{
    // Handle null case
}

// Try pattern for optional properties
if (root.TryGetProperty("optionalField", out JsonElement optional))
{
    string value = optional.GetString()!;
}
```
