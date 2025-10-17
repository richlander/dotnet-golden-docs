# System.Text.Json.Utf8JsonWriter
## Quick Start

```csharp
using System.Text.Json;

// Write to memory stream
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream, new JsonWriterOptions { Indented = true });

writer.WriteStartObject();
writer.WriteString("name", "Alice");
writer.WriteNumber("age", 30);
writer.WriteBoolean("active", true);
writer.WriteEndObject();

writer.Flush();

// Get JSON as string
string json = Encoding.UTF8.GetString(stream.ToArray());
Console.WriteLine(json);
// {
//   "name": "Alice",
//   "age": 30,
//   "active": true
// }
```

## Writing Simple Objects

Create JSON objects with primitive properties.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream);

writer.WriteStartObject();

// Write different value types
writer.WriteString("id", "12345");
writer.WriteNumber("count", 42);
writer.WriteBoolean("enabled", true);
writer.WriteNull("metadata");

writer.WriteEndObject();

writer.Flush();
```

## Writing Arrays

Generate JSON arrays with type-specific elements.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream);

writer.WriteStartObject();

// Array of numbers
writer.WritePropertyName("numbers");
writer.WriteStartArray();
writer.WriteNumberValue(10);
writer.WriteNumberValue(20);
writer.WriteNumberValue(30);
writer.WriteEndArray();

// Array of strings
writer.WritePropertyName("tags");
writer.WriteStartArray();
writer.WriteStringValue("featured");
writer.WriteStringValue("new");
writer.WriteStringValue("sale");
writer.WriteEndArray();

writer.WriteEndObject();
writer.Flush();
```

## Writing Nested Objects

Create deeply nested JSON structures.

```csharp
using var stream = new MemoryStream();
using var writer = new Utf8JsonWriter(stream, new JsonWriterOptions { Indented = true });

writer.WriteStartObject();

writer.WriteString("userId", "123");

// Nested profile object
writer.WritePropertyName("profile");
writer.WriteStartObject();
writer.WriteString("name", "Alice");

// Deeply nested contact object
writer.WritePropertyName("contact");
writer.WriteStartObject();
writer.WriteString("email", "alice@example.com");
writer.WriteString("phone", "555-1234");
writer.WriteEndObject();

writer.WriteEndObject();

writer.WriteEndObject();

writer.Flush();
```

## Writing with Formatting Options

Control JSON output formatting.

```csharp
// Indented output for readability
var indentedOptions = new JsonWriterOptions 
{ 
    Indented = true,
    Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping
};

using var writer1 = new Utf8JsonWriter(stream, indentedOptions);
writer1.WriteStartObject();
writer1.WriteString("key", "value");
writer1.WriteEndObject();

// Compact output for size
var compactOptions = new JsonWriterOptions { Indented = false };

using var writer2 = new Utf8JsonWriter(stream, compactOptions);
writer2.WriteStartObject();
writer2.WriteString("key", "value");
writer2.WriteEndObject();
```
