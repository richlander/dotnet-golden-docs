# System.Text.Json.JsonSerializer
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
