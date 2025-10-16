# System.Text.Json - What's New in .NET 10

## Overview

.NET 10 introduces several important improvements to `System.Text.Json` focused on security, validation, I/O performance, and source generation. These enhancements help developers build more secure APIs, process JSON more efficiently, ensure data integrity, and handle circular references in generated serializers. The key additions include strict serialization options for secure-by-default deserialization, duplicate property detection to prevent ambiguity attacks, `PipeReader` support for high-performance streaming scenarios, and `ReferenceHandler` support in source generation.

This topic covers features added in .NET 10. For complete `System.Text.Json` information, see more general documentation.

## Strict JSON Serialization Options

`JsonSerializerOptions.Strict` provides a secure-by-default configuration preset:

```csharp
using System.Text.Json;

// Use strict options for secure deserialization
var options = JsonSerializerOptions.Strict;

string json = """{ "Name": "Alice", "Age": 30 }""";
var person = JsonSerializer.Deserialize<Person>(json, options);

record Person(string Name, int Age);
```

The strict preset includes:

- Disallows duplicate JSON properties
- Disallows unmapped members (properties not in your type)
- Case-sensitive property matching
- Respects nullable reference type annotations
- Respects required constructor parameters

This is equivalent to:

```csharp
var manualOptions = new JsonSerializerOptions
{
    AllowDuplicateProperties = false,
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow,
    PropertyNameCaseInsensitive = false,
    RespectNullableAnnotations = true,
    RespectRequiredConstructorParameters = true
};
```

Use strict options when deserializing untrusted JSON from external sources.

## Duplicate Property Detection

The `AllowDuplicateProperties` option prevents ambiguity and potential security issues:

```csharp
using System.Text.Json;

string maliciousJson = """
{
    "Amount": 10.00,
    "Amount": 999999.99
}
""";

// Reject duplicate properties
var options = new JsonSerializerOptions 
{ 
    AllowDuplicateProperties = false 
};

try
{
    var payment = JsonSerializer.Deserialize<Payment>(maliciousJson, options);
}
catch (JsonException ex)
{
    Console.WriteLine($"Duplicate property detected: {ex.Message}");
}

record Payment(decimal Amount);
```

Without this protection, the last value wins, which can lead to security vulnerabilities. The default behavior allows duplicates for backward compatibility, but new applications should set this to `false`.

This works across all JSON types:

- Object deserialization
- `JsonDocument` parsing
- `JsonObject` from System.Text.Json.Nodes
- Dictionary deserialization

## PipeReader Support

Deserialize JSON directly from `PipeReader` for high-performance pipeline scenarios:

```csharp
using System.IO.Pipelines;
using System.Text.Json;

async Task ProcessJsonPipelineAsync(PipeReader reader)
{
    MyData? data = await JsonSerializer.DeserializeAsync<MyData>(reader);
    
    if (data != null)
    {
        ProcessData(data);
    }
}

record MyData(string Name, int Value);
```

This is particularly useful for streaming scenarios:

```csharp
using System.IO.Pipelines;
using System.Text.Json;

// Producer writes JSON to pipe
async Task ProduceAsync(PipeWriter writer)
{
    for (int i = 0; i < 100; i++)
    {
        var message = new Message($"Item {i}", DateTime.UtcNow);
        await JsonSerializer.SerializeAsync(writer, message);
        await writer.FlushAsync();
    }
    await writer.CompleteAsync();
}

// Consumer reads JSON from pipe
async Task ConsumeAsync(PipeReader reader)
{
    await foreach (var message in JsonSerializer
        .DeserializeAsyncEnumerable<Message>(reader))
    {
        if (message != null)
        {
            Console.WriteLine($"{message.Text} at {message.Timestamp}");
        }
    }
    await reader.CompleteAsync();
}

var pipe = new Pipe();
await Task.WhenAll(
    ProduceAsync(pipe.Writer),
    ConsumeAsync(pipe.Reader)
);

record Message(string Text, DateTime Timestamp);
```

`PipeReader` provides better performance than streams in high-throughput scenarios due to:

- Reduced buffer allocations
- Built-in backpressure handling
- Efficient memory pooling
- Zero-copy reads when possible

## Combining New Features

Use multiple .NET 10 features together for secure, high-performance JSON processing:

```csharp
using System.IO.Pipelines;
using System.Text.Json;
using System.Text.Json.Serialization;

async Task SecurelyProcessApiStreamAsync(PipeReader reader)
{
    // Use source generation with strict validation and PipeReader streaming
    await foreach (var item in JsonSerializer
        .DeserializeAsyncEnumerable(reader, ApiJsonContext.Default.ApiRequest))
    {
        if (item != null)
        {
            // All validation passed
            await ProcessSecureRequestAsync(item);
        }
    }
}

// Configure source generation with all .NET 10 validation features
[JsonSourceGenerationOptions(
    AllowDuplicateProperties = false,
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow,
    RespectNullableAnnotations = true,
    ReferenceHandler = JsonKnownReferenceHandler.Preserve
)]
[JsonSerializable(typeof(ApiRequest))]
internal partial class ApiJsonContext : JsonSerializerContext
{
}

record ApiRequest(string Id, string Action, Dictionary<string, string> Metadata);
```

