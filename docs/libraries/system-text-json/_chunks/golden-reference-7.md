# System.Text.Json
## Performance Optimization

System.Text.Json is designed for high performance, but specific patterns unlock maximum throughput and minimal allocation.

**Use source generation in production:**

Source generation provides 1.3-5x speedup over reflection and 50-90% reduction in memory allocation. Always use it for production web APIs and high-throughput services.

```csharp
// Define once
[JsonSerializable(typeof(ApiResponse))]
partial class AppContext : JsonSerializerContext { }

// Use everywhere
string json = JsonSerializer.Serialize(response, AppContext.Default.ApiResponse);
```

**Prefer UTF-8 operations:**

Avoid string encoding overhead by working directly with UTF-8 bytes:

```csharp
// Faster - no string encoding
byte[] utf8Json = JsonSerializer.SerializeToUtf8Bytes(data, AppContext.Default.Data);

// Slower - must encode string to UTF-8
string json = JsonSerializer.Serialize(data);
byte[] utf8 = Encoding.UTF8.GetBytes(json);
```

**Reuse JsonSerializerOptions:**

Creating `JsonSerializerOptions` on each call adds overhead. Reuse instances:

```csharp
// Good - reuse options
private static readonly JsonSerializerOptions _options = new()
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
};

string json = JsonSerializer.Serialize(data, _options);

// Bad - creates new options every time
string json = JsonSerializer.Serialize(data, new JsonSerializerOptions 
{ 
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase 
});
```

**Choose the right API for the job:**

| Scenario | Best API | Why |
|----------|----------|-----|
| Known types | `JsonSerializer<T>` + source gen | Fastest, type-safe |
| Read-only dynamic | `JsonDocument` | Minimal allocation |
| Mutable dynamic | `JsonNode` | Only when modification needed |
| Large arrays | `DeserializeAsyncEnumerable<T>` | Constant memory |
| Custom logic | `Utf8JsonReader`/`Writer` | Zero allocation |

**Stream large files:**

Don't load entire files into memory:

```csharp
// Good - streams data
await using var stream = File.OpenRead("data.json");
var data = await JsonSerializer.DeserializeAsync<Data>(stream);

// Bad - loads entire file
string json = await File.ReadAllTextAsync("data.json");
var data = JsonSerializer.Deserialize<Data>(json);
```

**Benchmark your scenarios:**

Different JSON structures and access patterns affect performance differently. Use BenchmarkDotNet to measure your specific use cases.
