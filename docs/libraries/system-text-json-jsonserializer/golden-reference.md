# System.Text.Json.JsonSerializer

## Overview

System.Text.Json.JsonSerializer provides high-level APIs for converting between .NET objects and JSON text. It offers simple static methods for serialization and deserialization that handle the complexity of JSON parsing and generation. The API supports both synchronous operations for string-based JSON and asynchronous operations for streams.

JsonSerializer operates in two modes: reflection-based and source generation-based. Reflection mode discovers types at runtime and works with any .NET type without configuration. Source generation mode produces serialization code at compile time, eliminating reflection overhead and enabling Native AOT compatibility. Both modes use the same API surface, differing only in how type information is provided.

The serializer supports customization through `JsonSerializerOptions`, including property naming policies, null handling, number formats, and custom converters. Options can be configured globally or per operation. The serializer integrates with ASP.NET Core, HttpClient extensions, and configuration systems as the default JSON handler.

Key capabilities:

- Simple API: Single-line serialization and deserialization
- Type safety: Strongly-typed operations with compile-time checking
- Async support: Stream-based operations for files and network I/O
- Customization: Naming policies, converters, and formatting options
- Source generation: Compile-time code generation for performance
- UTF-8 optimization: Direct byte operations for web scenarios
- Collection support: Arrays, lists, dictionaries, and custom collections
- Polymorphism: Type discriminators for inheritance hierarchies

JsonSerializer sits at the top of the System.Text.Json stack, using Utf8JsonReader and Utf8JsonWriter internally. Applications use JsonSerializer for most JSON operations, falling back to lower-level APIs only when specialized behavior is needed.

| Scenario | Solution | Key Benefit |
|----------|----------|-------------|
| Basic serialization | `Serialize<T>(object)` | Simple one-line API |
| Basic deserialization | `Deserialize<T>(string)` | Type-safe parsing |
| File I/O | `SerializeAsync<T>(stream, object)` | Async without blocking |
| Web defaults | `Serialize(object, JsonSerializerOptions.Web)` | ASP.NET Core conventions |
| Custom naming | Configure `PropertyNamingPolicy` | Control JSON format |
| Ignore nulls | Set `DefaultIgnoreCondition` | Smaller payloads |
| Source generation | Pass `JsonTypeInfo<T>` parameter | Maximum performance |
| UTF-8 operations | `SerializeToUtf8Bytes<T>(object)` | Zero string allocation |
| Streaming arrays | `DeserializeAsyncEnumerable<T>(stream)` | Constant memory |
| Custom logic | Use `Utf8JsonReader`/`Utf8JsonWriter` instead | Full control |
| DOM access | Use `JsonDocument` or `JsonNode` instead | Dynamic JSON |

## Quick Start

```csharp
using System.Text.Json;

// Define a type
public record Product(int Id, string Name, decimal Price);

// Serialize: Object → JSON string
var product = new Product(1, "Laptop", 999.99m);
string json = JsonSerializer.Serialize(product);
// {"Id":1,"Name":"Laptop","Price":999.99}

// Deserialize: JSON string → Object
string jsonString = """{"Id":2,"Name":"Mouse","Price":24.99}""";
Product mouse = JsonSerializer.Deserialize<Product>(jsonString)!;

Console.WriteLine($"{mouse.Name}: ${mouse.Price}");
// Mouse: $24.99
```

## Serializing Objects

Convert .NET objects to JSON strings.

```csharp
public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public bool IsActive { get; set; }
}

var user = new User
{
    Id = 123,
    Name = "Alice",
    Email = "alice@example.com",
    IsActive = true
};

// Serialize to JSON string
string json = JsonSerializer.Serialize(user);
// {"Id":123,"Name":"Alice","Email":"alice@example.com","IsActive":true}

// Serialize with indentation for readability
var options = new JsonSerializerOptions { WriteIndented = true };
string formattedJson = JsonSerializer.Serialize(user, options);
```

## Deserializing Objects

Convert JSON strings to .NET objects.

```csharp
string json = """
{
    "Id": 123,
    "Name": "Alice",
    "Email": "alice@example.com",
    "IsActive": true
}
""";

// Deserialize to strongly-typed object
User? user = JsonSerializer.Deserialize<User>(json);

if (user != null)
{
    Console.WriteLine($"User: {user.Name}, Email: {user.Email}");
}

// Handle null result
User user2 = JsonSerializer.Deserialize<User>(json) 
    ?? throw new InvalidOperationException("Failed to deserialize user");
```

## Async File Operations

Read and write JSON files asynchronously.

```csharp
public class DataService
{
    public async Task SaveToFileAsync<T>(string filePath, T data)
    {
        await using FileStream stream = File.Create(filePath);
        await JsonSerializer.SerializeAsync(stream, data);
    }
    
    public async Task<T?> LoadFromFileAsync<T>(string filePath)
    {
        await using FileStream stream = File.OpenRead(filePath);
        return await JsonSerializer.DeserializeAsync<T>(stream);
    }
}

// Usage
var service = new DataService();
var user = new User { Id = 1, Name = "Alice", Email = "alice@example.com" };

// Write to file
await service.SaveToFileAsync("user.json", user);

// Read from file
User? loadedUser = await service.LoadFromFileAsync<User>("user.json");
```

## Configuring Naming Policies

Control how property names are formatted in JSON.