This approach provides:

- **Security**: Strict validation with duplicate detection and unmapped member handling
- **Performance**: `PipeReader` streaming with zero-copy reads
- **AOT compatibility**: Source generation eliminates reflection
- **Circular reference support**: `ReferenceHandler` handles object graphs

## ASP.NET Core Integration

Configure .NET 10 features globally in ASP.NET Core:

```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);

// Configure JSON options for all endpoints
builder.Services.ConfigureHttpJsonOptions(options =>
{
    // Use strict validation
    options.SerializerOptions.AllowDuplicateProperties = false;
    options.SerializerOptions.UnmappedMemberHandling = 
        JsonUnmappedMemberHandling.Disallow;
    
    // Add custom configuration
    options.SerializerOptions.PropertyNamingPolicy = 
        JsonNamingPolicy.CamelCase;
});

var app = builder.Build();

// All API endpoints now use these settings
app.MapPost("/api/payment", (Payment payment) =>
{
    // Payment was validated during deserialization
    return ProcessPayment(payment);
});

app.Run();

record Payment(decimal Amount, string Currency);
```

## Migration Guidance

### Adopting Strict Options

Start with strict options for new APIs:

```csharp
// For new APIs - start with strict
var strictOptions = JsonSerializerOptions.Strict;

// For existing APIs - test first, then migrate gradually
var testOptions = new JsonSerializerOptions
{
    AllowDuplicateProperties = false  // Start with just this
};

// Test with production-like data
var result = JsonSerializer.Deserialize<MyType>(json, testOptions);
```

### Enabling Duplicate Detection

Add duplicate detection incrementally:

```csharp
// Step 1: Add to new deserialization code
var options = new JsonSerializerOptions 
{ 
    AllowDuplicateProperties = false 
};

// Step 2: Monitor for failures in logs

// Step 3: Roll out to existing code paths after validation
```

### Using PipeReader

Migrate from streams to `PipeReader`:

```csharp
// Before
using var stream = GetDataStream();
var data = await JsonSerializer.DeserializeAsync<MyData>(stream);

// After - wrap stream in PipeReader
var pipeReader = PipeReader.Create(GetDataStream());
var data = await JsonSerializer.DeserializeAsync<MyData>(pipeReader);

// Or use directly with System.IO.Pipelines
var pipe = new Pipe();
// ... use pipe.Reader and pipe.Writer
```

## Performance Considerations

### Strict Options

Strict validation has minimal performance overhead:

- Duplicate detection: Small cost during property name comparison
- Unmapped member handling: Negligible overhead during normal deserialization
- Nullable validation: No runtime overhead
- Overall impact: < 5% in typical scenarios

The security benefits far outweigh the minimal performance cost.

### PipeReader Performance

`PipeReader` provides better performance than streams:

- **Reduced allocations**: Buffer pooling and reuse
- **Backpressure**: Automatic flow control prevents memory bloat
- **Zero-copy**: Read operations can avoid copying in many scenarios
- **Benchmark results**: 10-30% throughput improvement in streaming scenarios

Use `PipeReader` for:

- High-throughput APIs
- Real-time data processing
- WebSocket or SignalR JSON payloads
- Large file processing

## ReferenceHandler in Source Generation

Specify `ReferenceHandler` in source generation to handle circular references:

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

// Object with circular reference
SelfReference selfRef = new SelfReference();
selfRef.Me = selfRef;

// Serialize with generated context that preserves references
Console.WriteLine(JsonSerializer.Serialize(
    selfRef, 
    ContextWithPreserveReference.Default.SelfReference));
// Output: {"$id":"1","Me":{"$ref":"1"}}

// Configure ReferenceHandler in source generation options
[JsonSourceGenerationOptions(ReferenceHandler = JsonKnownReferenceHandler.Preserve)]
[JsonSerializable(typeof(SelfReference))]
internal partial class ContextWithPreserveReference : JsonSerializerContext
{
}

internal class SelfReference
{
    public SelfReference? Me { get; set; }
}
```

Available `ReferenceHandler` options:

- `JsonKnownReferenceHandler.Preserve` - Preserve object references (handles cycles)
- `JsonKnownReferenceHandler.IgnoreCycles` - Ignore circular references (write null)

This feature brings source generation to parity with runtime serialization for reference handling.

## Related Features

The .NET 10 `System.Text.Json` improvements work with existing features:

- **Source generation**: Strict options and duplicate detection work with generated serializers
- **Nullable reference types**: `RespectNullableAnnotations` is part of strict preset
- **Required members (C# 11)**: `RespectRequiredConstructorParameters` validates required properties
- **`IAsyncEnumerable<T>`**: Works with `PipeReader` for streaming arrays
- **System.IO.Pipelines**: Foundation for `PipeReader`/`PipeWriter` support
- **Source generation and Native AOT**: All .NET 10 features are fully compatible with source generation and Native AOT.
