# Collection Expressions
## Limitations and Considerations
### Combining Collections

The spread operator provides an elegant way to combine multiple collections:

```csharp
int[] first = [1, 2, 3];
int[] second = [4, 5, 6];

// Using collection expressions with spread
int[] combined = [..first, ..second];
List<int> list = [..first, ..second];
```

## Best Practices

1. Use for readability: Collection expressions make code more concise and readable
2. Prefer for small collections: Most beneficial for small to medium-sized collections
3. Combine with spread: Use spread operator to combine existing collections elegantly
4. Target type clarity: Ensure target type is clear to avoid compilation errors
5. Performance awareness: Understand that spread operations may involve copying data

## Limitations and Considerations

### Compile-Time Constants

Collection expressions cannot be used where compile-time constants are required:

```csharp
// Not allowed - compile-time constant required
const int[] CONSTANT_ARRAY = [1, 2, 3];

// Not allowed - default parameter value
void Method(int[] values = [1, 2, 3]) { }

// Allowed - runtime initialization
static readonly int[] ReadOnlyArray = [1, 2, 3];
```

### Type Requirements

Target type must be known or inferrable:

```csharp
// Ambiguous - compiler can't determine type
var unclear = [1, 2, 3];

// Clear target type
List<int> clear = [1, 2, 3];
int[] alsoGood = [1, 2, 3];
```