```csharp
public class ApiResponse
{
    public int UserId { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
}

var response = new ApiResponse
{
    UserId = 123,
    FirstName = "Alice",
    LastName = "Smith"
};

// Default: PascalCase property names
string defaultJson = JsonSerializer.Serialize(response);
// {"UserId":123,"FirstName":"Alice","LastName":"Smith"}

// camelCase naming policy
var camelCaseOptions = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
};
string camelCaseJson = JsonSerializer.Serialize(response, camelCaseOptions);
// {"userId":123,"firstName":"Alice","lastName":"Smith"}

// snake_case_lower naming policy (.NET 8+)
var snakeCaseOptions = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.SnakeCaseLower
};
string snakeCaseJson = JsonSerializer.Serialize(response, snakeCaseOptions);
// {"user_id":123,"first_name":"Alice","last_name":"Smith"}

// kebab-case-lower naming policy (.NET 8+)
var kebabCaseOptions = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.KebabCaseLower
};
string kebabCaseJson = JsonSerializer.Serialize(response, kebabCaseOptions);
// {"user-id":123,"first-name":"Alice","last-name":"Smith"}
```

## Using Web Defaults

Apply ASP.NET Core conventions for web APIs.

```csharp
// Web defaults: camelCase, case-insensitive reading
var options = JsonSerializerOptions.Web;

var data = new { UserId = 123, UserName = "alice" };
string json = JsonSerializer.Serialize(data, options);
// {"userId":123,"userName":"alice"}

// Case-insensitive deserialization
string inputJson = """{"userid":123,"username":"alice"}""";
var result = JsonSerializer.Deserialize<ApiResponse>(inputJson, options);
// Matches despite different casing
```

## Ignoring Properties

Control which properties are included in JSON output.

```csharp
using System.Text.Json.Serialization;

public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    
    [JsonIgnore]
    public string Password { get; set; } = string.Empty;
    
    public string? Email { get; set; }
    public int? Age { get; set; }
}

var user = new User
{
    Id = 1,
    Name = "Alice",
    Password = "secret123",
    Email = null,
    Age = null
};

// Password is never serialized due to [JsonIgnore]
string json = JsonSerializer.Serialize(user);
// {"Id":1,"Name":"Alice","Email":null,"Age":null}

// Ignore null values
var options = new JsonSerializerOptions
{
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
};
string jsonWithoutNulls = JsonSerializer.Serialize(user, options);
// {"Id":1,"Name":"Alice"}
```

## Custom Property Names

Override property names in JSON output.

```csharp
using System.Text.Json.Serialization;

public class Product
{
    [JsonPropertyName("product_id")]
    public int Id { get; set; }
    
    [JsonPropertyName("product_name")]
    public string Name { get; set; } = string.Empty;
    
    [JsonPropertyName("unit_price")]
    public decimal Price { get; set; }
}

var product = new Product { Id = 1, Name = "Widget", Price = 29.99m };
string json = JsonSerializer.Serialize(product);
// {"product_id":1,"product_name":"Widget","unit_price":29.99}
```

## Handling Collections

Serialize and deserialize arrays, lists, and dictionaries.

```csharp
// Arrays
int[] numbers = { 1, 2, 3, 4, 5 };
string arrayJson = JsonSerializer.Serialize(numbers);
int[]? deserialized = JsonSerializer.Deserialize<int[]>(arrayJson);

// Lists
var users = new List<User>
{
    new() { Id = 1, Name = "Alice" },
    new() { Id = 2, Name = "Bob" }
};
string listJson = JsonSerializer.Serialize(users);
List<User>? userList = JsonSerializer.Deserialize<List<User>>(listJson);

// Dictionaries
var config = new Dictionary<string, string>
{
    ["host"] = "localhost",
    ["port"] = "8080",
    ["debug"] = "true"
};
string dictJson = JsonSerializer.Serialize(config);
Dictionary<string, string>? configDict = JsonSerializer.Deserialize<Dictionary<string, string>>(dictJson);
// {"host":"localhost","port":"8080","debug":"true"}

// Dictionary with complex values
var users = new Dictionary<int, User>
{
    [1] = new() { Id = 1, Name = "Alice" },
    [2] = new() { Id = 2, Name = "Bob" }
};
string usersJson = JsonSerializer.Serialize(users);
// {"1":{"Id":1,"Name":"Alice"},"2":{"Id":2,"Name":"Bob"}}
```

## Working with Records

Serialize and deserialize C# records.

```csharp
// Positional record
public record Product(int Id, string Name, decimal Price);

var product = new Product(1, "Widget", 29.99m);
string json = JsonSerializer.Serialize(product);
// {"Id":1,"Name":"Widget","Price":29.99}

Product? deserialized = JsonSerializer.Deserialize<Product>(json);

// Record with optional properties
public record User
{
    public required int Id { get; init; }
    public required string Name { get; init; }
    public string? Email { get; init; }
}

var user = new User { Id = 1, Name = "Alice", Email = "alice@example.com" };
string userJson = JsonSerializer.Serialize(user);
```

## Nullable Reference Types

Enforce nullable annotations during serialization and deserialization.

```csharp
#nullable enable

public class UserProfile
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? OptionalEmail { get; set; }
}

var options = new JsonSerializerOptions
{
    RespectNullableAnnotations = true
};

// Valid: null for nullable property
string validJson = """{"Id":1,"Name":"Alice","OptionalEmail":null}""";
UserProfile? valid = JsonSerializer.Deserialize<UserProfile>(validJson, options);

// Invalid: null for non-nullable property throws exception
string invalidJson = """{"Id":1,"Name":null,"OptionalEmail":"alice@example.com"}""";
// JsonException: JSON value cannot be null for non-nullable property 'Name'
```

## Required Properties

Mark properties as required for deserialization.

