# Lambda Expressions
## Quick Reference

**Expression lambda** - Single expression body:

```csharp
Func<int, int> square = x => x * x;
```

**Statement lambda** - Multiple statements:

```csharp
Func<int, int> square = x => { return x * x; };
```

**Natural type inference** - Compiler infers delegate type:

```csharp
var parse = (string s) => int.Parse(s); // Func<string, int>
```

**Parameter modifiers** - ref, out, in without explicit types:

```csharp
var tryParse = (string text, out int result) => int.TryParse(text, out result);
```

**Static lambda** - Prevents capturing variables:

```csharp
Func<int, int> add = static x => x + 1; // Error if it captures variables
```

**Async lambda** - Asynchronous operations:

```csharp
Func<Task<string>> fetchData = async () => await httpClient.GetStringAsync(url);
```

## Expression Lambdas

Expression lambdas have a single expression as the body. The expression result is the lambda's return value.

```csharp
// Single parameter, parentheses optional
Func<int, int> square = x => x * x;

// Multiple parameters require parentheses
Func<int, int, int> add = (x, y) => x + y;

// No parameters need empty parentheses
Func<string> getMessage = () => "Hello";

// Explicit return type
Func<double, double> sqrt = (double x) => Math.Sqrt(x);
```

**With LINQ:**

```csharp
var numbers = new[] { 1, 2, 3, 4, 5 };
var evens = numbers.Where(n => n % 2 == 0);
var squared = numbers.Select(n => n * n);
var sum = numbers.Aggregate((total, n) => total + n);
```
