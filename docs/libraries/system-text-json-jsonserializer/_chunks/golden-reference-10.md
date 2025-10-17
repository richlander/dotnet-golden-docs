# System.Text.Json.JsonSerializer
## Error Handling

Handle deserialization errors gracefully.

```csharp
public User? SafeDeserialize(string json)
{
    try
    {
        return JsonSerializer.Deserialize<User>(json);
    }
    catch (JsonException ex)
    {
        Console.WriteLine($"JSON error at position {ex.BytePositionInLine}: {ex.Message}");
        return null;
    }
    catch (NotSupportedException ex)
    {
        Console.WriteLine($"Type not supported: {ex.Message}");
        return null;
    }
}

// Usage
string malformedJson = """{"Id":1,"Name":"Alice",,}""";
User? user = SafeDeserialize(malformedJson);
if (user == null)
{
    // Handle error
}
```

## Considerations

### Performance Characteristics

Reflection-based serialization discovers types at runtime. For performance-critical code, use source generation to eliminate reflection overhead. Source generation provides 1.3-5x faster serialization with lower memory allocation.

### Type Requirements

Types must have a parameterless constructor or use `[JsonConstructor]` to specify a constructor. Properties must have getters for serialization and setters for deserialization unless init-only or using constructor parameters.

### Null Handling

By default, null values are serialized. Use `DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull` to omit null values from output. For nullable reference types, enable `RespectNullableAnnotations` to enforce nullability contracts.

### Case Sensitivity

Property name matching is case-sensitive by default. Use `PropertyNameCaseInsensitive = true` for case-insensitive matching during deserialization. This adds slight overhead but improves flexibility when consuming external JSON.

### Circular References

JsonSerializer does not handle circular references by default. Configure `ReferenceHandler.Preserve` to serialize objects with circular references, but be aware this adds metadata to JSON output.

```csharp
var options = new JsonSerializerOptions
{
    ReferenceHandler = ReferenceHandler.Preserve
};

// Handles circular references but adds $id/$ref metadata
```