```csharp
using System.Text.Json.Serialization;

public class Configuration
{
    [JsonRequired]
    public string Host { get; set; } = string.Empty;
    
    [JsonRequired]
    public int Port { get; set; }
    
    public bool Debug { get; set; }
}

// Valid: All required properties present
string validJson = """{"Host":"localhost","Port":8080,"Debug":true}""";
Configuration? config = JsonSerializer.Deserialize<Configuration>(validJson);

// Invalid: Missing required property throws exception
string invalidJson = """{"Host":"localhost","Debug":true}""";
// JsonException: Required property 'Port' not found in JSON
```

## Deserializing with Constructors

Use constructors for immutable objects.

```csharp
public class ImmutableUser
{
    public int Id { get; }
    public string Name { get; }
    public string Email { get; }
    
    [JsonConstructor]
    public ImmutableUser(int id, string name, string email)
    {
        Id = id;
        Name = name;
        Email = email;
    }
}

string json = """{"Id":1,"Name":"Alice","Email":"alice@example.com"}""";
ImmutableUser? user = JsonSerializer.Deserialize<ImmutableUser>(json);

// Constructor parameters match property names (case-insensitive)
// JsonSerializer automatically maps JSON properties to constructor parameters
```

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

## Streaming Large Arrays

Process large JSON arrays incrementally without loading entire array into memory.

```csharp
public async Task ProcessLargeDatasetAsync(Stream stream)
{
    var items = JsonSerializer.DeserializeAsyncEnumerable<DataItem>(stream);
    
    int count = 0;
    await foreach (DataItem? item in items)
    {
        if (item != null)
        {
            await ProcessItemAsync(item);
            count++;
            
            if (count % 1000 == 0)
            {
                Console.WriteLine($"Processed {count} items");
            }
        }
    }
}

public class DataItem
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Value { get; set; }
}

Task ProcessItemAsync(DataItem item) => Task.CompletedTask;
```

## Using Source Generation

Enable compile-time code generation for maximum performance.

```csharp
using System.Text.Json.Serialization;

// Define source generation context
[JsonSerializable(typeof(User))]
[JsonSerializable(typeof(List<User>))]
[JsonSourceGenerationOptions(PropertyNamingPolicy = JsonKnownNamingPolicy.CamelCase)]
public partial class AppJsonContext : JsonSerializerContext { }

var user = new User { Id = 1, Name = "Alice" };

// Use source generation (faster, AOT-compatible)
string json = JsonSerializer.Serialize(user, AppJsonContext.Default.User);
User? deserialized = JsonSerializer.Deserialize(json, AppJsonContext.Default.User);

// Configure as default for all operations
var options = new JsonSerializerOptions
{
    TypeInfoResolver = AppJsonContext.Default
};

string json2 = JsonSerializer.Serialize(user, options);
```

## Custom Converters

Implement custom serialization logic for specific types.

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

// Custom converter for a type
public class DateOnlyConverter : JsonConverter<DateOnly>
{
    public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        return DateOnly.ParseExact(reader.GetString()!, "yyyy-MM-dd");
    }
    
    public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
    {
        writer.WriteStringValue(value.ToString("yyyy-MM-dd"));
    }
}

public class Event
{
    public string Name { get; set; } = string.Empty;
    public DateOnly Date { get; set; }
}

var options = new JsonSerializerOptions
{
    Converters = { new DateOnlyConverter() }
};

var evt = new Event { Name = "Conference", Date = new DateOnly(2024, 6, 15) };
string json = JsonSerializer.Serialize(evt, options);
// {"Name":"Conference","Date":"2024-06-15"}
```

## Polymorphic Serialization

Handle inheritance hierarchies with type discriminators.

```csharp
using System.Text.Json.Serialization;

[JsonPolymorphic(TypeDiscriminatorPropertyName = "type")]
[JsonDerivedType(typeof(Circle), "circle")]
[JsonDerivedType(typeof(Rectangle), "rectangle")]
public abstract class Shape
{
    public string Name { get; set; } = string.Empty;
}

public class Circle : Shape
{
    public double Radius { get; set; }
}

public class Rectangle : Shape
{
    public double Width { get; set; }
    public double Height { get; set; }
}

Shape circle = new Circle { Name = "My Circle", Radius = 5.0 };
string json = JsonSerializer.Serialize(circle);
// {"type":"circle","Name":"My Circle","Radius":5.0}

Shape? deserialized = JsonSerializer.Deserialize<Shape>(json);
if (deserialized is Circle c)
{
    Console.WriteLine($"Circle with radius {c.Radius}");
}
```

## Allowing Trailing Commas and Comments

Parse JSON with relaxed syntax.

```csharp
string json = """
{
    // This is a comment
    "id": 1,
    "name": "Alice",
    "active": true,  // Trailing comma
}
""";

var options = new JsonSerializerOptions
{
    AllowTrailingCommas = true,
    ReadCommentHandling = JsonCommentHandling.Skip
};

User? user = JsonSerializer.Deserialize<User>(json, options);
```

## Handling Large Numbers

Configure number handling for special cases.

```csharp
using System.Text.Json.Serialization;

public class Data
{
    public long LargeNumber { get; set; }
}

// Allow reading numbers from strings
var options = new JsonSerializerOptions
{
    NumberHandling = JsonNumberHandling.AllowReadingFromString
};

// Valid: Number as string
string json = """{"LargeNumber":"9223372036854775807"}""";
Data? data = JsonSerializer.Deserialize<Data>(json, options);

