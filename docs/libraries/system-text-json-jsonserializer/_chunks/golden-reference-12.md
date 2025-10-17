# System.Text.Json.JsonSerializer
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
