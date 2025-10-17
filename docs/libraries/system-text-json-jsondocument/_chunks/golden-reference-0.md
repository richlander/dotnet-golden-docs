# System.Text.Json.JsonDocument

## Overview

System.Text.Json.JsonDocument provides a read-only Document Object Model (DOM) for JSON with minimal memory allocation. It parses JSON into pooled memory buffers and returns `JsonElement` instances for navigation. This approach offers significantly better performance than mutable JSON nodes when modification is not required.

JsonDocument is optimized for temporary JSON access scenarios. The underlying data uses pooled memory that must be explicitly disposed, making JsonDocument ideal for request-scoped operations, routing logic, metadata extraction, and validation scenarios where JSON structure is inspected but not modified.

The API centers on `JsonElement`, a lightweight struct representing a JSON value. JsonElement provides type checking, property enumeration, array iteration, and value extraction. Because JsonElement is a struct backed by pooled memory, it has minimal allocation overhead compared to object-based DOM implementations.

Key capabilities:

- Read-only DOM access: Navigate JSON without defining types
- Pooled memory: Minimal allocation through memory pooling
- Performance: 2-3x faster than mutable JSON nodes for read operations
- Property enumeration: Iterate object properties dynamically
- Array iteration: Process JSON arrays without deserialization
- Type checking: Determine value types at runtime
- Selective deserialization: Convert specific portions to strongly-typed objects
- Metadata extraction: Read specific fields without full deserialization

JsonDocument fills the gap between `Utf8JsonReader` (forward-only, lowest allocation) and `JsonNode` (mutable, higher allocation). Use JsonDocument when you need random access to JSON without modification, streaming readers when you only need forward iteration, and JsonNode when runtime modification is required.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Read-only JSON access | `JsonDocument.Parse()` | Minimal allocation |
| Routing by field value | Read property, make decision | Fast metadata extraction |
| Conditional deserialization | Check field, deserialize if needed | Avoid unnecessary parsing |
| Property validation | Enumerate properties, check types | Schema-less validation |
| Array filtering | Iterate elements, extract values | Process without full deserialization |
| Webhook routing | Parse event type, route to handler | Low-latency request processing |
| Extracting nested values | Navigate with GetProperty, read value | Efficient value access |
| Large document processing | Use with streaming for memory efficiency | Constant memory usage |
| Modifying JSON | Use `JsonNode` instead | Mutation support |
| Known structure | Use `JsonSerializer.Deserialize<T>()` instead | Type safety, source generation |
