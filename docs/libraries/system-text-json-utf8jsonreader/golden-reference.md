# System.Text.Json.Utf8JsonReader

## Overview

System.Text.Json.Utf8JsonReader is a high-performance, low-allocation, forward-only reader for UTF-8 encoded JSON. It operates directly on UTF-8 byte sequences without string allocation, providing the lowest-level API for JSON parsing in .NET. The reader advances token by token through JSON, exposing each structural element and value as it encounters them.

Utf8JsonReader is a ref struct that operates on `ReadOnlySpan<byte>` or `ReadOnlySequence<byte>`, enabling zero-allocation parsing when working with UTF-8 data. This design makes it ideal for streaming scenarios, large file processing, and performance-critical parsing where memory allocation must be minimized.

The reader provides complete control over parsing, allowing custom validation, selective value extraction, and transformation during reading. Applications call `Read()` to advance to the next token, then inspect `TokenType` and extract values using type-specific methods. The forward-only nature means values cannot be revisited without reparsing.

Key capabilities:

- Forward-only parsing: Sequential token-by-token reading
- Zero allocation: Direct UTF-8 processing without string conversion
- Streaming support: Process data as it arrives without buffering
- Span-based: Works with `ReadOnlySpan<byte>` and `ReadOnlySequence<byte>`
- Custom validation: Validate structure and values during parsing
- Selective extraction: Read only needed values, skip the rest
- Maximum performance: Fastest JSON parsing in System.Text.Json

Utf8JsonReader sits at the bottom of the System.Text.Json stack. `JsonDocument` and `JsonSerializer` use Utf8JsonReader internally. Applications use Utf8JsonReader directly when they need maximum performance, streaming support, or custom parsing logic that higher-level APIs cannot provide.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Large file processing | Stream to `Utf8JsonReader` | Constant memory usage |
| Network stream parsing | Read as data arrives | Immediate processing |
| Custom validation | Check values during parsing | Early error detection |
| Selective extraction | Read needed values, skip rest | Minimal processing |
| Performance-critical parsing | Direct UTF-8 reading | Lowest allocation |
| Protocol implementation | Parse streaming JSON | Full control |
| Transform during parse | Process tokens, write output | Single-pass transformation |
| Array streaming | Read elements one at a time | Constant memory |
| Random access | Use `JsonDocument` instead | O(1) property access |
| Modification needed | Use `JsonNode` instead | Mutable DOM |
| Known structure | Use `JsonSerializer.Deserialize<T>()` instead | Type safety |

## Quick Start

```csharp
using System.Text.Json;

// JSON as UTF-8 bytes
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    "name": "Alice",
    "age": 30,
    "active": true
}
""");

// Create reader from span
var reader = new Utf8JsonReader(utf8Json);

// Read tokens sequentially
while (reader.Read())
{
    switch (reader.TokenType)
    {
        case JsonTokenType.PropertyName:
            string propertyName = reader.GetString()!;
            Console.WriteLine($"Property: {propertyName}");
            break;
            
        case JsonTokenType.String:
            string stringValue = reader.GetString()!;
            Console.WriteLine($"  String: {stringValue}");
            break;
            
        case JsonTokenType.Number:
            int numberValue = reader.GetInt32();
            Console.WriteLine($"  Number: {numberValue}");
            break;
            
        case JsonTokenType.True:
        case JsonTokenType.False:
            bool boolValue = reader.GetBoolean();
            Console.WriteLine($"  Boolean: {boolValue}");
            break;
    }
}
```

## Reading JSON Tokens

Advance through JSON token by token using `Read()` method.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""{"id":1,"name":"Product"}""");
var reader = new Utf8JsonReader(utf8Json);

while (reader.Read())
{
    JsonTokenType tokenType = reader.TokenType;
    
    // Process based on token type
    switch (tokenType)
    {
        case JsonTokenType.StartObject:
            Console.WriteLine("Start of object");
            break;
        case JsonTokenType.EndObject:
            Console.WriteLine("End of object");
            break;
        case JsonTokenType.StartArray:
            Console.WriteLine("Start of array");
            break;
        case JsonTokenType.EndArray:
            Console.WriteLine("End of array");
            break;
        case JsonTokenType.PropertyName:
            string name = reader.GetString()!;
            Console.WriteLine($"Property name: {name}");
            break;
        case JsonTokenType.String:
            string value = reader.GetString()!;
            Console.WriteLine($"String value: {value}");
            break;
        case JsonTokenType.Number:
            // Type depends on actual value
            break;
        case JsonTokenType.True:
        case JsonTokenType.False:
            bool boolValue = reader.GetBoolean();
            break;
        case JsonTokenType.Null:
            Console.WriteLine("Null value");
            break;
    }
}
```

## Extracting Specific Values

Navigate to specific properties and extract their values.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    "userId": 123,
    "username": "alice",
    "score": 98.5,
    "verified": true
}
""");

