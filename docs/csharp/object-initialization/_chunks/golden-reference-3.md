# Object Initialization
## Init-Only Properties

Init-only properties can only be set during object initialization, creating immutable objects:

```csharp
public class ImmutablePerson
{
    public string Name { get; init; }
    public int Age { get; init; }
    public DateTime CreatedAt { get; init; } = DateTime.UtcNow;
}

// Can only set during initialization
ImmutablePerson person = new()
{
    Name = "Emma",
    Age = 29
    // CreatedAt uses default value
};

// person.Name = "New Name"; // Compile error - cannot modify after construction
```

### Init Properties with Collections

Init properties work with collection properties:

```csharp
public class ReadOnlyTeam
{
    public string Name { get; init; }
    public List<string> Members { get; init; } = new();
    public IReadOnlyList<string> ReadOnlyMembers => Members.AsReadOnly();
}

// Initialize collections during object creation
ReadOnlyTeam team = new()
{
    Name = "Alpha Team",
    Members = ["John", "Jane", "Jim"]
};
```

### Records with Init Properties

Records automatically provide init properties for primary constructor parameters:

```csharp
// Record with automatic init properties
public record PersonRecord(string Name, int Age)
{
    public List<string> Skills { get; init; } = new();
}

// Clean record initialization
PersonRecord person = new("Alice", 30)
{
    Skills = ["C#", "JavaScript", "SQL"]
};

// With expression for copying with changes
PersonRecord olderPerson = person with { Age = 31 };
```
