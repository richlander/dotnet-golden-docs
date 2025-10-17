# System.Text.Json.Utf8JsonReader
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
