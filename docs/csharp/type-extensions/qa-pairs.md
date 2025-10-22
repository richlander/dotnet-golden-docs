# Type Extensions - Q&A Pairs

## Q: What is the difference between extension methods and extension blocks in C# 14?

**A:** Extension methods (C# 3.0+) use the `this` modifier on the first parameter of a static method to add instance methods to existing types. Extension blocks (C# 14) use the `extension` keyword to declare multiple members (methods, properties, operators) in a unified syntax block. Extension blocks support both instance and static members, while traditional extension methods only support instance methods. Both syntaxes compile to the same IL and are binary compatible.

```csharp
// Traditional extension method (C# 3.0+)
public static class TraditionalExtensions
{
    public static int WordCount(this string text) => 
        text.Split(' ', StringSplitOptions.RemoveEmptyEntries).Length;
}

// Modern extension block (C# 14)
public static class ModernExtensions
{
    extension (string text)
    {
        public int WordCount() => 
            text.Split(' ', StringSplitOptions.RemoveEmptyEntries).Length;
        
        public bool IsEmpty => string.IsNullOrEmpty(text);
    }
}
```

## Q: Can extension members added in C# 14 work with older .NET Framework versions?

**A:** Yes. Extension members are a pure language feature that compiles to static methods in IL. The C# 14 compiler can target any .NET platform including .NET Framework 4.x, .NET Core, and .NET 5+. The runtime doesn't need to support any special features - only the compiler needs to be C# 14 or later. This means you can use modern extension syntax while maintaining compatibility with legacy applications.

```csharp
// Compiles to standard static methods that work on any .NET version
extension (string text)
{
    public bool IsNumeric() => int.TryParse(text, out _);
}

// Equivalent generated IL (simplified):
// public static bool IsNumeric(string text) => int.TryParse(text, out _);
```

## Q: Why doesn't my extension method get called when the type already has a method with the same name?

**A:** Extension members have lower precedence than instance members. If a type defines an instance method with the same signature, the instance method always wins. Extension members only fill gaps - they don't override or replace existing functionality. This design ensures that adding an extension cannot break existing code that relies on instance methods.

```csharp
public class MyClass
{
    public void Process() => Console.WriteLine("Instance");
}

public static class Extensions
{
    extension (MyClass obj)
    {
        public void Process() => Console.WriteLine("Extension");
    }
}

var obj = new MyClass();
obj.Process(); // Always outputs: "Instance"
```

## Q: How do I add operators to existing types like Point or DateTime?

**A:** Use extension blocks with operator declarations. Extension operators must be declared as `public static` and follow standard operator overloading rules. The receiver type must appear in at least one operand position. This enables natural mathematical syntax for types you don't control.

```csharp
public static class PointExtensions
{
    extension (Point)
    {
        public static Point operator +(Point left, Point right) =>
            new Point(left.X + right.X, left.Y + right.Y);
        
        public static Point operator *(Point point, int scalar) =>
            new Point(point.X * scalar, point.Y * scalar);
    }
}

Point p1 = new Point(10, 20);
Point p2 = new Point(5, 3);
Point result = p1 + p2;  // (15, 23)
Point scaled = p1 * 2;   // (20, 40)
```

## Q: What's the difference between extending a type instance and extending the type itself?

**A:** Instance extensions add members that work on instances of a type (like `myString.WordCount()`), while static extensions add members to the type itself (like `Point.Origin`). Instance extensions require a receiver parameter name in the extension block, while static extensions can omit the parameter name if they only contain static members.

```csharp
// Instance extension - requires parameter name
extension (string text)
{
    public int Length() => text.Length; // Works on instance
}

// Static extension - parameter name optional
extension (Point)
{
    public static Point Origin => new Point(0, 0); // Works on type
}

// Usage
string s = "hello";
int len = s.Length();       // Instance extension
Point p = Point.Origin;     // Static extension
```

## Q: How do ref extension methods work and when should I use them?

**A:** Ref extension methods take the receiver by reference, allowing direct modification of struct instances without creating copies. Use `ref` in the receiver parameter for value types. This is only valid for struct types or generic types constrained to `struct`. Ref extensions are essential for performant struct manipulation without reassignment.

```csharp
public static class StructExtensions
{
    // Traditional ref syntax
    public static void Reset(this ref Point point)
    {
        point = new Point(0, 0);
    }
    
    // Modern extension block syntax
    extension (ref Point point)
    {
        public void Scale(int factor)
        {
            point.X *= factor;
            point.Y *= factor;
        }
    }
}

// Usage - modifies in place
Point p = new Point(10, 20);
p.Scale(2);  // p is now (20, 40) - no reassignment needed
p.Reset();   // p is now (0, 0)
```

## Q: Can I use extension members with generic types?

**A:** Yes. Extension blocks support generic type parameters that can be constrained and inferred. All type parameters must be inferrable from the receiver type and member parameters. Generic extensions enable creating reusable functionality for entire families of types like `IEnumerable<T>` or `IComparable<T>`.

```csharp
public static class GenericExtensions
{
    // Generic extension for any IEnumerable<T>
    extension<T> (IEnumerable<T> source)
    {
        public bool IsEmpty() => !source.Any();
        
        public IEnumerable<T> WhereNot(Func<T, bool> predicate) =>
            source.Where(x => !predicate(x));
    }
    
    // Generic extension with constraints
    extension<T> (IComparable<T> value) where T : IComparable<T>
    {
        public bool IsBetween(T lower, T upper) =>
            value.CompareTo(lower) >= 0 && value.CompareTo(upper) <= 0;
    }
}

var numbers = new[] { 1, 2, 3 };
bool empty = numbers.IsEmpty();           // Generic T inferred as int
var odds = numbers.WhereNot(n => n % 2 == 0);

int value = 5;
bool inRange = value.IsBetween(1, 10);    // Works with IComparable<int>
```

## Q: Why do I need a `using` directive to make extension members visible?

**A:** Extension members follow namespace-based scoping. The compiler only considers extensions from static classes that are imported via `using` directives in the current file. This prevents naming conflicts and keeps IntelliSense manageable. Without this scoping, every extension ever written would pollute the global method space for common types like `string` and `int`.

```csharp
namespace MyApp.Extensions
{
    public static class StringExtensions
    {
        extension (string text)
        {
            public bool IsNumeric() => int.TryParse(text, out _);
        }
    }
}

namespace MyApp.Code
{
    // Without using - extension not visible
    void Test1()
    {
        "123".IsNumeric(); // ERROR: Method not found
    }
}

namespace MyApp.CodeWithImport
{
    using MyApp.Extensions;
    
    void Test2()
    {
        "123".IsNumeric(); // OK: Extension visible
    }
}
```

## Q: Can extension members access private members of the type they extend?

**A:** No. Extension members are external to the type and have the same access restrictions as any other external code. They can only access public and internal members (if in the same assembly). If you need to access private members, you must add the functionality directly to the type, use a derived class, or expose the necessary members through public/internal APIs.

```csharp
public class BankAccount
{
    private decimal balance;
    
    public decimal GetBalance() => balance;
}

public static class BankExtensions
{
    extension (BankAccount account)
    {
        public void PrintBalance()
        {
            // ERROR: Cannot access private field 'balance'
            // Console.WriteLine(account.balance);
            
            // OK: Can access public method
            Console.WriteLine(account.GetBalance());
        }
    }
}
```

## Q: How do I migrate existing extension methods to the new extension block syntax?

**A:** Migration is straightforward and can be done incrementally. Both syntaxes can coexist in the same static class. To migrate: (1) Create an extension block with the receiver type, (2) Move the method body inside the block, (3) Remove the `this` keyword from the parameter, (4) Optionally convert methods to properties if they're simple getters.

```csharp
// Before: Traditional extension methods
public static class StringExtensions
{
    public static bool IsEmpty(this string text) => 
        string.IsNullOrEmpty(text);
    
    public static int WordCount(this string text) =>
        text.Split(' ', StringSplitOptions.RemoveEmptyEntries).Length;
}

// After: Modern extension block
public static class StringExtensions
{
    extension (string text)
    {
        // Converted to property (no parens in usage)
        public bool IsEmpty => string.IsNullOrEmpty(text);
        
        // Remains a method (requires parens)
        public int WordCount() =>
            text.Split(' ', StringSplitOptions.RemoveEmptyEntries).Length;
    }
}

// Usage is identical or improved
string text = "  ";
bool empty1 = text.IsEmpty();   // Old style still works
bool empty2 = text.IsEmpty;     // New property style
```

## Q: What happens if two extension blocks in different namespaces add the same member?

**A:** The compiler reports an ambiguity error at the call site if both namespaces are imported. You must either: (1) Remove one `using` directive, (2) Use the static method syntax to disambiguate (`MyExtensions1.Method(obj)`), or (3) Refactor to avoid the conflict. This is the same behavior as traditional extension methods.

```csharp
namespace Extensions1
{
    public static class MyExtensions
    {
        extension (string text)
        {
            public int Length() => text.Length;
        }
    }
}

namespace Extensions2
{
    public static class MyExtensions
    {
        extension (string text)
        {
            public int Length() => text.Length * 2;
        }
    }
}

namespace MyApp
{
    using Extensions1;
    using Extensions2;
    
    void Test()
    {
        string s = "test";
        // ERROR: Ambiguous call
        int len = s.Length();
        
        // OK: Explicit disambiguation
        int len1 = Extensions1.MyExtensions.Length(s);
        int len2 = Extensions2.MyExtensions.Length(s);
    }
}
```

## Q: Can I create extension properties and how do they differ from extension methods?

**A:** Yes, extension blocks support properties alongside methods. Extension properties provide computed values with natural property syntax (no parentheses). Properties can have getters and setters, but setters must work with readonly or computed scenarios since extensions can't modify private state. Properties improve readability for simple value computations.

```csharp
public static class CollectionExtensions
{
    extension<T> (ICollection<T> collection)
    {
        // Property - no parentheses in usage
        public bool IsEmpty => collection.Count == 0;
        public bool IsNotEmpty => collection.Count > 0;
        
        // Method - requires parentheses
        public T[] ToArray() => collection.ToArray();
        
        // Property with calculation
        public int Capacity => collection is List<T> list ? list.Capacity : collection.Count;
    }
}

// Natural property access
var list = new List<int> { 1, 2, 3 };
if (list.IsNotEmpty)  // Property - no ()
{
    var array = list.ToArray();  // Method - needs ()
}
```

## Q: Are extension members compatible with LINQ and existing .NET APIs?

**A:** Yes. Extension members work seamlessly with LINQ and all .NET APIs. In fact, LINQ query operators are themselves implemented as extension methods on `IEnumerable<T>`. You can create custom query operators using either traditional extension methods or modern extension blocks, and they chain naturally with LINQ methods.

```csharp
public static class CustomQueryExtensions
{
    extension<T> (IEnumerable<T> source)
    {
        public IEnumerable<T> DistinctBy<TKey>(Func<T, TKey> keySelector)
        {
            var seen = new HashSet<TKey>();
            foreach (var item in source)
                if (seen.Add(keySelector(item)))
                    yield return item;
        }
        
        public IEnumerable<IEnumerable<T>> Batch(int size)
        {
            var batch = new List<T>(size);
            foreach (var item in source)
            {
                batch.Add(item);
                if (batch.Count == size)
                {
                    yield return batch;
                    batch = new List<T>(size);
                }
            }
            if (batch.Count > 0)
                yield return batch;
        }
    }
}

// Chains with standard LINQ operators
var people = GetPeople();
var batches = people
    .Where(p => p.Age >= 18)        // Standard LINQ
    .DistinctBy(p => p.Email)       // Custom extension
    .OrderBy(p => p.Name)           // Standard LINQ
    .Batch(100)                     // Custom extension
    .ToList();                      // Standard LINQ
```
