# System.Text.Json.JsonDocument
## Related Concepts
### JsonElement Lifetime

JsonElement is a struct that references memory owned by JsonDocument. Elements become invalid after document disposal. Extract values or raw JSON text if you need data beyond document lifetime.

```csharp
string ExtractValue(string json)
{
    using JsonDocument doc = JsonDocument.Parse(json);
    JsonElement root = doc.RootElement;
    
    // Wrong: Element references disposed memory
    // return root.GetProperty("field"); // Will fail
    
    // Right: Extract the value
    return root.GetProperty("field").GetString()!;
}
```

### Performance Characteristics

JsonDocument parses the entire document into memory, which is faster for random access but slower for forward-only processing. For sequential reading of large documents, `Utf8JsonReader` offers better performance.

JsonDocument provides O(1) property access after parsing, while `Utf8JsonReader` requires sequential scanning. Choose based on access patterns.

### Read-Only Limitation

JsonDocument provides no mutation APIs. For scenarios requiring modification, use `JsonNode` instead. Converting from JsonDocument to JsonNode requires reparsing:

```csharp
// Convert JsonDocument to JsonNode for modification
using JsonDocument doc = JsonDocument.Parse(json);
string rawJson = doc.RootElement.GetRawText();
JsonNode node = JsonNode.Parse(rawJson)!;
node["newField"] = "value";
```

### Comparison with JsonNode

JsonDocument offers better performance (2-3x faster) but is read-only and requires disposal. JsonNode provides mutation but allocates more memory and has no disposal requirement. Choose based on whether modification is needed.

## Related Concepts

**Used by System.Text.Json.JsonDocument:**

- `Utf8JsonReader` (underlying parsing primitive)
- Pooled memory buffers (allocation optimization)

**Uses System.Text.Json.JsonDocument:**

- Webhook routing systems (event type extraction)
- Configuration validators (schema-less validation)
- API response filters (conditional deserialization)
- Metadata extractors (selective field reading)
- Request routers (routing by payload content)

**Alternative to System.Text.Json.JsonDocument:**

- `JsonNode` (mutable DOM with higher allocation)
- `JsonSerializer.Deserialize<T>()` (strongly-typed with type safety)
- `Utf8JsonReader` (forward-only with lowest allocation)
