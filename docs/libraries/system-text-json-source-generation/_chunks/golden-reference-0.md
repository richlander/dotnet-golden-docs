# System.Text.Json Source Generation

## Overview

System.Text.Json source generation generates JSON serialization code at compile time rather than using runtime reflection. This approach is required for Native AOT applications and delivers significant performance improvements by eliminating runtime metadata collection, reducing startup time, and lowering memory usage.

Source generation resolves all type information at compile time, enabling assembly trimming, faster startup times, and predictable performance characteristics. The generated code eliminates JIT compilation overhead and works directly with UTF-8 data, making it essential for container deployments, serverless functions, and high-throughput APIs.

Key capabilities:

- Native AOT compatibility: Required for ahead-of-time compiled applications
- Performance: Zero runtime reflection, optimized UTF-8 processing
- Type safety: Compile-time generic type resolution with `System.Text.Json.Serialization.Metadata.JsonTypeInfo<T>`
- Automatic naming policies: Reduces need for `[JsonPropertyName]` attributes
- Assembly trimming: Works with dead code elimination and tree shaking

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Native AOT apps | `JsonSerializer.Serialize(obj, Context.Default.Type)` | Mandatory for AOT |
| ASP.NET Core APIs | Configure `TypeInfoResolver` in options | Automatic performance |
| HttpClient operations | Pass `JsonTypeInfo<T>` to extension methods | AOT-compatible HTTP |
| Generic methods | Accept `JsonTypeInfo<T>` parameter | Type-safe generics |
| Naming policies | `JsonSourceGenerationOptions` with naming policy | Avoid manual attributes |
