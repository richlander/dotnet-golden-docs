# Partial Classes
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