var reader = new Utf8JsonReader(utf8Json);

int userId = 0;
string username = string.Empty;
double score = 0;
bool verified = false;

while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.PropertyName)
    {
        string propertyName = reader.GetString()!;
        reader.Read(); // Move to value
        
        switch (propertyName)
        {
            case "userId":
                userId = reader.GetInt32();
                break;
            case "username":
                username = reader.GetString()!;
                break;
            case "score":
                score = reader.GetDouble();
                break;
            case "verified":
                verified = reader.GetBoolean();
                break;
        }
    }
}

Console.WriteLine($"User {userId}: {username}, Score: {score}, Verified: {verified}");
```

## Reading Different Number Types

Numbers can be read as different types based on value.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    "integer": 42,
    "long": 9223372036854775807,
    "double": 3.14159,
    "decimal": 99.99
}
""");

var reader = new Utf8JsonReader(utf8Json);

while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.PropertyName)
    {
        string propertyName = reader.GetString()!;
        reader.Read(); // Move to value
        
        switch (propertyName)
        {
            case "integer":
                int intValue = reader.GetInt32();
                break;
            case "long":
                long longValue = reader.GetInt64();
                break;
            case "double":
                double doubleValue = reader.GetDouble();
                break;
            case "decimal":
                decimal decimalValue = reader.GetDecimal();
                break;
        }
    }
}
```

## Reading Arrays

Process JSON arrays element by element.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    "items": [10, 20, 30, 40, 50]
}
""");

var reader = new Utf8JsonReader(utf8Json);

while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.PropertyName)
    {
        string propertyName = reader.GetString()!;
        
        if (propertyName == "items")
        {
            reader.Read(); // Move to StartArray
            
            if (reader.TokenType == JsonTokenType.StartArray)
            {
                while (reader.Read() && reader.TokenType != JsonTokenType.EndArray)
                {
                    int value = reader.GetInt32();
                    Console.WriteLine($"Item: {value}");
                }
            }
        }
    }
}
```

## Reading Nested Objects

Navigate nested JSON structures.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    "user": {
        "profile": {
            "name": "Alice",
            "email": "alice@example.com"
        }
    }
}
""");

var reader = new Utf8JsonReader(utf8Json);

int depth = 0;
while (reader.Read())
{
    switch (reader.TokenType)
    {
        case JsonTokenType.StartObject:
            depth++;
            Console.WriteLine($"{new string(' ', depth * 2)}{{");
            break;
            
        case JsonTokenType.EndObject:
            Console.WriteLine($"{new string(' ', depth * 2)}}}");
            depth--;
            break;
            
        case JsonTokenType.PropertyName:
            string name = reader.GetString()!;
            Console.WriteLine($"{new string(' ', depth * 2)}{name}:");
            break;
            
        case JsonTokenType.String:
            string value = reader.GetString()!;
            Console.WriteLine($"{new string(' ', depth * 2)}  {value}");
            break;
    }
}
```

## Skipping Values

Skip tokens without processing using `Skip()` method.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    "needed": "value",
    "skip": {
        "nested": {
            "deep": "data"
        }
    },
    "alsoNeeded": 42
}
""");

var reader = new Utf8JsonReader(utf8Json);

while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.PropertyName)
    {
        string propertyName = reader.GetString()!;
        
        if (propertyName == "skip")
        {
            // Skip entire nested object
            reader.Skip();
        }
        else
        {
            reader.Read(); // Move to value
            
            if (propertyName == "needed")
            {
                string value = reader.GetString()!;
                Console.WriteLine($"Needed: {value}");
            }
            else if (propertyName == "alsoNeeded")
            {
                int value = reader.GetInt32();
                Console.WriteLine($"Also needed: {value}");
            }
        }
    }
}
```

## Reading from ReadOnlySequence

Process multi-segment buffers from network streams or pipes.

```csharp
// Simulate multi-segment buffer
byte[] segment1 = Encoding.UTF8.GetBytes("""{"na""");
byte[] segment2 = Encoding.UTF8.GetBytes("""me":"Al""");
byte[] segment3 = Encoding.UTF8.GetBytes("""ice"}""");

var sequence = new ReadOnlySequence<byte>(
    new TestSequenceSegment(segment1,
    new TestSequenceSegment(segment2,
    new TestSequenceSegment(segment3, null))));

var reader = new Utf8JsonReader(sequence);

while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.PropertyName)
    {
        string propertyName = reader.GetString()!;
        reader.Read();
        string value = reader.GetString()!;
        Console.WriteLine($"{propertyName}: {value}");
    }
}

// Helper class for creating ReadOnlySequence
class TestSequenceSegment : ReadOnlySequenceSegment<byte>
{
    public TestSequenceSegment(byte[] data, TestSequenceSegment? next)
    {
        Memory = data;
        Next = next;
        RunningIndex = next?.RunningIndex + next.Memory.Length ?? 0;
    }
}
```

