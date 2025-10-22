# Type Extensions
## Essential Features & Examples
### Traditional Extension Methods

The original extension method syntax remains fully supported and compatible.

```csharp
public static class EnumerableExtensions
{
    // Traditional syntax with 'this' modifier
    public static bool IsEmpty<T>(this IEnumerable<T> source)
    {
        return !source.Any();
    }
    
    public static void ForEach<T>(this IEnumerable<T> source, Action<T> action)
    {
        foreach (var item in source)
            action(item);
    }
}

// Usage identical to modern syntax
var numbers = new List<int> { 1, 2, 3 };
if (!numbers.IsEmpty())
    numbers.ForEach(n => Console.WriteLine(n));
```

### Ref Extension Methods

Modify struct instances directly without creating copies.

```csharp
public static class StructExtensions
{
    // Traditional ref syntax
    public static void Scale(this ref Point point, int factor)
    {
        point.X *= factor;
        point.Y *= factor;
    }
    
    // Modern extension block syntax for ref
    extension (ref Point point)
    {
        public void Reset()
        {
            point = new Point(0, 0);
        }
        
        public void Normalize()
        {
            int max = Math.Max(Math.Abs(point.X), Math.Abs(point.Y));
            if (max > 0)
            {
                point.X /= max;
                point.Y /= max;
            }
        }
    }
}

// Direct modification without reassignment
Point p = new Point(10, 20);
p.Scale(2);      // Traditional: p is now (20, 40)
p.Normalize();   // Modern: p is now (1, 2)
p.Reset();       // Modern: p is now (0, 0)
```

### Generic Extensions

Extension members support generic type parameters for maximum flexibility.

```csharp
public static class CollectionExtensions
{
    extension<T> (IEnumerable<T> source)
    {
        public bool IsNullOrEmpty() => source == null || !source.Any();
        
        public IEnumerable<T> WhereNot(Func<T, bool> predicate) => 
            source.Where(item => !predicate(item));
        
        public Dictionary<TKey, T> ToDictionary<TKey>(Func<T, TKey> keySelector) 
            where TKey : notnull =>
            source.ToDictionary(keySelector);
    }
}

// Works with any IEnumerable<T>
var numbers = new[] { 1, 2, 3, 4, 5 };
var evens = numbers.WhereNot(n => n % 2 == 1);
var dict = evens.ToDictionary(n => n);
```
