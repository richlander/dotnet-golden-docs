# System.Text.Json.Utf8JsonReader
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
