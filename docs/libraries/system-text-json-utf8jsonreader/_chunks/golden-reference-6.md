# System.Text.Json.Utf8JsonReader
## Using with PipeReader

Integrate with high-performance pipeline I/O.

```csharp
public async Task ParseFromPipeAsync(PipeReader reader)
{
    while (true)
    {
        ReadResult result = await reader.ReadAsync();
        ReadOnlySequence<byte> buffer = result.Buffer;
        
        var jsonReader = new Utf8JsonReader(buffer);
        
        try
        {
            while (jsonReader.Read())
            {
                // Process tokens
                if (jsonReader.TokenType == JsonTokenType.PropertyName)
                {
                    Console.WriteLine(jsonReader.GetString());
                }
            }
            
            reader.AdvanceTo(buffer.End);
        }
        catch (JsonException)
        {
            // Need more data
            reader.AdvanceTo(buffer.Start, buffer.End);
        }
        
        if (result.IsCompleted)
        {
            break;
        }
    }
    
    await reader.CompleteAsync();
}
```

## Performance Optimization

Maximize performance using best practices.

```csharp
// Use ArrayPool for buffers
byte[] buffer = ArrayPool<byte>.Shared.Rent(size);
try
{
    var reader = new Utf8JsonReader(buffer.AsSpan(0, actualSize));
    while (reader.Read())
    {
        // Process
    }
}
finally
{
    ArrayPool<byte>.Shared.Return(buffer);
}

// Reuse JsonReaderState for multi-segment parsing
var state = new JsonReaderState();
var reader1 = new Utf8JsonReader(segment1, isFinalBlock: false, state);
// Process
state = reader1.CurrentState;
var reader2 = new Utf8JsonReader(segment2, isFinalBlock: true, state);
// Continue processing

// Use ReadOnlySequence for zero-copy scenarios
ReadOnlySequence<byte> sequence = GetSequenceFromPipe();
var reader = new Utf8JsonReader(sequence);
```

## Considerations

### Forward-Only Limitation

Utf8JsonReader is forward-only and cannot revisit previous tokens. To access earlier values, store them during parsing or use `JsonDocument` for random access.

### Ref Struct Constraints

Utf8JsonReader is a ref struct, which prevents it from being used in async methods, captured in lambdas, or stored as fields. For async scenarios, parse synchronously in a helper method or buffer data first.

```csharp
// Wrong: Cannot use ref struct in async method
// public async Task ParseAsync()
// {
//     var reader = new Utf8JsonReader(data);
//     await SomeAsync();
//     reader.Read(); // Error
// }

// Right: Synchronous parsing
public void Parse(byte[] data)
{
    var reader = new Utf8JsonReader(data);
    while (reader.Read())
    {
        // Process
    }
}
```
