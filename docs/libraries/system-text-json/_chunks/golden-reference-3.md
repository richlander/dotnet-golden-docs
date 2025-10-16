# System.Text.Json
## Choosing the Right API
### Code comparison

```csharp
// 1. Strongly-typed (fastest with source generation, type-safe)
public record User(int Id, string Name, string Email);

[JsonSerializable(typeof(User))]
partial class AppContext : JsonSerializerContext { }

var user = JsonSerializer.Deserialize(json, AppContext.Default.User)!;
// Pros: Type safety, IntelliSense, best performance, AOT compatible
// Cons: Requires type definition, inflexible for changing schemas

// 2. JsonDocument (read-only, minimal allocation)
using JsonDocument doc = JsonDocument.Parse(json);
string name = doc.RootElement.GetProperty("name").GetString()!;
int id = doc.RootElement.GetProperty("id").GetInt32();
// Pros: No types needed, fast, low allocation, pooled memory
// Cons: Read-only, requires disposal, no modification

// 3. JsonNode (mutable, flexible)
JsonNode node = JsonNode.Parse(json)!;
string name = node["name"]!.GetValue<string>();
node["status"] = "updated";  // Can modify
string modified = node.ToJsonString();
// Pros: Can modify, no disposal, flexible
// Cons: Higher allocation, slower, no type safety

// 4. Utf8JsonReader (lowest level, maximum control)
var reader = new Utf8JsonReader(utf8Json);
while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.PropertyName && 
        reader.GetString() == "name")
    {
        reader.Read();
        string name = reader.GetString()!;
    }
}
// Pros: Zero allocation, maximum performance, streaming
// Cons: Complex API, manual state management, forward-only
```

### Scenario recommendations

| Scenario | Recommended API | Rationale |
|----------|----------------|-----------|
| Web API responses | `JsonSerializer<T>` + source gen | Known types, performance critical, AOT compatible |
| Configuration loading | `JsonSerializer<T>` + strict mode | Known schema, early validation needed |
| Webhook routing | `JsonDocument` | Extract event type without full deserialization |
| Middleware/proxies | `JsonNode` | May need to modify, structure varies |
| Large file processing | `DeserializeAsyncEnumerable<T>()` | Constant memory for large arrays |
| Custom converters | `Utf8JsonReader`/`Utf8JsonWriter` | Fine control over format |
| HTTP client calls | `GetFromJsonAsync<T>()` | Known response types, convenience |
| Dynamic config merging | `JsonNode` | Runtime modification of JSON structure |
| Log parsing | `JsonDocument` | Read-only extraction of specific fields |
| Real-time APIs | `JsonSerializer<T>` + source gen | Lowest latency, minimal GC pressure |
