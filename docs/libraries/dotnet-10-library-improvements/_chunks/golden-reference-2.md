# .NET 10 Libraries
## File and Version Sorting
### Secure JSON Processing (Strict Options)

Preset applies security best practices for untrusted JSON input.

```csharp
// Strict mode prevents security vulnerabilities
JsonSerializerOptions options = JsonSerializerOptions.Strict;
// Disallows: unmapped members, duplicate properties, case variations
MyObject obj = JsonSerializer.Deserialize<MyObject>(untrustedJson, options);
```

### High-Performance Text Processing (UTF-8 Hex)

Direct UTF-8 to hex conversion without string allocation overhead.

```csharp
byte[] data = GetBinaryData();
Span<byte> hexBuffer = stackalloc byte[data.Length * 2];
Convert.TryToHexString(data, hexBuffer, out int written);
// hexBuffer now contains UTF-8 encoded hex representation
```

### Tensor Operations (Stable APIs)

Tensor APIs graduated from experimental to stable with performance improvements.

```csharp
// Tensor arithmetic with generic math support
Tensor<float> a = ..., b = ...;
Tensor<float> result = a + b; // C# 14 extension operators

// High-performance slicing without data copying
ReadOnlyTensorSpan<float> slice = tensor.Slice(start..end);
// slice is a view, no memory allocation
```

## Relationships & Integration

These features integrate with existing .NET patterns:

- Span-based APIs: Reduce allocations in string normalization, hex conversion
- StringComparer patterns: NumericOrdering works with LINQ, collections, search operations
- JSON serialization: New security options complement existing JsonSerializerOptions
- Cryptography: Post-quantum algorithms follow established patterns for key generation/import
- Collections: OrderedDictionary performance improvements benefit JSON processing

## File and Version Sorting

Natural ordering for filenames, version numbers, and mixed alphanumeric content.
