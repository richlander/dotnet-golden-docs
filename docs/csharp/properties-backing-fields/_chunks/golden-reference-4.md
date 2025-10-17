# Properties and Backing Fields
## Read-Only Properties

Properties can be read-only in different ways depending on requirements.

**Get-only auto-property:** Can only be set in constructors:

```csharp
public class ImmutablePerson
{
    public string Name { get; }
    public DateTime Created { get; } = DateTime.UtcNow;
    
    public ImmutablePerson(string name)
    {
        Name = name;
    }
}
```

**Expression-bodied read-only property:** Computed each time it's accessed:

```csharp
public class Person
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    
    public string FullName => $"{FirstName} {LastName}";
}
```

**Private setter:** Allows modification within the class:

```csharp
public class Counter
{
    public int Count { get; private set; }
    
    public void Increment() => Count++;
    public void Reset() => Count = 0;
}
```

## Computed Properties

Computed properties calculate values from other data rather than storing values directly.

```csharp
public class Rectangle
{
    public double Width { get; set; }
    public double Height { get; set; }
    
    public double Area => Width * Height;
    public double Perimeter => 2 * (Width + Height);
    public bool IsSquare => Width == Height;
}
```

**Cached computed properties:** Calculate once and cache the result:

```csharp
public class Person
{
    private string? _fullName;
    
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    
    public string FullName
    {
        get
        {
            if (_fullName == null)
                _fullName = $"{FirstName} {LastName}";
            return _fullName;
        }
    }
    
    public void InvalidateCache()
    {
        _fullName = null;
    }
}
```
