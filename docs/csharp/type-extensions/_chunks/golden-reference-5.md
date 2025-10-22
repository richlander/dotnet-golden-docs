# Type Extensions
## Gotchas & Limitations

### Extension Method Resolution

Extensions don't override instance methods.

```csharp
public class MyClass
{
    public void DoSomething() => Console.WriteLine("Instance method");
}

public static class Extensions
{
    extension (MyClass obj)
    {
        // This will NEVER be called if instance method exists
        public void DoSomething() => Console.WriteLine("Extension");
    }
}

var obj = new MyClass();
obj.DoSomething(); // Always calls instance method: "Instance method"
```

### Scope and Visibility

Extensions require explicit namespace imports.

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

namespace MyApp
{
    // Error: IsNumeric not available without 'using'
    void Test()
    {
        "123".IsNumeric(); // Compile error
    }
}

namespace MyApp.WithImport
{
    using MyApp.Extensions;
    
    void Test()
    {
        "123".IsNumeric(); // Works
    }
}
```

### Generic Type Inference

All type parameters must be inferrable from the receiver and member parameters.

```csharp
public static class InvalidExtensions
{
    // ERROR: T1 not inferrable
    extension<T1> (string text)
    {
        public void Method() { } // T1 never used
    }
    
    // VALID: T used in receiver type
    extension<T> (IEnumerable<T> source)
    {
        public void Process() { } // T inferrable from receiver
    }
    
    // VALID: TResult inferrable from parameter
    extension<T> (IEnumerable<T> source)
    {
        public IEnumerable<TResult> Convert<TResult>(Func<T, TResult> selector)
        {
            return source.Select(selector);
        }
    }
}
```
