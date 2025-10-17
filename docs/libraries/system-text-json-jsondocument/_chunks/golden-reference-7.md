# System.Text.Json.JsonDocument
## Choosing Between JsonDocument, JsonNode, and Deserialization

Different approaches suit different scenarios based on performance, flexibility, and type safety requirements.

```csharp
// JsonDocument: Best for read-only access, minimal allocation
using JsonDocument doc = JsonDocument.Parse(json);
string value = doc.RootElement.GetProperty("field").GetString()!;
// Pros: Fastest, lowest allocation, pooled memory
// Cons: Read-only, requires disposal, no modification

// JsonNode: Best for modification and dynamic building
JsonNode node = JsonNode.Parse(json)!;
node["field"] = "new value";
string modified = node.ToJsonString();
// Pros: Mutable, flexible, no disposal needed
// Cons: Higher allocation, slower than JsonDocument

// Strongly-typed: Best for known structure
public record Data(string Field, int Value);
Data obj = JsonSerializer.Deserialize<Data>(json)!;
// Pros: Type safety, source generation support, fastest with source gen
// Cons: Requires type definitions, inflexible

// Performance hierarchy (fastest to slowest):
// 1. JsonSerializer.Deserialize<T> with source generation
// 2. JsonDocument (read-only DOM)
// 3. JsonSerializer.Deserialize<T> with reflection
// 4. JsonNode (mutable DOM)
```

## Considerations

### Memory Management

JsonDocument uses pooled memory that must be disposed. Failure to dispose causes memory leaks. Always use `using` statements or explicit `Dispose()` calls.

```csharp
// Correct: using statement ensures disposal
using JsonDocument doc = JsonDocument.Parse(json);
ProcessDocument(doc);

// Correct: explicit disposal
JsonDocument doc = JsonDocument.Parse(json);
try
{
    ProcessDocument(doc);
}
finally
{
    doc.Dispose();
}

// Wrong: Memory leak
JsonDocument doc = JsonDocument.Parse(json);
ProcessDocument(doc);
// Pooled memory never returned
```
