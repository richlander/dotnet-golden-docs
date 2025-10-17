# C# 14
## Essential Features & Examples
### Simple Lambda Parameters with Modifiers

Enhanced lambda syntax with parameter modifiers for better type safety.

```csharp
// ref parameters for efficient value type operations
var transform = (ref Point p) => p = new Point(p.X * 2, p.Y * 2);

// out parameters for initialization patterns
var tryParse = (string input, out int result) => int.TryParse(input, out result);

// in parameters for read-only large structs
var calculate = (in Matrix matrix) => matrix.Determinant();

// params for variable arguments
var sum = (params int[] numbers) => numbers.Sum();
```

### Partial Events and Constructors

Enable partial declarations for events and constructors in code generation scenarios.

```csharp
// Generated file 1
public partial class MyClass
{
    public partial MyClass(string name);
    public partial event EventHandler<DataEventArgs> DataChanged;
}

// User file
public partial class MyClass
{
    private string _name;

    public partial MyClass(string name)
    {
        _name = name ?? throw new ArgumentNullException(nameof(name));
    }

    public partial event EventHandler<DataEventArgs> DataChanged
    {
        add => _dataChanged += value;
        remove => _dataChanged -= value;
    }

    private event EventHandler<DataEventArgs> _dataChanged;
}
```

### Extensions

New extension syntax for augmenting types with additional members safely.

```csharp
// Extensions provide type-safe augmentation
public extension PersonExtensions for Person
{
    public string FullName => $"{FirstName} {LastName}";
    public bool IsAdult => Age >= 18;
    public void CelebrateBirthday() => Age++;
}

// Usage feels natural
var person = new Person { FirstName = "John", LastName = "Doe", Age = 17 };
Console.WriteLine(person.FullName); // "John Doe"
Console.WriteLine(person.IsAdult);  // False
person.CelebrateBirthday();
Console.WriteLine(person.IsAdult);  // True
```
