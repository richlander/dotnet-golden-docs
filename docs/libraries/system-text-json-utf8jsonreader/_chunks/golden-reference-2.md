# System.Text.Json.Utf8JsonReader
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
