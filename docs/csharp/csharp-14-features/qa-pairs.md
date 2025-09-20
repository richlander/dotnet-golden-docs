# C# 14 Language Features - Q&A Pairs

## `field` Keyword in Properties

---

tags: ["intermediate", "properties", "field-keyword", "preview"]
validation: "Code examples compile with C# 14 preview and demonstrate field access"
---

Q: What is the `field` keyword and when should I use it?
A: The `field` keyword allows you to access the compiler-generated backing field in auto-implemented properties. Use it when you need custom logic (validation, transformation) while keeping the convenience of auto-implemented properties.

---

tags: ["intermediate", "properties", "field-keyword", "validation"]
validation: "Code compiles and demonstrates property validation with field keyword"
---

Q: How do I add validation to an auto-implemented property using the `field` keyword?
A: Use the `field` keyword in property accessors:

```csharp
public string Name
{
    get => field;
    set => field = string.IsNullOrWhiteSpace(value) ?
                   throw new ArgumentException("Name cannot be empty") : value.Trim();
}
```

---

tags: ["beginner", "properties", "field-keyword", "limitations"]
validation: "Accurately describes field keyword limitations"
---

Q: Where can I use the `field` keyword?
A: The `field` keyword can only be used within property accessors (get/set). It cannot be used in expression-bodied properties, methods, or other contexts.

---

tags: ["intermediate", "properties", "field-keyword", "preview"]
validation: "Correctly explains preview status and potential changes"
---

Q: Is the `field` keyword stable in C# 14?
A: No, the `field` keyword is currently a preview feature in C# 14. The syntax and behavior may change in future releases, so use with caution in production code.

## First-Class Span Types

---

tags: ["intermediate", "span", "performance", "memory"]
validation: "Code examples demonstrate first-class Span syntax and compile correctly"
---

Q: What are first-class Span types and how do they improve C#?
A: First-class Span types provide enhanced syntax support and implicit conversions for Span<T> and ReadOnlySpan<T>, enabling more natural usage patterns and zero-allocation string/array operations.

---

tags: ["intermediate", "span", "collections", "syntax"]
validation: "Code compiles and demonstrates collection expression syntax for Span"
---

Q: How do I create a Span using collection expressions?
A: You can use collection expression syntax:

```csharp
Span<int> numbers = [1, 2, 3, 4, 5];
ReadOnlySpan<char> text = "Hello World";
```

---

tags: ["advanced", "span", "performance", "memory"]
validation: "Code demonstrates zero-allocation string operations"
---

Q: How do first-class Spans help with string processing performance?
A: They enable zero-allocation substring operations:

```csharp
ReadOnlySpan<char> GetFileExtension(ReadOnlySpan<char> filename)
{
    int lastDot = filename.LastIndexOf('.');
    return lastDot >= 0 ? filename[(lastDot + 1)..] : [];
}
```

---

tags: ["advanced", "span", "safety", "limitations"]
validation: "Accurately describes ref safety rules and limitations"
---

Q: What safety rules still apply to first-class Span types?
A: First-class Span types are still subject to ref safety rules. They are stack-only types that cannot be used in async methods, stored in fields of reference types, or used as generic type arguments in certain contexts.

## Unbound Generic Types in `nameof`

---

tags: ["intermediate", "generics", "nameof", "reflection"]
validation: "Code examples compile and demonstrate unbound generic usage"
---

Q: What does unbound generic types in `nameof` mean?
A: You can now use `nameof` with generic type definitions without specifying type arguments, like `nameof(List<>)` instead of requiring `nameof(List<int>)`.

---

tags: ["intermediate", "generics", "nameof", "syntax"]
validation: "Code compiles and shows correct nameof syntax with unbound generics"
---

Q: How do I use `nameof` with unbound generic types?
A: Use angle brackets with commas for type parameters:

```csharp
string listName = nameof(List<>);           // "List"
string dictName = nameof(Dictionary<,>);    // "Dictionary"
string actionName = nameof(Action<,,,>);    // "Action"
```

---

tags: ["advanced", "generics", "reflection", "code-generation"]
validation: "Code demonstrates practical use case with reflection"
---

Q: When is unbound generic `nameof` useful in practice?
A: It's valuable for reflection and code generation scenarios:

```csharp
Type genericType = typeof(List<>);
string typeName = nameof(List<>);
MethodInfo addMethod = genericType.GetMethod(nameof(List<>.Add));
```

## Enhanced Lambda Parameters

---

tags: ["intermediate", "lambdas", "parameters", "modifiers"]
validation: "Code examples compile and demonstrate parameter modifiers in lambdas"
---

Q: What parameter modifiers are now supported in lambda expressions?
A: C# 14 supports `ref`, `out`, `in`, and `params` modifiers in simple lambda parameters for better type safety and performance.

---

tags: ["intermediate", "lambdas", "ref", "performance"]
validation: "Code compiles and demonstrates ref parameter usage in lambda"
---

Q: How do I use `ref` parameters in lambda expressions?
A: Use the `ref` modifier for efficient value type operations:

```csharp
var transform = (ref Point p) => p = new Point(p.X * 2, p.Y * 2);
```

---

tags: ["intermediate", "lambdas", "out", "initialization"]
validation: "Code compiles and demonstrates out parameter usage in lambda"
---

Q: Can I use `out` parameters in lambda expressions?
A: Yes, for initialization patterns:

```csharp
var tryParse = (string input, out int result) => int.TryParse(input, out result);
```

---

tags: ["intermediate", "lambdas", "params", "variadic"]
validation: "Code compiles and demonstrates params usage in lambda"
---

Q: How do `params` parameters work in lambda expressions?
A: They enable variable argument lists:

```csharp
var sum = (params int[] numbers) => numbers.Sum();
var result = sum(1, 2, 3, 4, 5); // Works with variable arguments
```

## Partial Events and Constructors

---

tags: ["advanced", "partial", "events", "constructors", "code-generation"]
validation: "Code examples compile and demonstrate partial member declarations"
---

Q: What are partial events and constructors in C# 14?
A: C# 14 allows partial declarations for events and constructors, enabling split implementations between generated and user code, commonly used in code generation scenarios.

---

tags: ["advanced", "partial", "constructors", "code-generation"]
validation: "Code compiles and demonstrates partial constructor pattern"
---

Q: How do I declare and implement a partial constructor?
A: Declare in one file, implement in another:

```csharp
// Generated file
public partial class MyClass
{
    public partial MyClass(string name);
}

// User file
public partial class MyClass
{
    public partial MyClass(string name)
    {
        Name = name ?? throw new ArgumentNullException(nameof(name));
    }
}
```

---

tags: ["advanced", "partial", "events", "code-generation"]
validation: "Code compiles and demonstrates partial event pattern"
---

Q: How do partial events work in practice?
A: Similar to partial constructors, with declaration and implementation split:

```csharp
// Generated file
public partial class MyClass
{
    public partial event EventHandler<DataEventArgs> DataChanged;
}

// User file
public partial class MyClass
{
    public partial event EventHandler<DataEventArgs> DataChanged
    {
        add => _dataChanged += value;
        remove => _dataChanged -= value;
    }
    private event EventHandler<DataEventArgs> _dataChanged;
}
```

## Extensions

---

tags: ["advanced", "extensions", "type-safety", "augmentation"]
validation: "Code examples compile and demonstrate Extensions syntax"
---

Q: What are Extensions in C# 14 and how do they differ from extension methods?
A: Extensions provide a new syntax for augmenting types with additional members. Unlike extension methods, they offer better type safety, natural syntax, and can include properties and other member types.

---

tags: ["advanced", "extensions", "syntax", "type-augmentation"]
validation: "Code compiles and demonstrates extension declaration and usage"
---

Q: How do I declare and use an Extension?
A: Use the `extension` keyword with `for` clause:

```csharp
public extension PersonExtensions for Person
{
    public string FullName => $"{FirstName} {LastName}";
    public bool IsAdult => Age >= 18;
    public void CelebrateBirthday() => Age++;
}

// Usage feels natural
var person = new Person { FirstName = "John", LastName = "Doe", Age = 17 };
Console.WriteLine(person.FullName); // "John Doe"
```

---

tags: ["advanced", "extensions", "limitations", "type-safety"]
validation: "Accurately describes extension limitations and safety rules"
---

Q: What are the limitations of Extensions?
A: Extensions don't support inheritance, follow specific name resolution rules, and type safety is enforced at compile time. They cannot override existing members or access private members of the extended type.