// Also valid: Normal number
string json2 = """{"LargeNumber":9223372036854775807}""";
Data? data2 = JsonSerializer.Deserialize<Data>(json2, options);
```

## Deserializing to Object

Deserialize JSON when type is unknown at compile time.

```csharp
string json = """
{
    "string": "text",
    "number": 42,
    "boolean": true,
    "null": null,
    "array": [1, 2, 3],
    "object": {"nested": "value"}
}
""";

// Deserialize to object? (uses JsonElement internally)
object? result = JsonSerializer.Deserialize<object>(json);

// Result is JsonElement
if (result is JsonElement element)
{
    string stringValue = element.GetProperty("string").GetString()!;
    int numberValue = element.GetProperty("number").GetInt32();
}
```

## Handling Duplicate Property Names

Control behavior when JSON contains duplicate properties.

```csharp
string json = """
{
    "id": 1,
    "name": "First",
    "name": "Second"
}
""";

// Default: Last value wins
User? user1 = JsonSerializer.Deserialize<User>(json);
// user1.Name == "Second"

// Strict: Reject duplicates
var strictOptions = new JsonSerializerOptions
{
    AllowDuplicateProperties = false
};

// JsonException: Duplicate property 'name'
// User? user2 = JsonSerializer.Deserialize<User>(json, strictOptions);
```

## Setting Maximum Depth

Prevent stack overflow from deeply nested JSON.

```csharp
var options = new JsonSerializerOptions
{
    MaxDepth = 32  // Default is 64
};

// Valid: Depth within limit
string validJson = """{"a":{"b":{"c":"value"}}}""";
object? valid = JsonSerializer.Deserialize<object>(validJson, options);

// Invalid: Exceeds maximum depth
string tooDeep = new string('{', 50) + "\"value\"" + new string('}', 50);
// JsonException: Maximum depth exceeded
```

## Reusing JsonSerializerOptions

Create and reuse options for better performance.

```csharp
public static class JsonDefaults
{
    public static readonly JsonSerializerOptions Web = new()
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        WriteIndented = false,
        DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
    };
    
    public static readonly JsonSerializerOptions Indented = new()
    {
        WriteIndented = true
    };
}

// Reuse across operations
string json1 = JsonSerializer.Serialize(user, JsonDefaults.Web);
string json2 = JsonSerializer.Serialize(product, JsonDefaults.Web);

// Don't create new options per operation
// This is inefficient:
// string bad = JsonSerializer.Serialize(user, new JsonSerializerOptions { WriteIndented = true });
```

## Error Handling

Handle deserialization errors gracefully.

```csharp
public User? SafeDeserialize(string json)
{
    try
    {
        return JsonSerializer.Deserialize<User>(json);
    }
    catch (JsonException ex)
    {
        Console.WriteLine($"JSON error at position {ex.BytePositionInLine}: {ex.Message}");
        return null;
    }
    catch (NotSupportedException ex)
    {
        Console.WriteLine($"Type not supported: {ex.Message}");
        return null;
    }
}

// Usage
string malformedJson = """{"Id":1,"Name":"Alice",,}""";
User? user = SafeDeserialize(malformedJson);
if (user == null)
{
    // Handle error
}
```

## Considerations

### Performance Characteristics

Reflection-based serialization discovers types at runtime. For performance-critical code, use source generation to eliminate reflection overhead. Source generation provides 1.3-5x faster serialization with lower memory allocation.

### Type Requirements

Types must have a parameterless constructor or use `[JsonConstructor]` to specify a constructor. Properties must have getters for serialization and setters for deserialization unless init-only or using constructor parameters.

### Null Handling

By default, null values are serialized. Use `DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull` to omit null values from output. For nullable reference types, enable `RespectNullableAnnotations` to enforce nullability contracts.

### Case Sensitivity

Property name matching is case-sensitive by default. Use `PropertyNameCaseInsensitive = true` for case-insensitive matching during deserialization. This adds slight overhead but improves flexibility when consuming external JSON.

### Circular References

JsonSerializer does not handle circular references by default. Configure `ReferenceHandler.Preserve` to serialize objects with circular references, but be aware this adds metadata to JSON output.

```csharp
var options = new JsonSerializerOptions
{
    ReferenceHandler = ReferenceHandler.Preserve
};

// Handles circular references but adds $id/$ref metadata
```

### Thread Safety

`JsonSerializerOptions` instances are immutable after first use and safe to share across threads. Creating options is relatively expensive, so reuse instances when possible.

## Property Ordering

Control the order in which properties are serialized.

```csharp
using System.Text.Json.Serialization;

public class Product
{
    [JsonPropertyOrder(3)]
    public int Id { get; set; }
    
    [JsonPropertyOrder(1)]
    public string Name { get; set; } = string.Empty;
    
    [JsonPropertyOrder(2)]
    public decimal Price { get; set; }
    
    // Properties without order appear after ordered properties
    public string Description { get; set; } = string.Empty;
}

var product = new Product
{
    Id = 1,
    Name = "Widget",
    Price = 29.99m,
    Description = "A useful widget"
};

string json = JsonSerializer.Serialize(product);
// {"Name":"Widget","Price":29.99,"Id":1,"Description":"A useful widget"}
```

## Serialization Callbacks

Execute custom logic before or after serialization and deserialization.

```csharp
using System.Text.Json.Serialization;

