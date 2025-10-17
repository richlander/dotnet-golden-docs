# System.Text.Json.Nodes

## Overview

System.Text.Json.Nodes provides a Document Object Model (DOM) for JSON. The DOM allows navigation, querying, and modification of JSON structures without defining concrete types. This is essential when JSON structure is unknown at compile time, varies between requests, or requires runtime manipulation.

The namespace includes four primary types: `JsonNode` (base class), `JsonObject` (key-value pairs), `JsonArray` (ordered sequences), and `JsonValue` (primitives). These types form a mutable tree structure representing JSON documents in memory. Programs can parse JSON into this structure, navigate using indexers and properties, modify values, and serialize back to JSON text.

System.Text.Json.Nodes fills the gap between strongly-typed deserialization and low-level `Utf8JsonReader`. When types are known at compile time, use `JsonSerializer.Deserialize<T>()`. When JSON structure is completely unknown or highly dynamic, use the nodes API. For read-only access to dynamic JSON, `JsonDocument` offers better performance than `JsonNode`.

Key capabilities:

- Dynamic JSON parsing: Parse JSON without predefined types
- Mutable document model: Modify JSON structure programmatically
- Type-safe value access: Read values with strongly-typed `GetValue<T>()` methods
- JSON construction: Build JSON documents from code without string concatenation
- JSON merging: Combine multiple JSON documents at runtime
- Schema-less querying: Navigate JSON with indexer syntax and property access

The nodes API is common in middleware, configuration mergers, JSON proxies, and applications that aggregate or transform JSON from multiple sources. It provides runtime flexibility that strongly-typed deserialization cannot offer.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Unknown JSON structure | `JsonNode.Parse()` | No type definitions needed |
| Modifying JSON | `JsonObject`/`JsonArray` mutation | Direct value updates |
| Building JSON from code | `new JsonObject()` + property assignment | Type-safe construction |
| Merging configurations | Parse multiple sources, copy properties | Runtime combination |
| JSON proxies | Parse, modify specific paths, serialize | Middleware flexibility |
| Extracting values | Indexer + `GetValue<T>()` | Type-safe reading |
| Read-only access | Use `JsonDocument` instead | Better performance |
| Known structure | Use `JsonSerializer.Deserialize<T>()` instead | Type safety, performance |
