# Lambda Expressions
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