public class AuditedEntity : 
    IJsonOnSerializing, 
    IJsonOnSerialized,
    IJsonOnDeserializing,
    IJsonOnDeserialized
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    
    [JsonIgnore]
    public DateTime LastSerialized { get; private set; }
    
    void IJsonOnSerializing.OnSerializing()
    {
        Console.WriteLine($"About to serialize entity {Id}");
    }
    
    void IJsonOnSerialized.OnSerialized()
    {
        LastSerialized = DateTime.UtcNow;
        Console.WriteLine($"Finished serializing entity {Id}");
    }
    
    void IJsonOnDeserializing.OnDeserializing()
    {
        Console.WriteLine("Starting deserialization");
    }
    
    void IJsonOnDeserialized.OnDeserialized()
    {
        Console.WriteLine($"Deserialized entity {Id}: {Name}");
        ValidateState();
    }
    
    private void ValidateState()
    {
        if (string.IsNullOrEmpty(Name))
            throw new InvalidOperationException("Name cannot be empty");
    }
}
```

## Populating Collections and Properties

Populate existing collection values instead of replacing them during deserialization.

```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

public class TodoList
{
    public string Name { get; set; } = string.Empty;
    
    // Collection initialized with default items
    public List<string> Tasks { get; set; } = new() { "Default Task" };
}

string json = """{"Name":"Work","Tasks":["Email","Meeting"]}""";

// Default behavior: Replaces collection
var list1 = JsonSerializer.Deserialize<TodoList>(json);
// list1.Tasks = ["Email", "Meeting"] - "Default Task" was replaced

// Populate behavior: Adds to existing collection
var options = new JsonSerializerOptions
{
    PreferredObjectCreationHandling = JsonObjectCreationHandling.Populate
};
var list2 = JsonSerializer.Deserialize<TodoList>(json, options);
// list2.Tasks = ["Default Task", "Email", "Meeting"] - items added

// Per-property control
public class TodoListWithAttribute
{
    public string Name { get; set; } = string.Empty;
    
    [JsonObjectCreationHandling(JsonObjectCreationHandling.Populate)]
    public List<string> Tasks { get; set; } = new() { "Default Task" };
}
```

## Indentation Customization

Customize indentation character and size for formatted output.

```csharp
// Custom indentation with tabs
var tabOptions = new JsonSerializerOptions
{
    WriteIndented = true,
    IndentCharacter = '\t',
    IndentSize = 1
};

string tabJson = JsonSerializer.Serialize(new { Name = "Alice", Age = 30 }, tabOptions);
// {
// →"Name": "Alice",
// →"Age": 30
// }

// Custom indentation with 2 spaces
var twoSpaceOptions = new JsonSerializerOptions
{
    WriteIndented = true,
    IndentCharacter = ' ',
    IndentSize = 2
};

string twoSpaceJson = JsonSerializer.Serialize(new { Name = "Bob" }, twoSpaceOptions);
// {
//   "Name": "Bob"
// }
```

## Custom Enum Member Names

Specify custom names for enum values in JSON.

```csharp
using System.Text.Json.Serialization;

public enum OrderStatus
{
    [JsonStringEnumMemberName("pending_payment")]
    PendingPayment,
    
    [JsonStringEnumMemberName("processing")]
    Processing,
    
    [JsonStringEnumMemberName("shipped")]
    Shipped,
    
    [JsonStringEnumMemberName("delivered")]
    Delivered
}

public class Order
{
    public int Id { get; set; }
    public OrderStatus Status { get; set; }
}

var options = new JsonSerializerOptions
{
    Converters = { new JsonStringEnumConverter() }
};

var order = new Order { Id = 123, Status = OrderStatus.PendingPayment };
string json = JsonSerializer.Serialize(order, options);
// {"Id":123,"Status":"pending_payment"}

// Deserialize using custom name
string input = """{"Id":456,"Status":"shipped"}""";
Order? deserialized = JsonSerializer.Deserialize<Order>(input, options);
// deserialized.Status == OrderStatus.Shipped
```

## Disabling Reflection-Based Serialization

Require explicit JsonSerializerOptions to prevent accidental reflection use.

```csharp
// In your .csproj file:
// <PropertyGroup>
//   <JsonSerializerIsReflectionEnabledByDefault>false</JsonSerializerIsReflectionEnabledByDefault>
// </PropertyGroup>

// Check if reflection is enabled
bool isReflectionEnabled = JsonSerializer.IsReflectionEnabledByDefault;

if (!isReflectionEnabled)
{
    // Must provide options with source generation
    var user = new User { Id = 1, Name = "Alice" };
    
    // This throws NotSupportedException
    // string json = JsonSerializer.Serialize(user);
    
    // Must use options with TypeInfoResolver
    var options = new JsonSerializerOptions
    {
        TypeInfoResolver = AppJsonContext.Default
    };
    
    string json = JsonSerializer.Serialize(user, options);
}
```

## Freezing JsonSerializerOptions

Prevent modifications to options after configuration.

```csharp
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
    WriteIndented = true
};

// Check if options can be modified
bool isReadOnly = options.IsReadOnly;
Console.WriteLine($"Options read-only: {isReadOnly}"); // false

// Freeze the options
options.MakeReadOnly();

// Now options cannot be modified
try
{
    options.WriteIndented = false; // Throws InvalidOperationException
}
catch (InvalidOperationException ex)
{
    Console.WriteLine("Options are frozen and cannot be modified");
}

// Force freeze and populate defaults
var options2 = new JsonSerializerOptions();
options2.MakeReadOnly(populateMissingResolver: true);
```

## Reading Multiple JSON Documents

Read multiple whitespace-separated JSON documents from a single buffer.

```csharp
string multipleDocuments = """
{"id": 1, "name": "First"}
{"id": 2, "name": "Second"}
{"id": 3, "name": "Third"}
""";

byte[] utf8Bytes = Encoding.UTF8.GetBytes(multipleDocuments);
var readerOptions = new JsonReaderOptions
{
    AllowMultipleValues = true
};

