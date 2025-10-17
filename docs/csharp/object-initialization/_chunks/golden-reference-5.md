# Object Initialization
## Why Object Initialization Matters
### Anonymous Types with Collections

Anonymous types can contain collection properties:

```csharp
var team = new
{
    Name = "Development Team",
    Members = new[] { "Alice", "Bob", "Charlie" },
    Lead = new { Name = "Diana", Experience = 5 }
};

// Or with collection expressions
var modernTeam = new
{
    Name = "Development Team",
    Members = new[] { "Alice", "Bob", "Charlie" }, // Anonymous types don't support collection expression syntax directly
    Lead = new { Name = "Diana", Experience = 5 }
};
```

### Anonymous Types in LINQ

LINQ queries commonly use anonymous types for projections:

```csharp
List<Person> people =
[
    new() { Name = "Alice", Age = 30, City = "Seattle" },
    new() { Name = "Bob", Age = 25, City = "Portland" }
];

// Project to anonymous type
var summary = people.Select(p => new
{
    p.Name,
    AgeGroup = p.Age < 30 ? "Young" : "Adult",
    Location = p.City
}).ToList();
```

## Why Object Initialization Matters

### Immutable Object Construction

Object initialization enables creation of immutable objects with clean syntax:

```csharp
// Immutable record with init properties
public record Person(string Name, int Age)
{
    public List<string> Hobbies { get; init; } = new();
}

// Clean initialization
Person person = new("John", 30)
{
    Hobbies = ["Reading", "Gaming"]
};
```
