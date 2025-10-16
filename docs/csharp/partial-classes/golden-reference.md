# Partial Classes

## Overview

Partial classes split the definition of a type (class, struct, or interface) across multiple source files. Each file contains a section of the type definition, and all parts combine at compile time to form the complete type.

This separation is valuable when working with code generators, which can generate part of a class while developers write the rest in separate files without modifying generated code. Partial classes also enable platform-specific implementations where different source files contain Linux, macOS, or Windows-specific members of the same type. Source generators use partial classes and partial members to add generated functionality to developer-written types.

All partial declarations use the `partial` keyword modifier and must be in the same assembly and namespace. Partial types can contain partial members, where the member signature is declared in one file and the implementation in another.

## Quick Reference

**Basic partial class split across files:**

```csharp
// File: Person_Data.cs
public partial class Person
{
    public string Name { get; set; } = string.Empty;
    public int Age { get; set; }
}

// File: Person_Methods.cs  
public partial class Person
{
    public bool IsAdult() => Age >= 18;
}
```

## Partial Types

Split a class definition across multiple files using the `partial` keyword.

```csharp
// File: Employee_Data.cs
public partial class Employee
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public decimal Salary { get; set; }
}

// File: Employee_Methods.cs
public partial class Employee
{
    public string GetFullName() => $"{FirstName} {LastName}";
    
    public void GiveRaise(decimal percentage)
    {
        Salary *= (1 + percentage / 100);
    }
}
```

All parts must have the same accessibility (public, internal, etc.). If any part is abstract, the whole type is abstract. If any part is sealed, the whole type is sealed. All parts that specify a base class must agree, but parts can specify different interfaces—the final type implements all interfaces from all partial declarations.

Partial struct:

```csharp
// Partial struct
public partial struct Point3D
{
    public double X { get; set; }
    public double Y { get; set; }
}

public partial struct Point3D
{
    public double Z { get; set; }
    public double DistanceFromOrigin() => Math.Sqrt(X * X + Y * Y + Z * Z);
}
```

### Partial Interfaces

Partial interface:

```csharp
// Partial interface
public partial interface IDataService
{
    void LoadData();
}

public partial interface IDataService
{
    void SaveData();
}
```

### Nested Partial Types

Nested types can be partial even if the containing type is not.

```csharp
public class Container
{
    public partial class NestedData
    {
        public int Id { get; set; }
    }
}

public class Container
{
    public partial class NestedData
    {
        public string Name { get; set; }
    }
}
```

## Partial Members

### Partial Methods

Partial methods separate method signatures from implementations. The declaring declaration specifies the signature, while the implementing declaration provides the body.

```csharp
// File 1: Declaring declaration
public partial class DataProcessor
{
    public partial void ProcessData(string input);
}

// File 2: Implementing declaration
public partial class DataProcessor
{
    public partial void ProcessData(string input)
    {
        Console.WriteLine($"Processing: {input}");
    }
}
```

**Optional implementation:** If a method meets all these criteria, the implementing declaration is optional:
- No accessibility modifiers (defaults to `private`)
- Returns `void`
- No `out` parameters
- No modifiers: `virtual`, `override`, `sealed`, `new`, or `extern`

When implementation is omitted for an optional partial method, the compiler removes both the declaration and all calls to the method at compile time.

```csharp
public partial class DataProcessor
{
    partial void OnDataChanged(); // Optional - can be left unimplemented
    
    public void UpdateData(string data)
    {
        // ... update logic
        OnDataChanged(); // Call is removed if not implemented
    }
}
```

**Required implementation:** Methods that don't meet the optional criteria must have an implementing declaration. This commonly occurs with source generators that implement attributed methods.

```csharp
// Source generator pattern
public partial class RegexContainer
{
    [GeneratedRegex(@"\d{3}-\d{2}-\d{4}")]
    public static partial Regex SsnPattern();
}

// Source generator provides:
// public static partial Regex SsnPattern() => new Regex(@"\d{3}-\d{2}-\d{4}", RegexOptions.Compiled);
```

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

## Documentation Comments

When both declaring and implementing declarations include XML documentation comments:
- For methods, properties, indexers, and events: implementing declaration comments take precedence
- If only one declaration has comments, those comments are used
- Caller info attributes on declaring declarations take precedence; compiler warns if both declarations have caller info attributes

## When to Use Partial Classes

**Code generation and source generators:**
- Separate generated code from developer-written code
- Windows Forms, WPF designer-generated classes
- Entity Framework context classes
- Source generators implementing attributed members

**Platform-specific implementations:**
- Different source files for Linux, macOS, or Windows-specific members
- Conditional compilation for platform APIs
- Organize platform differences without preprocessor directives scattered throughout code

```csharp
// Shared.cs
public partial class FileSystem
{
    public partial string GetPathSeparator();
}

// Windows.cs (conditional compilation)
#if WINDOWS
public partial class FileSystem
{
    public partial string GetPathSeparator() => "\\";
}
#endif

// Unix.cs (conditional compilation)
#if LINUX || MACOS
public partial class FileSystem
{
    public partial string GetPathSeparator() => "/";
}
#endif
```

**Separation of concerns:**
- Keep generated code separate from custom code
- Organize large classes by responsibility (data, methods, events)
- Implement interfaces in separate files

## Considerations

- **Same assembly requirement:** All partial declarations must be in the same assembly and module (same .exe or .dll).
- **Partial keyword required:** All parts must use the `partial` keyword.
- **Accessibility must match:** All parts must have the same accessibility (public, internal, etc.).
- **Name and type parameters match:** Class name and generic type parameters must match exactly.
- **Keyword placement:** The `partial` modifier must appear immediately before `class`, `struct`, or `interface`.
- **Not allowed on:** Cannot use `partial` on delegates, enumerations, finalizers, static constructors, or operator overloads.
- **Attributes merge:** Attributes from all partial declarations are combined. If you apply the same attribute to multiple partial declarations, it appears multiple times on the final type (unless the attribute has `AllowMultiple=false`).
- **Base class agreement:** All parts that specify a base class must specify the same base class. Parts that omit the base class still inherit from it.
- **Auto-properties:** The implementing declaration of a partial property cannot use auto-property syntax (`{ get; set; }`). The compiler cannot distinguish between an auto-property and a declaring declaration. Use explicit accessors or the `field` keyword.
- **Primary constructors:** Only one partial type declaration can include primary constructor syntax. This prevents conflicts in parameter definitions.
- **Optional methods removed:** If an optional partial method (private, void return, no out parameters) lacks implementation, the compiler removes all calls to it. Any argument expressions in those calls are also removed, including potential side effects.
- **Generic constraints:** Generic constraints must match on all partial declarations. The same constraint must be specified on every partial declaration of a generic partial type.

## See Also

- Properties and Backing Fields (field keyword)
- Extension Members
- Records and Primary Constructors