var reader = new Utf8JsonReader(utf8Bytes, readerOptions);

var documents = new List<Dictionary<string, JsonElement>>();

while (reader.Read())
{
    if (reader.TokenType == JsonTokenType.StartObject)
    {
        // Position reader at the start
        var readerCopy = reader;
        
        // Read complete document
        using JsonDocument doc = JsonDocument.ParseValue(ref reader);
        var dict = new Dictionary<string, JsonElement>();
        
        foreach (var property in doc.RootElement.EnumerateObject())
        {
            dict[property.Name] = property.Value.Clone();
        }
        
        documents.Add(dict);
    }
}

Console.WriteLine($"Read {documents.Count} documents");
```

## Generating JSON Schema

Export JSON schema for .NET types, useful for OpenAPI specifications and AI tool calling.

```csharp
using System.Text.Json.Schema;
using System.Text.Json.Nodes;

public class Person
{
    public required string Name { get; set; }
    public int Age { get; set; }
    public string? Email { get; set; }
}

// Generate schema for type
var options = new JsonSerializerOptions();
JsonNode schema = JsonSchemaExporter.GetJsonSchemaAsNode(options, typeof(Person));

// Schema describes the shape of Person
string schemaJson = schema.ToJsonString(new JsonSerializerOptions { WriteIndented = true });
// {
//   "type": "object",
//   "properties": {
//     "Name": { "type": "string" },
//     "Age": { "type": "integer" },
//     "Email": { "type": ["string", "null"] }
//   },
//   "required": ["Name"]
// }
```

## Adding Documentation to JSON Schema

Include descriptions from attributes in the generated schema.

```csharp
using System.ComponentModel;
using System.Reflection;
using System.Text.Json.Schema;
using System.Text.Json.Nodes;

[Description("Represents a user in the system.")]
public class User
{
    [Description("The unique identifier for the user.")]
    public required int Id { get; set; }
    
    [Description("The user's full name.")]
    public required string Name { get; set; }
    
    [Description("The user's email address (optional).")]
    public string? Email { get; set; }
}

// Configure exporter to include descriptions
var exporterOptions = new JsonSchemaExporterOptions
{
    TransformSchemaNode = (context, schema) =>
    {
        // Skip if not a schema object or if it's a reference
        if (schema is not JsonObject schemaObj || schemaObj.ContainsKey("$ref"))
        {
            return schema;
        }
        
        // Look for Description attribute on property, parameter, or type
        DescriptionAttribute? descriptionAttribute =
            GetCustomAttribute<DescriptionAttribute>(context.PropertyInfo?.AttributeProvider) ??
            GetCustomAttribute<DescriptionAttribute>(context.PropertyInfo?.AssociatedParameter?.AttributeProvider) ??
            GetCustomAttribute<DescriptionAttribute>(context.TypeInfo.Type);
        
        if (descriptionAttribute != null)
        {
            // Insert description as first property
            schemaObj.Insert(0, "description", (JsonNode)descriptionAttribute.Description);
        }
        
        return schemaObj;
    }
};

var serializerOptions = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
};

JsonNode schema = JsonSchemaExporter.GetJsonSchemaAsNode(
    serializerOptions, 
    typeof(User), 
    exporterOptions);

string schemaJson = schema.ToJsonString(new JsonSerializerOptions { WriteIndented = true });
// {
//   "description": "Represents a user in the system.",
//   "type": "object",
//   "properties": {
//     "id": {
//       "description": "The unique identifier for the user.",
//       "type": "integer"
//     },
//     "name": {
//       "description": "The user's full name.",
//       "type": "string"
//     },
//     "email": {
//       "description": "The user's email address (optional).",
//       "type": ["string", "null"]
//     }
//   },
//   "required": ["id", "name"]
// }

static TAttribute? GetCustomAttribute<TAttribute>(
    ICustomAttributeProvider? provider, 
    bool inherit = false) where TAttribute : Attribute
    => provider?.GetCustomAttributes(typeof(TAttribute), inherit)
        .FirstOrDefault() as TAttribute;
```

## Documenting Constructor Parameters in Schema

Include descriptions for constructor parameters in the generated schema.

```csharp
using System.ComponentModel;
using System.Text.Json.Serialization;

[Description("A product with immutable properties.")]
public class Product
{
    public int Id { get; }
    public string Name { get; }
    public decimal Price { get; }
    
    [JsonConstructor]
    public Product(
        [Description("The unique product identifier.")] int id,
        [Description("The product name.")] string name,
        [Description("The product price in USD.")] decimal price)
    {
        Id = id;
        Name = name;
        Price = price;
    }
}

// Generate schema with parameter descriptions
var exporterOptions = new JsonSchemaExporterOptions
{
    TransformSchemaNode = (context, schema) =>
    {
        if (schema is not JsonObject schemaObj || schemaObj.ContainsKey("$ref"))
        {
            return schema;
        }
        
        // Check property, parameter, and type for descriptions
        DescriptionAttribute? descriptionAttribute =
            GetCustomAttribute<DescriptionAttribute>(context.PropertyInfo?.AttributeProvider) ??
            GetCustomAttribute<DescriptionAttribute>(context.PropertyInfo?.AssociatedParameter?.AttributeProvider) ??
            GetCustomAttribute<DescriptionAttribute>(context.TypeInfo.Type);
        
        if (descriptionAttribute != null)
        {
            schemaObj.Insert(0, "description", (JsonNode)descriptionAttribute.Description);
        }
        
        return schemaObj;
    }
};

var options = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
JsonNode schema = JsonSchemaExporter.GetJsonSchemaAsNode(options, typeof(Product), exporterOptions);

