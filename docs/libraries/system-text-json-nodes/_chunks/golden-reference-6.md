# System.Text.Json.Nodes
## Considerations

### Performance vs. Flexibility

`JsonNode` provides runtime flexibility at the cost of performance. Strongly-typed deserialization with `JsonSerializer.Deserialize<T>()` is significantly faster. Use `JsonNode` only when JSON structure is truly unknown at compile time or requires runtime modification.

For read-only scenarios, `JsonDocument` offers better performance than `JsonNode` because it provides a read-only view with minimal allocation. Choose `JsonNode` when mutation is required.

### Memory Allocation

Each node in the tree allocates memory. Large JSON documents parsed into `JsonNode` consume more memory than streaming parsers like `Utf8JsonReader` or deserialization into strongly-typed objects. Consider memory constraints when working with large documents.

### Null Handling

Indexer access returns `JsonNode?` which may be null. Use null-forgiving operator `!` when certain property exists, or use null-conditional operators for safe navigation:

```csharp
// Assumes property exists
string name = node["name"]!.GetValue<string>();

// Safe navigation
string? name = node["name"]?.GetValue<string>();

// With fallback
string name = node["name"]?.GetValue<string>() ?? "default";
```

### Type Safety

`JsonNode` sacrifices compile-time type safety for runtime flexibility. Property names are strings and types are resolved at runtime. Typos in property names or incorrect type assumptions cause runtime exceptions rather than compile errors. Prefer strongly-typed models when structure is known.

## Related Concepts

**Used by System.Text.Json.Nodes:**

- `JsonSerializer` (serialization and deserialization)
- `JsonElement` (underlying value representation)

**Uses System.Text.Json.Nodes:**

- Configuration mergers (combining appsettings files)
- JSON proxy middleware (forwarding with modifications)
- API response transformers (schema conversion)
- Dynamic JSON builders (programmatic construction)

**Alternative to System.Text.Json.Nodes:**

- `JsonDocument` (read-only DOM with better performance)
- `JsonSerializer.Deserialize<T>()` (strongly-typed with type safety)
- `Utf8JsonReader` (forward-only streaming for lowest allocation)