## Reading with Options

Configure reader behavior through options.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    // This is a comment
    "value": 42,
    "trailing": true,
}
""");

var options = new JsonReaderOptions
{
    AllowTrailingCommas = true,
    CommentHandling = JsonCommentHandling.Skip,
    MaxDepth = 64
};

var reader = new Utf8JsonReader(utf8Json, options);

while (reader.Read())
{
    // Process normally - comments skipped, trailing comma allowed
}
```

## Checking Current Position

Access position information for error reporting.

```csharp
byte[] utf8Json = Encoding.UTF8.GetBytes("""
{
    "line1": "value",
    "line2": 42
}
""");

var reader = new Utf8JsonReader(utf8Json);

while (reader.Read())
{
    Console.WriteLine($"Position: {reader.Position}, " +
                     $"Line: {reader.CurrentState.Position.GetInteger()}, " +
                     $"Depth: {reader.CurrentDepth}");
}
```

## Using with Streaming Network Data

Process JSON as it arrives from network without buffering.

```csharp
public async Task ProcessStreamingJsonAsync(Stream networkStream)
{
    byte[] buffer = new byte[4096];
    var leftover = new List<byte>();
    
    while (true)
    {
        int bytesRead = await networkStream.ReadAsync(buffer);
        if (bytesRead == 0) break;
        
        // Combine leftover with new data
        var jsonData = leftover.Concat(buffer.Take(bytesRead)).ToArray();
        
        var reader = new Utf8JsonReader(jsonData, isFinalBlock: false, 
            new JsonReaderState());
        
        try
        {
            while (reader.Read())
            {
                // Process tokens
                if (reader.TokenType == JsonTokenType.PropertyName)
                {
                    string propertyName = reader.GetString()!;
                    reader.Read();
                    ProcessValue(reader);
                }
            }
            
            // Clear leftover if all consumed
            leftover.Clear();
        }
        catch (JsonException)
        {
            // Incomplete JSON - save for next read
            leftover = jsonData.Skip((int)reader.BytesConsumed).ToList();
        }
    }
}

void ProcessValue(Utf8JsonReader reader)
{
    switch (reader.TokenType)
    {
        case JsonTokenType.String:
            Console.WriteLine(reader.GetString());
            break;
        case JsonTokenType.Number:
            Console.WriteLine(reader.GetInt32());
            break;
    }
}
```

## Using for Custom Deserialization

Implement custom parsing logic for specific requirements.

```csharp
public class CustomDeserializer
{
    public Product DeserializeProduct(byte[] utf8Json)
    {
        var reader = new Utf8JsonReader(utf8Json);
        
        var product = new Product();
        
        while (reader.Read())
        {
            if (reader.TokenType == JsonTokenType.PropertyName)
            {
                string propertyName = reader.GetString()!;
                reader.Read();
                
                switch (propertyName)
                {
                    case "id":
                        product.Id = reader.GetInt32();
                        break;
                    case "name":
                        product.Name = reader.GetString()!;
                        break;
                    case "price":
                        product.Price = reader.GetDecimal();
                        break;
                    case "tags":
                        product.Tags = ReadStringArray(ref reader);
                        break;
                }
            }
        }
        
        return product;
    }
    
    private List<string> ReadStringArray(ref Utf8JsonReader reader)
    {
        var result = new List<string>();
        
        if (reader.TokenType == JsonTokenType.StartArray)
        {
            while (reader.Read() && reader.TokenType != JsonTokenType.EndArray)
            {
                result.Add(reader.GetString()!);
            }
        }
        
        return result;
    }
}

public class Product
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public List<string> Tags { get; set; } = new();
}
```

## Using for Validation

Validate JSON structure and values during parsing.

```csharp
public class JsonValidator
{
    public ValidationResult ValidateConfiguration(byte[] utf8Json)
    {
        var reader = new Utf8JsonReader(utf8Json);
        var errors = new List<string>();
        var requiredFields = new HashSet<string> { "version", "name", "settings" };
        var foundFields = new HashSet<string>();
        
        try
        {
            while (reader.Read())
            {
                if (reader.TokenType == JsonTokenType.PropertyName)
                {
                    string propertyName = reader.GetString()!;
                    foundFields.Add(propertyName);
                    reader.Read(); // Move to value
                    
                    // Validate specific fields
                    if (propertyName == "version")
                    {
                        if (reader.TokenType != JsonTokenType.Number)
                        {
                            errors.Add("version must be a number");
                        }
                        else if (reader.GetInt32() < 1)
                        {
                            errors.Add("version must be positive");
                        }
                    }
                    else if (propertyName == "name")
                    {
                        if (reader.TokenType != JsonTokenType.String)
                        {
                            errors.Add("name must be a string");
                        }
                        else if (string.IsNullOrWhiteSpace(reader.GetString()))
                        {
                            errors.Add("name cannot be empty");
                        }
                    }
                }
            }
            
            // Check for missing required fields
            var missing = requiredFields.Except(foundFields);
            foreach (var field in missing)
            {
                errors.Add($"Missing required field: {field}");
            }
        }
        catch (JsonException ex)
        {
            errors.Add($"Invalid JSON: {ex.Message}");
        }
        
        return new ValidationResult
        {
            IsValid = errors.Count == 0,
            Errors = errors
        };
    }
}

public class ValidationResult
{
    public bool IsValid { get; set; }
    public List<string> Errors { get; set; } = new();
}
```

## Using for Streaming Array Processing

Process large JSON arrays with constant memory usage.

```csharp
public async Task ProcessLargeArrayAsync(Stream fileStream)
{
    byte[] buffer = ArrayPool<byte>.Shared.Rent(8192);
    
    try
    {
        int bytesRead = await fileStream.ReadAsync(buffer);
        var reader = new Utf8JsonReader(buffer.AsSpan(0, bytesRead));
        
        // Find array start
        while (reader.Read())
        {
            if (reader.TokenType == JsonTokenType.PropertyName && 
                reader.GetString() == "items")
            {
                reader.Read(); // Move to StartArray
                break;
            }
        }
        
        // Process array elements
        int count = 0;
        while (reader.Read() && reader.TokenType != JsonTokenType.EndArray)
        {
            if (reader.TokenType == JsonTokenType.StartObject)
            {
                var item = ReadItem(ref reader);
                await ProcessItemAsync(item);
                count++;
                
                if (count % 1000 == 0)
                {
                    Console.WriteLine($"Processed {count} items");
                }
            }
        }
    }
    finally
    {
        ArrayPool<byte>.Shared.Return(buffer);
    }
}

private object ReadItem(ref Utf8JsonReader reader)
{
    // Read single object from array
    var item = new Dictionary<string, object>();
    
    while (reader.Read() && reader.TokenType != JsonTokenType.EndObject)
    {
        if (reader.TokenType == JsonTokenType.PropertyName)
        {
            string name = reader.GetString()!;
            reader.Read();
            
            object value = reader.TokenType switch
            {
                JsonTokenType.String => reader.GetString()!,
                JsonTokenType.Number => reader.GetInt32(),
                JsonTokenType.True => true,
                JsonTokenType.False => false,
                _ => null!
            };
            
            item[name] = value;
        }
    }
    
    return item;
}

private Task ProcessItemAsync(object item) => Task.CompletedTask;
```

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

### UTF-8 Requirement

Reader only accepts UTF-8 data. Convert other encodings to UTF-8 before parsing:

```csharp
string json = GetJsonString();
byte[] utf8Json = Encoding.UTF8.GetBytes(json);
var reader = new Utf8JsonReader(utf8Json);
```

### Manual State Management

When parsing multi-segment data, manually track `JsonReaderState` between segments to maintain parsing context.

### Performance Tradeoffs

Utf8JsonReader offers lowest allocation but requires more code than higher-level APIs. Use for performance-critical paths where the complexity is justified by performance gains.

## Related Concepts

**Used by System.Text.Json.Utf8JsonReader:**

- `ReadOnlySpan<byte>` (zero-allocation data access)
- `ReadOnlySequence<byte>` (multi-segment buffers)
- UTF-8 encoding (direct byte processing)

**Uses System.Text.Json.Utf8JsonReader:**

- `JsonDocument` (builds DOM from reader)
- `JsonSerializer` (deserialization implementation)
- Custom parsers (specialized parsing logic)
- Protocol implementations (streaming JSON protocols)
- Large file processors (constant memory parsing)

**Alternative to System.Text.Json.Utf8JsonReader:**

- `JsonDocument` (DOM access with higher allocation)
- `JsonSerializer.Deserialize<T>()` (strongly-typed, easier API)
- `JsonNode` (mutable DOM with highest allocation)