// Schema includes descriptions from constructor parameters
string schemaJson = schema.ToJsonString(new JsonSerializerOptions { WriteIndented = true });
// {
//   "description": "A product with immutable properties.",
//   "type": "object",
//   "properties": {
//     "id": {
//       "description": "The unique product identifier.",
//       "type": "integer"
//     },
//     "name": {
//       "description": "The product name.",
//       "type": "string"
//     },
//     "price": {
//       "description": "The product price in USD.",
//       "type": "number"
//     }
//   },
//   "required": ["id", "name", "price"]
// }

static TAttribute? GetCustomAttribute<TAttribute>(
    ICustomAttributeProvider? provider, 
    bool inherit = false) where TAttribute : Attribute
    => provider?.GetCustomAttributes(typeof(TAttribute), inherit)
        .FirstOrDefault() as TAttribute;
```

## Handling Unmapped Members

Control deserialization behavior when JSON contains properties not present in the target type.

```csharp
public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
}

string json = """{"Id":1,"Name":"Alice","ExtraProperty":"value","Another":"data"}""";

// Default: Ignores unmapped properties
User? user1 = JsonSerializer.Deserialize<User>(json);
// Succeeds - ExtraProperty and Another are ignored

// Disallow unmapped properties globally
var strictOptions = new JsonSerializerOptions
{
    UnmappedMemberHandling = JsonUnmappedMemberHandling.Disallow
};

try
{
    User? user2 = JsonSerializer.Deserialize<User>(json, strictOptions);
}
catch (JsonException ex)
{
    // Exception: JSON object contains property 'ExtraProperty' that could not be mapped
}

// Per-type control with attribute
[JsonUnmappedMemberHandling(JsonUnmappedMemberHandling.Disallow)]
public class StrictUser
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
}

// Throws exception if unmapped properties present
StrictUser? strict = JsonSerializer.Deserialize<StrictUser>(json);
```

## Out-of-Order Metadata Deserialization

Polymorphic deserialization accepts metadata properties in any order.

```csharp
[JsonPolymorphic(TypeDiscriminatorPropertyName = "$type")]
[JsonDerivedType(typeof(Circle), "circle")]
[JsonDerivedType(typeof(Rectangle), "rectangle")]
public abstract class Shape
{
    public string Name { get; set; } = string.Empty;
}

public class Circle : Shape
{
    public double Radius { get; set; }
}

// $type can appear anywhere in the JSON object
string json1 = """{"$type":"circle","Name":"Circle1","Radius":5.0}""";
string json2 = """{"Name":"Circle2","Radius":10.0,"$type":"circle"}""";
string json3 = """{"Name":"Circle3","$type":"circle","Radius":15.0}""";

// All three deserialize correctly
Shape? shape1 = JsonSerializer.Deserialize<Shape>(json1);
Shape? shape2 = JsonSerializer.Deserialize<Shape>(json2);
Shape? shape3 = JsonSerializer.Deserialize<Shape>(json3);
```

## Respecting Nullable Annotations

Enforce nullable reference type annotations during serialization and deserialization.

```csharp
#nullable enable

public class UserProfile
{
    public required int Id { get; set; }
    public required string Name { get; set; }
    public string? OptionalBio { get; set; }
}

var options = new JsonSerializerOptions
{
    RespectNullableAnnotations = true
};

// Valid: null for nullable property
string validJson = """{"Id":1,"Name":"Alice","OptionalBio":null}""";
UserProfile? valid = JsonSerializer.Deserialize<UserProfile>(validJson, options);

// Invalid: null for non-nullable property
string invalidJson = """{"Id":1,"Name":null,"OptionalBio":"Bio"}""";
try
{
    UserProfile? invalid = JsonSerializer.Deserialize<UserProfile>(invalidJson, options);
}
catch (JsonException ex)
{
    Console.WriteLine($"Deserialization failed: {ex.Message}");
    // JSON value cannot be null for non-nullable property 'Name'
}

// Serialization also enforces nullability
var profile = new UserProfile { Id = 1, Name = "Bob", OptionalBio = null };
string serialized = JsonSerializer.Serialize(profile, options);
// {"Id":1,"Name":"Bob","OptionalBio":null}
```

## Required Constructor Parameters

Make constructor parameters non-optional during deserialization.

```csharp
public class Product
{
    public int Id { get; }
    public string Name { get; }
    public decimal Price { get; }
    public string? Description { get; }
    
    [JsonConstructor]
    public Product(int id, string name, decimal price, string? description = null)
    {
        Id = id;
        Name = name;
        Price = price;
        Description = description;
    }
}

// Default: Constructor parameters are optional even without defaults
string json1 = """{"Id":1,"Name":"Widget"}""";
Product? product1 = JsonSerializer.Deserialize<Product>(json1);
// Succeeds: price = 0, description = null

// With flag: Constructor parameters without defaults are required
var options = new JsonSerializerOptions
{
    RespectRequiredConstructorParameters = true
};

try
{
    Product? product2 = JsonSerializer.Deserialize<Product>(json1, options);
}
catch (JsonException ex)
{
    Console.WriteLine("Missing required constructor parameter: price");
}

// Valid when all required parameters present
string json2 = """{"Id":1,"Name":"Widget","Price":29.99}""";
Product? product3 = JsonSerializer.Deserialize<Product>(json2, options);
// Succeeds
```

## Serializing Half, Int128, and UInt128

Serialize new numeric types.

```csharp
public class NumericData
{
    public Half HalfValue { get; set; }
    public Int128 LargeInt { get; set; }
    public UInt128 LargeUInt { get; set; }
}

