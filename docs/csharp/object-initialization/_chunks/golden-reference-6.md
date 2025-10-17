# Object Initialization
## Advanced Initialization Patterns
### Reduced Constructor Proliferation

Object initializers eliminate the need for multiple constructor overloads:

```csharp
// Without initializers - many constructors needed
public class PersonOld
{
    public PersonOld(string name) { }
    public PersonOld(string name, int age) { }
    public PersonOld(string name, int age, string city) { }
    // ... many more combinations
}

// With initializers - single constructor, flexible initialization
public class Person
{
    public string Name { get; set; }
    public int Age { get; set; }
    public string City { get; set; }
}
```

### Self-Documenting Code

Object initialization makes code intentions clear:

```csharp
var configuration = new AppConfiguration
{
    DatabaseConnectionString = "Server=localhost;Database=MyApp",
    MaxRetryAttempts = 3,
    TimeoutMinutes = 30,
    EnableLogging = true
};
```

## Advanced Initialization Patterns

### Conditional Initialization

Use conditional expressions within initializers:

```csharp
bool isProduction = true;

var config = new Configuration
{
    Environment = isProduction ? "Production" : "Development",
    LogLevel = isProduction ? "Warning" : "Debug",
    Settings = isProduction
        ? new() { ["Cache"] = "Redis" }
        : new() { ["Cache"] = "Memory" }
};
```

### Factory Methods with Initialization

Factory methods can return objects ready for further initialization:

```csharp
public class PersonFactory
{
    public static Person CreateEmployee(string name, string department)
    {
        return new Person
        {
            Name = name,
            Department = department,
            CreatedAt = DateTime.UtcNow,
            Status = "Active",
            Permissions = ["Read", "Write"]
        };
    }
}

// Use factory with additional initialization
Person employee = PersonFactory.CreateEmployee("John", "Engineering")
{
    Email = "john@company.com",
    Manager = new() { Name = "Jane Smith" }
};
```
