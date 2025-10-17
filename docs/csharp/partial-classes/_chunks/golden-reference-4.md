# Partial Classes
## Source Generator Integration
### Partial Events

Partial events (C# 14) split event declarations from their accessor implementations. The declaring declaration creates a field-like event, and the implementing declaration provides `add` and `remove` accessors.

```csharp
// Declaring declaration
public partial class EventSource
{
    public partial event EventHandler DataChanged;
}

// Implementing declaration
public partial class EventSource
{
    private EventHandler? _dataChanged;
    
    public partial event EventHandler DataChanged
    {
        add => _dataChanged += value;
        remove => _dataChanged -= value;
    }
}
```

### Partial Constructors

Partial constructors (C# 14) split constructor declarations from implementations. Only the implementing declaration can include constructor initializers (`this()` or `base()`). Only one partial declaration can use primary constructor syntax.

```csharp
// File 1: Declaring declaration
public partial class DatabaseConnection
{
    public partial DatabaseConnection(string connectionString);
}

// File 2: Implementing declaration
public partial class DatabaseConnection
{
    private readonly string _connectionString;
    
    public partial DatabaseConnection(string connectionString) : this()
    {
        _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
    }
    
    private DatabaseConnection()
    {
        // Shared initialization
    }
}
```

## Source Generator Integration

Partial members integrate with source generators to separate generated code from developer code. The developer writes declaring declarations with attributes, and the source generator provides implementing declarations during compilation.

```csharp
// Developer writes:
public partial class NotifyPropertyChanged
{
    [NotifyProperty]
    private string _name = string.Empty;
    
    // Source generator creates:
    // public partial string Name { get => _name; set { _name = value; OnPropertyChanged(nameof(Name)); } }
    // partial void OnNameChanged();
}
```
