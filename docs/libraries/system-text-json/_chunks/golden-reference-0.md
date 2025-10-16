# System.Text.Json

## Overview

System.Text.Json is a high-performance JSON serialization library built into .NET. It provides a complete JSON processing stack from low-level UTF-8 readers/writers to high-level serialization APIs. The library serves as the default JSON handler for ASP.NET Core, HttpClient extensions, and configuration systems.

The library provides multiple APIs organized in layers, each serving different performance and flexibility needs:

**High-level APIs** - Simple, strongly-typed operations:
- `JsonSerializer` - Convert between .NET objects and JSON with minimal code
- Supports reflection-based serialization and compile-time source generation

**Document Object Model (DOM)** - Dynamic JSON without defined types:
- `JsonDocument` - Read-only DOM with pooled memory for minimal allocation
- `JsonNode` - Mutable DOM for building and modifying JSON at runtime

**Low-level APIs** - Maximum control and performance:
- `Utf8JsonReader` - Forward-only, zero-allocation JSON parsing
- `Utf8JsonWriter` - Direct UTF-8 JSON writing with minimal overhead

Most applications use `JsonSerializer` for serialization/deserialization and occasionally drop to DOM APIs for dynamic scenarios. The low-level reader/writer APIs are primarily for library authors and custom serialization logic.

**Design principles:**
- **Performance first** - Built on `Span<T>`, UTF-8 operations, and vectorization
- **AOT compatible** - Source generation eliminates reflection for Native AOT scenarios
- **Secure by default** - Depth limits, controlled type resolution, no arbitrary code execution
- **Web optimized** - UTF-8 native, streaming support, minimal allocation

**Integration points:**
- Default serializer for ASP.NET Core web APIs and Minimal APIs
- Powers `HttpClient` JSON extension methods (`GetFromJsonAsync`, `PostAsJsonAsync`)
- Configuration system JSON parsing (`appsettings.json`)
- Microsoft.Extensions.AI structured chat responses