## Null-Conditional Assignment

---

tags: ["intermediate", "null-safety", "assignment", "syntax"]
validation: "Code examples compile and demonstrate null-conditional assignment"
---

Q: What is null-conditional assignment in C# 14?
A: Null-conditional assignment allows you to assign values only when the target is not null, using the `?.` syntax with assignment operations like `obj?.Property = value`.

---

tags: ["intermediate", "null-safety", "assignment", "patterns"]
validation: "Code compiles and demonstrates common usage patterns"
---

Q: How do I use null-conditional assignment?
A: Use the `?.` operator before assignment:

```csharp
// Traditional pattern
if (person.Address != null)
    person.Address.City = "New York";

// New null-conditional assignment
person.Address?.City = "New York";
```

---

tags: ["intermediate", "null-safety", "indexers", "collections"]
validation: "Code compiles and demonstrates indexer usage"
---

Q: Does null-conditional assignment work with indexers?
A: Yes, it works with both indexers and array access:

```csharp
dictionary?[key] = value;
array?[index] = item;
config?.Settings["theme"] = "dark";
```

---

tags: ["intermediate", "null-safety", "limitations", "scope"]
validation: "Accurately describes assignment scope limitations"
---

Q: What are the limitations of null-conditional assignment?
A: It's limited to assignment contexts and doesn't work with method calls or complex expressions. It may not short-circuit in all expected scenarios like method calls would.

## User-Defined Compound Assignment Operators

---

tags: ["advanced", "operators", "overloading", "compound-assignment"]
validation: "Code examples compile and demonstrate custom compound assignment operators"
---

Q: What are user-defined compound assignment operators in C# 14?
A: C# 14 allows types to define custom compound assignment operators (+=, -=, *=, etc.) directly, providing more natural syntax for custom types that support these operations.

---

tags: ["advanced", "operators", "syntax", "custom-types"]
validation: "Code compiles and demonstrates operator definition and usage"
---

Q: How do I define custom compound assignment operators?
A: Define them as static methods with specific signatures:

```csharp
public struct Vector2
{
    public float X, Y;

    public static Vector2 operator +=(Vector2 left, Vector2 right)
        => new(left.X + right.X, left.Y + right.Y);

    public static Vector2 operator *=(Vector2 left, float scalar)
        => new(left.X * scalar, left.Y * scalar);
}

// Usage
Vector2 velocity = new(10, 5);
velocity += new Vector2(2, 3); // Uses custom +=
velocity *= 1.5f;              // Uses custom *=
```

---

tags: ["advanced", "operators", "precedence", "design"]
validation: "Accurately describes operator precedence and design considerations"
---

Q: What should I consider when designing compound assignment operators?
A: Follow operator precedence and associativity rules, ensure consistent behavior with corresponding binary operators, and avoid complex implementations that reduce code readability.

## Expression Trees Enhancements

---

tags: ["advanced", "expression-trees", "linq", "optional-parameters"]
validation: "Code examples compile and demonstrate expression tree support for optional parameters"
---

Q: What expression tree improvements are in C# 14?
A: C# 14 adds support for optional and named arguments in LINQ expression trees, enabling more method calls to be represented as expressions.

---

tags: ["advanced", "expression-trees", "optional-parameters", "named-arguments"]
validation: "Code compiles and demonstrates expression tree with optional and named parameters"
---

Q: How do optional and named arguments work in expression trees?
A: They now compile correctly in expression contexts:

```csharp
// Method with optional parameters
public static void LogMessage(string message, LogLevel level = LogLevel.Info, string category = "General")
{
    Console.WriteLine($"[{level}] {category}: {message}");
}

// Expression tree with optional and named arguments (now works)
Expression<Action> expr = () => LogMessage("Hello", category: "App");
var compiled = expr.Compile();
compiled(); // "[Info] App: Hello"
```

---

tags: ["advanced", "expression-trees", "limitations", "compatibility"]
validation: "Accurately describes when feature is available and limitations"
---

Q: What are the limitations of expression tree enhancements?
A: These improvements only apply to LINQ expression trees and require C# 14. Complex optional parameter scenarios or certain named argument patterns may still not be supported in all contexts.