var data = new NumericData
{
    HalfValue = (Half)3.14,
    LargeInt = Int128.Parse("170141183460469231731687303715884105727"),
    LargeUInt = UInt128.Parse("340282366920938463463374607431768211455")
};

string json = JsonSerializer.Serialize(data);
// {"HalfValue":3.14,"LargeInt":170141183460469231731687303715884105727,"LargeUInt":340282366920938463463374607431768211455}

NumericData? deserialized = JsonSerializer.Deserialize<NumericData>(json);
```

## Serializing Memory and ReadOnlyMemory

Serialize memory types efficiently.

```csharp
public class MemoryData
{
    public Memory<byte> ByteMemory { get; set; }
    public Memory<int> IntMemory { get; set; }
    public ReadOnlyMemory<byte> ReadOnlyBytes { get; set; }
}

var data = new MemoryData
{
    ByteMemory = new byte[] { 1, 2, 3, 4 },
    IntMemory = new int[] { 10, 20, 30 },
    ReadOnlyBytes = new byte[] { 255, 254, 253 }
};

string json = JsonSerializer.Serialize(data);
// {"ByteMemory":"AQIDBA==","IntMemory":[10,20,30],"ReadOnlyBytes":"//79"}
// Note: byte Memory serializes as Base64, other types as arrays

MemoryData? deserialized = JsonSerializer.Deserialize<MemoryData>(json);
```

## Using with PipeReader and PipeWriter

Serialize and deserialize directly with System.IO.Pipelines.

```csharp
using System.IO.Pipelines;

public async Task SerializeToPipeAsync<T>(PipeWriter writer, T value)
{
    await JsonSerializer.SerializeAsync(writer, value);
    await writer.CompleteAsync();
}

public async Task<T?> DeserializeFromPipeAsync<T>(PipeReader reader)
{
    T? result = await JsonSerializer.DeserializeAsync<T>(reader);
    await reader.CompleteAsync();
    return result;
}

// Usage with Pipe
var pipe = new Pipe();

var user = new User { Id = 1, Name = "Alice" };
await SerializeToPipeAsync(pipe.Writer, user);

User? deserialized = await DeserializeFromPipeAsync<User>(pipe.Reader);

// Efficient for network protocols and high-performance scenarios
```

## Contract Customization

Customize serialization contracts for advanced scenarios.

```csharp
using System.Text.Json.Serialization.Metadata;

public class Person
{
    public string Name { get; set; } = string.Empty;
    public int Age { get; set; }
    public string Email { get; set; } = string.Empty;
}

var options = new JsonSerializerOptions();

// Customize the contract
options.TypeInfoResolver = new DefaultJsonTypeInfoResolver
{
    Modifiers =
    {
        static typeInfo =>
        {
            if (typeInfo.Type == typeof(Person))
            {
                // Find the Email property
                var emailProperty = typeInfo.Properties
                    .FirstOrDefault(p => p.Name == "Email");
                
                if (emailProperty != null)
                {
                    // Add custom get logic to mask email
                    var originalGetter = emailProperty.Get;
                    emailProperty.Get = obj =>
                    {
                        string? email = originalGetter?.Invoke(obj) as string;
                        if (!string.IsNullOrEmpty(email) && email.Contains('@'))
                        {
                            var parts = email.Split('@');
                            return $"{parts[0][0]}***@{parts[1]}";
                        }
                        return email;
                    };
                }
            }
        }
    }
};

var person = new Person 
{ 
    Name = "Alice", 
    Age = 30, 
    Email = "alice@example.com" 
};

string json = JsonSerializer.Serialize(person, options);
// {"Name":"Alice","Age":30,"Email":"a***@example.com"}
```

## Chaining Type Resolvers

Combine multiple source generation contexts.

```csharp
using System.Text.Json.Serialization.Metadata;

[JsonSerializable(typeof(User))]
public partial class UserContext : JsonSerializerContext { }

[JsonSerializable(typeof(Product))]
public partial class ProductContext : JsonSerializerContext { }

var options = new JsonSerializerOptions();

// Add resolvers to chain
options.TypeInfoResolverChain.Add(UserContext.Default);
options.TypeInfoResolverChain.Add(ProductContext.Default);

// Can serialize both User and Product
var user = new User { Id = 1, Name = "Alice" };
var product = new Product { Id = 100, Name = "Widget" };

string userJson = JsonSerializer.Serialize(user, options);
string productJson = JsonSerializer.Serialize(product, options);

// Can introspect and modify chain
Console.WriteLine($"Resolver count: {options.TypeInfoResolverChain.Count}");

// Remove a resolver if needed
options.TypeInfoResolverChain.RemoveAt(1);
```

## Related Concepts

**Used by System.Text.Json.JsonSerializer:**

- `Utf8JsonReader` (deserialization implementation)
- `Utf8JsonWriter` (serialization implementation)
- Source generators (compile-time code generation)
- Reflection (runtime type discovery)

**Uses System.Text.Json.JsonSerializer:**

- ASP.NET Core web APIs (default JSON serializer)
- HttpClient JSON extensions (request/response serialization)
- Configuration system (parsing appsettings.json)
- Minimal APIs (parameter binding and response serialization)

**Alternative to System.Text.Json.JsonSerializer:**

- `JsonDocument` (read-only DOM for dynamic JSON)
- `JsonNode` (mutable DOM for dynamic JSON)
- `Utf8JsonReader`/`Utf8JsonWriter` (lowest-level APIs for custom logic)
- Newtonsoft.Json (feature-rich alternative with different API)
