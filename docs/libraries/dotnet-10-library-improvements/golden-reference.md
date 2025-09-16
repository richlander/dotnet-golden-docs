# .NET 10 Libraries Features - Golden Reference

## Overview
.NET 10 introduces numerous library improvements across globalization, serialization, cryptography, collections, and other core areas. These features focus on developer productivity, performance, and modern development patterns. Key themes include span-based APIs for performance, enhanced security options, and better cross-platform support.

## Essential Features & Examples

### Numeric String Comparison (CompareOptions.NumericOrdering)
Natural string comparison where numbers are compared numerically rather than lexicographically.

```csharp
StringComparer numericComparer = StringComparer.Create(CultureInfo.CurrentCulture, CompareOptions.NumericOrdering);

// "2" comes before "10" numerically (vs lexicographically where "10" < "2")
string[] files = { "file10.txt", "file2.txt", "file1.txt" };
Array.Sort(files, numericComparer);
// Result: ["file1.txt", "file2.txt", "file10.txt"]

// Leading zeros are treated as equal
Console.WriteLine(numericComparer.Equals("02", "2")); // True
```

### JSON Serialization Security (AllowDuplicateProperties)
Prevent security vulnerabilities from duplicate JSON properties.

```csharp
string json = """{ "Value": 1, "Value": -1 }""";
JsonSerializerOptions options = new() { AllowDuplicateProperties = false };
// Throws JsonException instead of silently using last value
JsonSerializer.Deserialize<MyRecord>(json, options);
```

### Post-Quantum Cryptography
Support for ML-KEM, ML-DSA, and SLH-DSA algorithms for quantum-resistant security.

```csharp
// Generate ML-KEM key for key encapsulation
using MLKem key = MLKem.GenerateKey(MLKemAlgorithm.MLKem768);
string publicKeyPem = key.ExportSubjectPublicKeyInfoPem();

// Sign data with ML-DSA
using MLDsa signingKey = MLDsa.ImportFromPem(privateKeyPem);
byte[] signature = signingKey.SignData(data);
```

### High-Performance Collections (OrderedDictionary)
New overloads return index for efficient subsequent operations.

```csharp
OrderedDictionary<string, int> dict = new();
if (!dict.TryAdd(key, 1, out int index))
{
    // Key existed, increment at known index
    int currentValue = dict.GetAt(index).Value;
    dict.SetAt(index, currentValue + 1);
}
```

### WebSocket Streaming (WebSocketStream)
Stream-based abstraction simplifies WebSocket usage for streaming protocols.

```csharp
// Streaming text protocols (STOMP, IRC, etc.)
using WebSocketStream stream = WebSocketStream.Create(webSocket, WebSocketMessageType.Text);
using var reader = new StreamReader(stream, Encoding.UTF8);
using var writer = new StreamWriter(stream, Encoding.UTF8);

string command = await reader.ReadLineAsync();
await writer.WriteLineAsync("PONG");

// JSON over WebSocket
using WebSocketStream readStream = WebSocketStream.CreateReadableMessageStream(webSocket);
MyData data = await JsonSerializer.DeserializeAsync<MyData>(readStream);
```

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
- **Span-based APIs**: Reduce allocations in string normalization, hex conversion
- **StringComparer patterns**: NumericOrdering works with LINQ, collections, search operations
- **JSON serialization**: New security options complement existing JsonSerializerOptions
- **Cryptography**: Post-quantum algorithms follow established patterns for key generation/import
- **Collections**: OrderedDictionary performance improvements benefit JSON processing

## Common Scenarios

### File/Version Sorting
Natural ordering for filenames, version numbers, and mixed alphanumeric content.

### Security-First JSON Processing
Strict validation and duplicate detection for untrusted JSON inputs.

### Future-Proof Cryptography
Quantum-resistant algorithms for long-term security requirements.

### High-Performance Text Processing
Span-based normalization and UTF-8 operations without string allocations.

## Gotchas & Limitations

**NumericOrdering**: Only works with comparison operations, not IndexOf/StartsWith/EndsWith
**Post-Quantum Crypto**: Requires OpenSSL 3.5+ or Windows CNG with PQC support
**JSON Security**: Duplicate detection adds parsing overhead
**Span APIs**: Require careful lifetime management to avoid dangling references

## See Also
- Performance optimizations in .NET 10
- Cross-platform compatibility improvements
- Native AOT support enhancements
- Security hardening features