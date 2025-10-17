# System.Text.Json.JsonSerializer
## Handling Enums

Serialize enums as numbers or strings.

```csharp
using System.Text.Json.Serialization;

public enum Status
{
    Active = 1,
    Inactive = 2,
    Pending = 3
}

public class Order
{
    public int Id { get; set; }
    public Status Status { get; set; }
}

var order = new Order { Id = 123, Status = Status.Active };

// Default: Enum as number
string numberJson = JsonSerializer.Serialize(order);
// {"Id":123,"Status":1}

// Enum as string
var stringOptions = new JsonSerializerOptions
{
    Converters = { new JsonStringEnumConverter() }
};
string stringJson = JsonSerializer.Serialize(order, stringOptions);
// {"Id":123,"Status":"Active"}

// Enum as string with naming policy
var camelCaseEnumOptions = new JsonSerializerOptions
{
    Converters = { new JsonStringEnumConverter(JsonNamingPolicy.CamelCase) }
};
string camelJson = JsonSerializer.Serialize(order, camelCaseEnumOptions);
// {"Id":123,"Status":"active"}
```

## Handling DateTime and DateTimeOffset

Serialize date and time values.

```csharp
public class Event
{
    public string Name { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public DateTimeOffset ScheduledFor { get; set; }
}

var evt = new Event
{
    Name = "Conference",
    CreatedAt = DateTime.UtcNow,
    ScheduledFor = DateTimeOffset.UtcNow.AddDays(30)
};

// Default: ISO 8601 format
string json = JsonSerializer.Serialize(evt);
// {"Name":"Conference","CreatedAt":"2024-01-15T10:30:00Z","ScheduledFor":"2024-02-14T10:30:00+00:00"}

// Deserialize
Event? deserialized = JsonSerializer.Deserialize<Event>(json);
```

## UTF-8 Operations

Avoid string encoding overhead with UTF-8 operations.

```csharp
var user = new User { Id = 1, Name = "Alice" };

// Serialize to UTF-8 bytes (no string allocation)
byte[] utf8Json = JsonSerializer.SerializeToUtf8Bytes(user);

// Write UTF-8 bytes to stream
await using var stream = new MemoryStream();
await stream.WriteAsync(utf8Json);

// Deserialize from UTF-8 bytes
ReadOnlySpan<byte> utf8Span = utf8Json;
User? deserialized = JsonSerializer.Deserialize<User>(utf8Span);

// Deserialize from UTF-8 byte array
User? deserializedFromArray = JsonSerializer.Deserialize<User>(utf8Json);
```
