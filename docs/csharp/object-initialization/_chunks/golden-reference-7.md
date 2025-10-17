# Object Initialization
## Integration with Modern C# Features
### Builder Pattern Integration

Builders can be combined with object initialization:

```csharp
public class PersonBuilder
{
    private Person _person = new();

    public PersonBuilder WithName(string name)
    {
        _person.Name = name;
        return this;
    }

    public PersonBuilder WithAge(int age)
    {
        _person.Age = age;
        return this;
    }

    public Person Build() => _person;
}

// Combine builder with object initialization
Person person = new PersonBuilder()
    .WithName("Alice")
    .WithAge(30)
    .Build() with
    {
        Email = "alice@example.com",
        Skills = ["C#", "Azure"]
    };
```

## Performance Considerations

### Property Access

Object initialization calls property setters after the constructor:

```csharp
// Object initialization calls property setters
Person person = new()  // Constructor called first
{
    Name = "John",     // Name setter called
    Age = 30          // Age setter called
};

// Equivalent to:
Person person2 = new Person();
person2.Name = "John";
person2.Age = 30;
```

### Collection Capacity

Pre-size collection properties when the size is known:

```csharp
// Efficient: Initialize collections with capacity when known
var largeDataSet = new DataContainer
{
    Items = new List<DataItem>(10000),  // Pre-sized
    Index = new Dictionary<string, int>(10000),  // Pre-sized
    Metadata = new()
    {
        Created = DateTime.UtcNow,
        Version = "1.0"
    }
};
```

## Integration with Modern C# Features

### Pattern Matching

Initialize and immediately pattern match:

```csharp
// Initialize and immediately pattern match
var result = new ProcessingResult { Status = "Success", Data = [1, 2, 3] }
switch
{
    { Status: "Success", Data: { Length: > 0 } } => "Processing completed successfully",
    { Status: "Error" } => "Processing failed",
    _ => "Unknown status"
};
```
