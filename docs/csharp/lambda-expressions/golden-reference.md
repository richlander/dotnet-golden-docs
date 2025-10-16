# Lambda Expressions

## Overview

Lambda expressions create anonymous functions using the `=>` operator to separate parameters from the function body. Lambdas can be expression-bodied (`x => x * 2`) or statement-bodied (`x => { return x * 2; }`). The compiler infers delegate types from lambda signatures, eliminating explicit type declarations in most scenarios.

Lambdas integrate with LINQ queries, event handlers, Task-based async methods, and anywhere delegate or expression tree types are required. C# supports natural type inference, parameter modifiers (ref, out, in, params), default parameters, and static lambdas for avoiding unintended closures.

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

## Statement Lambdas

Statement lambdas use a block of statements enclosed in braces. Explicit `return` statements are required for non-void lambdas.

```csharp
Func<int, int> factorial = n =>
{
    int result = 1;
    for (int i = 2; i <= n; i++)
        result *= i;
    return result;
};

Action<string> log = message =>
{
    Console.WriteLine($"[{DateTime.Now}] {message}");
};
```

**With event handlers:**

```csharp
button.Click += (sender, e) =>
{
    var button = (Button)sender;
    button.Text = "Clicked!";
    button.Enabled = false;
};
```

## Natural Type Inference

Lambdas can have a natural type when the compiler can infer the delegate type from the lambda's signature.

```csharp
// Compiler infers Func<string, int>
var parse = (string s) => int.Parse(s);

// Can assign to object or Delegate
object obj = (string s) => int.Parse(s);
Delegate del = (string s) => int.Parse(s);

// Method groups with one overload have natural type
var read = Console.Read; // Func<int>
```

**Without natural type (requires explicit delegate type):**

```csharp
// Multiple overloads - can't infer
// var write = Console.Write; // Error

// Must specify the delegate type
Action<string> write = Console.Write;
```

## Parameter Modifiers

Lambdas support `ref`, `out`, `in`, and `params` modifiers on parameters. Since C# 14, modifiers can be used without explicit parameter types.

**ref parameters** - Pass by reference for mutation:

```csharp
delegate void Transform(ref int value);
Transform double = (ref int x) => x *= 2;

int num = 5;
double(ref num);
Console.WriteLine(num); // 10
```

**out parameters** - Return multiple values:

```csharp
var tryParse = (string text, out int result) => int.TryParse(text, out result);

if (tryParse("123", out int value))
    Console.WriteLine(value);
```

**in parameters** - Read-only reference for large structs:

```csharp
delegate double Calculate(in Matrix matrix);
Calculate determinant = (in Matrix m) => m.Determinant();
```

**params parameters** - Variable arguments (requires explicit type):

```csharp
Func<int[], int> sum = (params int[] numbers) => numbers.Sum();
var total = sum(1, 2, 3, 4, 5);
```

## Default Parameters

Lambda expressions can declare default parameter values (C# 12).

```csharp
var increment = (int value, int step = 1) => value + step;

Console.WriteLine(increment(5));    // 6 (uses default step=1)
Console.WriteLine(increment(5, 3)); // 8 (uses step=3)
```

Default parameters work with method groups:

```csharp
static int Add(int a, int b = 0) => a + b;

var add = Add; // Lambda has default parameter
Console.WriteLine(add(5));    // 5
Console.WriteLine(add(5, 3)); // 8
```

## Static Lambdas

The `static` modifier prevents a lambda from capturing local variables or instance state. This helps avoid unintended allocations and memory leaks.

```csharp
int multiplier = 2;

// Regular lambda captures 'multiplier'
Func<int, int> multiply1 = x => x * multiplier; // Allocates closure

// Static lambda prevents capture
// Func<int, int> multiply2 = static x => x * multiplier; // Error

// Static lambda with const is valid
const int factor = 2;
Func<int, int> multiply3 = static x => x * factor; // OK
```

**Use static lambdas when:**

- Lambda doesn't need to capture variables
- Performance-critical code (avoids closure allocation)
- Preventing accidental captures

## Async Lambdas

Lambdas can use `async` and `await` for asynchronous operations.

```csharp
Func<Task<string>> getData = async () =>
{
    using var client = new HttpClient();
    return await client.GetStringAsync("https://api.example.com/data");
};

// Event handler with async lambda
button.Click += async (sender, e) =>
{
    button.Enabled = false;
    try
    {
        var data = await FetchDataAsync();
        label.Text = data;
    }
    finally
    {
        button.Enabled = true;
    }
};
```

**Async lambda returning void (fire-and-forget):**

```csharp
Action fireAndForget = async () =>
{
    await Task.Delay(1000);
    Console.WriteLine("Completed");
};
```

## Lambdas with Tuples

Lambdas can work with tuple parameters and return tuples.

```csharp
// Tuple parameter
Func<(int x, int y), int> distance = point => point.x + point.y;

// Tuple return
Func<int, (int square, int cube)> powers = x => (x * x, x * x * x);

var result = powers(3);
Console.WriteLine($"Square: {result.square}, Cube: {result.cube}");
```

## Discard Parameters

Use discards (`_`) for unused lambda parameters.

```csharp
// Ignore event sender
button.Click += (_, e) => Console.WriteLine("Clicked");

// Ignore multiple parameters
Func<int, int, int, int> useOnlyFirst = (x, _, _) => x * 2;
```

## Expression Trees

Expression lambdas can be converted to expression trees for runtime analysis and compilation.

```csharp
Expression<Func<int, int>> expr = x => x * 2;

// Inspect the expression
Console.WriteLine(expr); // x => (x * 2)

// Compile and execute
var compiled = expr.Compile();
Console.WriteLine(compiled(5)); // 10
```

**Note:** Statement lambdas cannot be converted to expression trees. Only expression lambdas are supported.

## Type Inference

The compiler infers lambda parameter types from context.

```csharp
// Inferred from IEnumerable<int>
var numbers = new[] { 1, 2, 3 };
var evens = numbers.Where(n => n % 2 == 0); // n is int

// Explicit types when needed
Func<object, bool> isNull = (object obj) => obj == null;
```

**Inference rules:**

- Lambda must have same parameter count as delegate type
- Each parameter must be implicitly convertible to delegate parameter
- Return value must be convertible to delegate return type

## Considerations

- **Captured variables:** Lambdas capture variables from enclosing scope. These captures create closures that can extend variable lifetime and allocate memory.
- **Delegate allocation:** Each lambda expression allocates a delegate instance. Cache delegates as static readonly fields in performance-critical code to reuse instances.
- **Statement lambdas in expression trees:** Not supported. Only expression lambdas can convert to expression trees.
- **Natural type limitations:** Multiple overloaded method groups don't have natural type. Specify the delegate type explicitly.
- **Static lambda restrictions:** Cannot capture any variables or instance members. Use for performance when no captures are needed.
- **Async void lambdas:** Avoid except for event handlers. Exceptions can't be caught, and completion can't be awaited.
- **Default parameters and params:** Don't map to standard `Func<>` or `Action<>` types. Compiler synthesizes custom delegate types.
- **Single parameter parentheses:** Optional for single parameters without modifiers (`x => x * 2`). Required with modifiers (`(ref x) => x * 2`).

## See Also

- Extension Members (extension methods as delegates)
- Async Streams and Advanced Patterns (async lambdas with IAsyncEnumerable)
- Pattern Matching (switch expressions with lambdas)
