# System.Text.Json
## Choosing the Right API

System.Text.Json provides multiple approaches optimized for different scenarios. Choose based on whether JSON structure is known at compile time, whether modification is needed, and performance requirements.

### Decision tree

1. **Is JSON structure known at compile time?**
   - Use `JsonSerializer.Deserialize<T>()` with defined types

2. **Do you need to modify the JSON?**
   - Use `JsonNode` (mutable DOM)

3. **Read-only access to dynamic JSON?**
   - For most scenarios, use `JsonDocument` (read-only DOM, pooled memory)
   - For custom serialization logic, use ``Utf8JsonReader` and `Utf8JsonReader` (forward-only)

### API comparison

| API | Use When | Performance | Memory | Mutability | Typing |
|-----|----------|-------------|--------|------------|--------|
| `JsonSerializer<T>` + source gen | Known types, max performance | Fastest | Minimal | Objects | Strong |
| `JsonSerializer<T>` + reflection | Known types, development | Fast | Low | Objects | Strong |
| `JsonDocument` | Read-only dynamic JSON | Fast | Minimal (pooled) | Read-only | Loose |
| `JsonNode` | Mutable dynamic JSON | Moderate | Moderate | Mutable | Loose |
| `Utf8JsonReader` | Custom parsing, streaming | Fastest | Minimal | N/A | Loose |
| `Utf8JsonWriter` | Custom writing, streaming | Fastest | Minimal | N/A | Loose |
