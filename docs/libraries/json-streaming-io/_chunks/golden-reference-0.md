# JSON Streaming and I/O

## Overview

JSON streaming and I/O capabilities in `System.Text.Json` enable efficient processing of JSON data from various sources including streams, pipes, and asynchronous operations. These features allow you to work with large JSON documents, real-time data streams, and high-throughput scenarios without loading entire documents into memory. By leveraging streaming, async patterns, and modern I/O types like `PipeReader`, you can build performant applications that handle JSON efficiently.

Key streaming and I/O capabilities include:

- **`PipeReader` support**: Deserialize JSON directly from `PipeReader` for high-performance pipeline scenarios
- **Stream-based serialization**: Read and write JSON incrementally using streams
- **Async patterns**: Asynchronous serialization and deserialization for non-blocking I/O
- **Large document handling**: Process JSON documents too large to fit in memory
- **UTF-8 direct processing**: Work with UTF-8 encoded JSON without string conversions
- **Memory-efficient parsing**: Minimize allocations through streaming APIs

These features are particularly valuable when:

1. Processing large JSON files or streams
2. Building high-throughput APIs or services
3. Working with real-time data pipelines
4. Implementing WebSocket or SignalR services with JSON payloads
5. Optimizing memory usage in memory-constrained environments
