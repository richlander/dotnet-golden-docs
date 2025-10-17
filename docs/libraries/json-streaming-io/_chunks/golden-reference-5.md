# JSON Streaming and I/O
## Performance Characteristics

JSON streaming provides significant performance benefits:

### Memory Efficiency
- **Stream deserialization**: Processes data incrementally, avoiding large allocations
- **`PipeReader` support**: Minimal buffering with pipeline semantics
- **UTF-8 processing**: No UTF-16 string conversion overhead
- **Async enumeration**: Processes one item at a time from arrays

### Throughput
- **Async I/O**: Non-blocking operations for high concurrency
- **Pipelining**: Producer and consumer can run concurrently
- **Buffer tuning**: Configurable buffer sizes for optimal throughput
- **Direct stream writing**: `Utf8JsonWriter` writes directly to streams

### Scalability
- **Constant memory**: Memory usage independent of JSON size
- **Cancellation support**: Graceful cancellation of long-running operations
- **Backpressure**: `PipeReader`/`PipeWriter` handle flow control automatically

## Best Practices

1. **Use async APIs**: Prefer `DeserializeAsync` over `Deserialize` for I/O operations
2. **Stream large documents**: Don't load large JSON into memory; use streaming APIs
3. **Configure buffer sizes**: Tune `DefaultBufferSize` based on your data patterns
4. **Use `IAsyncEnumerable<T>`**: For processing JSON arrays incrementally
5. **Leverage `PipeReader` for pipelines**: Maximum efficiency for streaming scenarios
6. **Handle cancellation**: Support cancellation tokens for responsive applications
7. **UTF-8 all the way**: Avoid string conversions when working with UTF-8 sources

## Migration & Compatibility

### Adopting Streaming APIs

Migrating from synchronous to streaming:

```csharp
// Before: Load entire file into memory
string json = await File.ReadAllTextAsync("data.json");
var data = JsonSerializer.Deserialize<List<Item>>(json);

// After: Stream from file
using var stream = File.OpenRead("data.json");
var items = new List<Item>();
await foreach (var item in JsonSerializer.DeserializeAsyncEnumerable<Item>(stream))
{
    if (item != null)
    {
        items.Add(item);
    }
}
```
