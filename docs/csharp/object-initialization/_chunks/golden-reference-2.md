# Object Initialization
## Collection Properties

### Using Collection Expressions

Collection expressions provide the clearest syntax for initializing collection properties:

```csharp
public class Team
{
    public string Name { get; set; }
    public List<string> Members { get; set; } = new();
    public string[] Tags { get; set; }
}

// Collection expressions for collection properties
Team team = new Team
{
    Name = "Development Team",
    Members = ["Alice", "Bob", "Charlie"],
    Tags = ["backend", "frontend", "devops"]
};
```

### Dictionary Properties

Dictionaries use initializer syntax since collection expressions don't support them:

```csharp
public class Configuration
{
    public string AppName { get; set; }
    public Dictionary<string, string> Settings { get; set; } = new();
    public Dictionary<string, int> Limits { get; set; } = new();
}

// Dictionary initialization within object
Configuration config = new()
{
    AppName = "MyApplication",
    Settings = new()
    {
        ["Environment"] = "Production",
        ["LogLevel"] = "Information",
        ["Theme"] = "Dark"
    },
    Limits = new()
    {
        { "MaxUsers", 1000 },
        { "TimeoutSeconds", 30 }
    }
};
```

### Complex Nested Collections

Combine collection expressions with other initialization patterns:

```csharp
public class Project
{
    public string Name { get; set; }
    public List<Team> Teams { get; set; } = new();
    public Dictionary<string, List<string>> Resources { get; set; } = new();
}

// Complex nested initialization
Project project = new()
{
    Name = "Enterprise Application",
    Teams =
    [
        new()
        {
            Name = "Backend Team",
            Members = ["Alice", "Bob"]
        },
        new()
        {
            Name = "Frontend Team",
            Members = ["Charlie", "Diana"]
        }
    ],
    Resources = new()
    {
        ["Documentation"] = ["API Spec", "User Guide"],
        ["Tools"] = ["Visual Studio", "Postman"]
    }
};
```
