# System.Text.Json.Nodes
## Merging JSON Documents

Combine multiple JSON documents at runtime by copying properties between objects.

```csharp
// Base configuration
JsonNode baseConfig = JsonNode.Parse("""
{
    "host": "localhost",
    "port": 8080,
    "debug": false
}
""")!;

// Override configuration
JsonNode overrideConfig = JsonNode.Parse("""
{
    "port": 9000,
    "debug": true,
    "newSetting": "value"
}
""")!;

// Merge overrides into base
JsonObject baseObject = baseConfig.AsObject();
JsonObject overrideObject = overrideConfig.AsObject();

foreach (var property in overrideObject)
{
    baseObject[property.Key] = property.Value?.DeepClone();
}

// Result contains merged configuration
string merged = baseConfig.ToJsonString();
// {"host":"localhost","port":9000,"debug":true,"newSetting":"value"}
```

## Cloning JSON Nodes

Create deep copies of JSON structures for independent modification.

```csharp
JsonNode original = JsonNode.Parse("""
{
    "data": {
        "values": [1, 2, 3],
        "name": "original"
    }
}
""")!;

// Deep clone
JsonNode clone = original.DeepClone();

// Modify clone without affecting original
clone["data"]!["name"] = "modified";

// Original unchanged
string originalName = original["data"]!["name"]!.GetValue<string>();
// "original"

string clonedName = clone["data"]!["name"]!.GetValue<string>();
// "modified"
```

## Type Checking and Conversion

Determine node types and convert between representations.

```csharp
JsonNode data = JsonNode.Parse("""
{
    "object": {"key": "value"},
    "array": [1, 2, 3],
    "string": "text",
    "number": 42,
    "boolean": true,
    "null": null
}
""")!;

// Check node types
JsonNode objectNode = data["object"]!;
if (objectNode is JsonObject jsonObject)
{
    // Work with JsonObject
    string value = jsonObject["key"]!.GetValue<string>();
}

JsonNode arrayNode = data["array"]!;
if (arrayNode is JsonArray jsonArray)
{
    // Work with JsonArray
    int count = jsonArray.Count;
}

// AsObject() and AsArray() throw if wrong type
JsonObject obj = data["object"]!.AsObject();
JsonArray arr = data["array"]!.AsArray();

// JsonValue for primitives
JsonNode numberNode = data["number"]!;
if (numberNode is JsonValue jsonValue)
{
    int number = jsonValue.GetValue<int>();
}
```
