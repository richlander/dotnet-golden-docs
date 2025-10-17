# System.Text.Json.JsonSerializer

## Overview

System.Text.Json.JsonSerializer provides high-level APIs for converting between .NET objects and JSON text. It offers simple static methods for serialization and deserialization that handle the complexity of JSON parsing and generation. The API supports both synchronous operations for string-based JSON and asynchronous operations for streams.

JsonSerializer operates in two modes: reflection-based and source generation-based. Reflection mode discovers types at runtime and works with any .NET type without configuration. Source generation mode produces serialization code at compile time, eliminating reflection overhead and enabling Native AOT compatibility. Both modes use the same API surface, differing only in how type information is provided.

The serializer supports customization through `JsonSerializerOptions`, including property naming policies, null handling, number formats, and custom converters. Options can be configured globally or per operation. The serializer integrates with ASP.NET Core, HttpClient extensions, and configuration systems as the default JSON handler.

Key capabilities:

- Simple API: Single-line serialization and deserialization
- Type safety: Strongly-typed operations with compile-time checking
- Async support: Stream-based operations for files and network I/O
- Customization: Naming policies, converters, and formatting options
- Source generation: Compile-time code generation for performance
- UTF-8 optimization: Direct byte operations for web scenarios
- Collection support: Arrays, lists, dictionaries, and custom collections
- Polymorphism: Type discriminators for inheritance hierarchies

JsonSerializer sits at the top of the System.Text.Json stack, using Utf8JsonReader and Utf8JsonWriter internally. Applications use JsonSerializer for most JSON operations, falling back to lower-level APIs only when specialized behavior is needed.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Basic serialization | `Serialize<T>(object)` | Simple one-line API |
| Basic deserialization | `Deserialize<T>(string)` | Type-safe parsing |
| File I/O | `SerializeAsync<T>(stream, object)` | Async without blocking |
| Web defaults | `Serialize(object, JsonSerializerOptions.Web)` | ASP.NET Core conventions |
| Custom naming | Configure `PropertyNamingPolicy` | Control JSON format |
| Ignore nulls | Set `DefaultIgnoreCondition` | Smaller payloads |
| Source generation | Pass `JsonTypeInfo<T>` parameter | Maximum performance |
| UTF-8 operations | `SerializeToUtf8Bytes<T>(object)` | Zero string allocation |
| Streaming arrays | `DeserializeAsyncEnumerable<T>(stream)` | Constant memory |
| Custom logic | Use `Utf8JsonReader`/`Utf8JsonWriter` instead | Full control |
| DOM access | Use `JsonDocument` or `JsonNode` instead | Dynamic JSON |
