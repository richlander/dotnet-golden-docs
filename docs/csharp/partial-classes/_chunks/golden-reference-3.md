# Partial Classes
## Partial Members
### Partial Properties

Partial properties (C# 13) split property declarations from implementations. The declaring declaration specifies the property signature, and the implementing declaration provides accessor bodies.

```csharp
// File 1: Declaring declaration
public partial class Configuration
{
    public partial string ConnectionString { get; set; }
}

// File 2: Implementing declaration  
public partial class Configuration
{
    private string _connectionString = string.Empty;
    
    public partial string ConnectionString
    {
        get => _connectionString;
        set => _connectionString = value ?? throw new ArgumentNullException(nameof(value));
    }
}
```

The implementing declaration cannot use auto-property syntax (`{ get; set; }`). Use explicit accessors or the `field` keyword to access the compiler-synthesized backing field.

```csharp
// Using field keyword (C# 14) for validation
public partial class Configuration
{
    public partial string ConnectionString { get; set; }
}

public partial class Configuration
{
    public partial string ConnectionString
    {
        get => field;
        set => field = value ?? throw new ArgumentNullException(nameof(value));
    }
}
```

### Partial Indexers

Partial indexers (C# 13) follow the same pattern as properties, separating the signature from implementation.

```csharp
// Declaring declaration
public partial class DataCollection
{
    public partial string this[int index] { get; set; }
}

// Implementing declaration
public partial class DataCollection
{
    private readonly string[] _data = new string[100];
    
    public partial string this[int index]
    {
        get => _data[index];
        set => _data[index] = value;
    }
}
```
