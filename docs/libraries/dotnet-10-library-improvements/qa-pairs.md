# .NET 10 Libraries Features - Q&A Pairs

## Numeric String Comparison (CompareOptions.NumericOrdering)

---
tags: ["intermediate", "strings", "comparison", "performance"]
validation: "Code examples compile and demonstrate natural string ordering"
---
Q: What is CompareOptions.NumericOrdering and when should I use it?
A: CompareOptions.NumericOrdering enables natural string comparison where numeric portions are compared by value rather than lexicographically. Use it for sorting filenames, version numbers, or any mixed alphanumeric content where "file2.txt" should come before "file10.txt".

---
tags: ["intermediate", "strings", "comparison", "api"]
validation: "Code compiles and creates working comparer"
---
Q: How do I create a comparer with numeric ordering?
A: Use StringComparer.Create() with the NumericOrdering flag:
```csharp
StringComparer comparer = StringComparer.Create(CultureInfo.CurrentCulture, CompareOptions.NumericOrdering);
```

---
tags: ["intermediate", "strings", "comparison", "flags"]
validation: "Code compiles and demonstrates flag combination"
---
Q: Can I combine NumericOrdering with other CompareOptions?
A: Yes, you can combine it with flags like IgnoreCase:
```csharp
var options = CompareOptions.NumericOrdering | CompareOptions.IgnoreCase;
var comparer = StringComparer.Create(CultureInfo.CurrentCulture, options);
```

---
tags: ["intermediate", "strings", "comparison", "limitations"]
validation: "Accurately describes API limitations"
---
Q: Does numeric ordering work with IndexOf, StartsWith, or EndsWith?
A: No, NumericOrdering only works with comparison operations like Compare() and Equals(). It cannot be used with search operations like IndexOf, StartsWith, or EndsWith.

---
tags: ["intermediate", "strings", "comparison", "behavior"]
validation: "Demonstrates leading zero behavior correctly"
---
Q: How does leading zero handling work?
A: Leading zeros are ignored for numeric comparison. "02" equals "2" numerically, and both sort before "10".

---
tags: ["intermediate", "strings", "comparison", "parsing"]
validation: "Demonstrates mixed content sorting behavior"
---
Q: What happens with mixed content like "abc123def"?
A: The string is parsed into segments. Non-numeric portions use lexicographic comparison while numeric portions use numeric comparison:
```csharp
// Result: ["abc1def", "abc2def", "abc10def"]
```

## JSON Serialization Security (AllowDuplicateProperties)

---
tags: ["security", "json", "serialization", "intermediate"]
validation: "Accurately describes security vulnerability and mitigation"
---
Q: What security issue does AllowDuplicateProperties address?
A: Duplicate JSON properties can cause confusion and security vulnerabilities. By default, JSON deserializer uses the last value for duplicates, which attackers might exploit. Setting AllowDuplicateProperties to false throws an exception instead.

---
tags: ["security", "json", "serialization", "configuration"]
validation: "Code compiles and throws on duplicate properties"
---
Q: How do I enable duplicate property detection?
A: Set the option to false in JsonSerializerOptions:
```csharp
JsonSerializerOptions options = new() { AllowDuplicateProperties = false };
JsonSerializer.Deserialize<T>(json, options); // Throws on duplicates
```

---
tags: ["security", "json", "serialization", "apis"]
validation: "Confirms API availability across JSON types"
---
Q: Does this work with JsonDocument and other JSON APIs?
A: Yes, both JsonSerializerOptions and JsonDocumentOptions support AllowDuplicateProperties.

## Post-Quantum Cryptography

---
tags: ["advanced", "cryptography", "security", "quantum"]
validation: "Lists correct FIPS standard algorithms"
---
Q: What post-quantum algorithms are supported in .NET 10?
A: .NET 10 supports ML-KEM (FIPS 203), ML-DSA (FIPS 204), and SLH-DSA (FIPS 205) for quantum-resistant security.

---
tags: ["advanced", "cryptography", "security", "availability"]
validation: "Code compiles and correctly checks algorithm support"
---
Q: How do I check if post-quantum crypto is available?
A: Use the static IsSupported property:
```csharp
if (MLKem.IsSupported)
{
    // Use ML-KEM algorithms
}
```

---
tags: ["advanced", "cryptography", "platforms", "requirements"]
validation: "Accurately describes platform requirements"
---
Q: What platforms support post-quantum cryptography?
A: Systems with OpenSSL 3.5+ or Windows CNG with PQC support. The algorithms require specific cryptographic library versions.

---
tags: ["advanced", "cryptography", "keys", "generation"]
validation: "Code compiles and generates valid key pair"
---
Q: How do I generate a post-quantum key?
A: Use static factory methods:
```csharp
using MLKem key = MLKem.GenerateKey(MLKemAlgorithm.MLKem768);
string publicKeyPem = key.ExportSubjectPublicKeyInfoPem();
```

## String Normalization Span APIs

---
tags: ["intermediate", "strings", "performance", "spans"]
validation: "Correctly lists new span-based methods"
---
Q: What are the new span-based normalization APIs?
A: .NET 10 adds GetNormalizedLength(), IsNormalized(), and TryNormalize() methods that work with ReadOnlySpan<char> to avoid string allocations.

---
tags: ["intermediate", "strings", "performance", "guidance"]
validation: "Provides clear usage guidance for span APIs"
---
Q: When should I use span normalization instead of string normalization?
A: Use span APIs when you're already working with character arrays or spans, or when you want to avoid allocating temporary strings during normalization.

---
tags: ["intermediate", "strings", "performance", "allocation"]
validation: "Code compiles and demonstrates zero-allocation normalization"
---
Q: How do I normalize text without allocating a new string?
A: Use TryNormalize with a pre-allocated buffer:
```csharp
bool success = text.TryNormalize(buffer, out int written, NormalizationForm.FormC);
```

## OrderedDictionary Performance Improvements

---
tags: ["intermediate", "collections", "performance", "indexing"]
validation: "Accurately describes new index-returning overloads"
---
Q: What's new with OrderedDictionary in .NET 10?
A: New TryAdd() and TryGetValue() overloads return the index of the entry, enabling efficient subsequent operations without additional lookups.

---
tags: ["intermediate", "collections", "performance", "optimization"]
validation: "Code compiles and demonstrates performance optimization"
---
Q: How do the new index-returning methods improve performance?
A: Instead of multiple hash table lookups, you can use the returned index for direct access:
```csharp
if (!dict.TryAdd(key, value, out int index))
{
    dict.SetAt(index, newValue); // Direct index access, no hash lookup
}
```

---
tags: ["intermediate", "collections", "performance", "benchmarks"]
validation: "Cites realistic performance improvement data"
---
Q: What performance improvement does this provide?
A: JsonObject uses this optimization and sees 10-20% performance improvement for property updates.

## UTF-8 Hex Conversion

---
tags: ["intermediate", "encoding", "performance", "utf8"]
validation: "Accurately describes UTF-8 hex methods"
---
Q: What are the new UTF-8 hex conversion methods?
A: Convert class now has methods that work directly with UTF-8 byte sequences for hex conversion without requiring intermediate string allocations.

---
tags: ["intermediate", "encoding", "performance", "guidance"]
validation: "Provides clear guidance on when to use UTF-8 methods"
---
Q: When should I use UTF-8 hex conversion over string-based conversion?
A: Use UTF-8 methods when you're already working with byte data or UTF-8 encoded text to avoid the overhead of string creation and UTF-8 to UTF-16 conversion.

## Cryptography Enhancements

---
tags: ["intermediate", "cryptography", "certificates", "thumbprints"]
validation: "Code compiles and finds certificates by SHA-256 thumbprint"
---
Q: How do I search for certificates by non-SHA-1 thumbprints?
A: Use the new FindByThumbprint method that accepts a hash algorithm name:
```csharp
X509Certificate2Collection certs = store.Certificates.FindByThumbprint(HashAlgorithmName.SHA256, thumbprint);
```

---
tags: ["intermediate", "cryptography", "pem", "encoding"]
validation: "Accurately describes UTF-8 PEM encoding improvements"
---
Q: What's new with PEM encoding in .NET 10?
A: PemEncoding.FindUtf8() works directly with byte arrays for ASCII/UTF-8 PEM data, avoiding the need to convert bytes to chars first.

---
tags: ["intermediate", "cryptography", "pkcs12", "encryption"]
validation: "Accurately describes PKCS#12 algorithm control"
---
Q: How do I control PKCS#12 encryption algorithms?
A: Use the new ExportPkcs12 overloads that accept Pkcs12ExportPbeParameters or PbeParameters to choose specific encryption and digest algorithms.

## WebSocketStream

---
tags: ["intermediate", "websockets", "streams", "networking"]
validation: "Accurately describes WebSocketStream benefits"
---
Q: What is WebSocketStream and why should I use it?
A: WebSocketStream is a new Stream-based abstraction over WebSocket that simplifies common WebSocket scenarios. It eliminates the need for manual message framing, buffering, and encoding/decoding, making WebSockets easier to use as a transport for streaming protocols.

---
tags: ["intermediate", "websockets", "streams", "creation"]
validation: "Code compiles and creates WebSocketStream instances"
---
Q: How do I create a WebSocketStream?
A: Use the static factory methods:
```csharp
// For bidirectional communication
WebSocketStream stream = WebSocketStream.Create(webSocket, WebSocketMessageType.Binary);

// For read-only scenarios
WebSocketStream readStream = WebSocketStream.CreateReadableMessageStream(webSocket);

// For write-only scenarios
WebSocketStream writeStream = WebSocketStream.CreateWritableMessageStream(webSocket, WebSocketMessageType.Text);
```

---
tags: ["intermediate", "websockets", "streams", "protocols"]
validation: "Code compiles and demonstrates STOMP protocol usage"
---
Q: How does WebSocketStream simplify streaming text protocols like STOMP?
A: You can use standard StreamReader/StreamWriter:
```csharp
using WebSocketStream stream = WebSocketStream.Create(webSocket, WebSocketMessageType.Text);
using var reader = new StreamReader(stream, Encoding.UTF8);
using var writer = new StreamWriter(stream, Encoding.UTF8);

string command = await reader.ReadLineAsync();
await writer.WriteLineAsync("CONNECT");
await writer.FlushAsync();
```

---
tags: ["intermediate", "websockets", "streams", "json"]
validation: "Code compiles and deserializes JSON from WebSocketStream"
---
Q: Can I use WebSocketStream with JSON serialization?
A: Yes, it integrates seamlessly with JsonSerializer:
```csharp
using WebSocketStream stream = WebSocketStream.CreateReadableMessageStream(webSocket);
MyData data = await JsonSerializer.DeserializeAsync<MyData>(stream);
```

## Strict JSON Serialization Options

---
tags: ["security", "json", "serialization", "validation"]
validation: "Accurately describes Strict mode security benefits"
---
Q: What is JsonSerializerOptions.Strict and when should I use it?
A: JsonSerializerOptions.Strict is a preset that applies security best practices for JSON processing. Use it when processing untrusted JSON input to prevent common security issues.

---
tags: ["security", "json", "serialization", "configuration"]
validation: "Lists correct Strict mode configuration options"
---
Q: What specific options does Strict mode enable?
A: Strict mode includes:
- Disallows unmapped members (JsonUnmappedMemberHandling.Disallow)
- Prevents duplicate properties (AllowDuplicateProperties = false)
- Preserves case sensitivity
- Enables nullable annotations and required constructor parameters

---
tags: ["security", "json", "serialization", "compatibility"]
validation: "Correctly describes compatibility limitations"
---
Q: Is Strict mode compatible with Default mode?
A: Yes, objects serialized with JsonSerializerOptions.Default can be deserialized with JsonSerializerOptions.Strict, but not vice versa.

---
tags: ["security", "json", "serialization", "usage"]
validation: "Code compiles and uses Strict mode correctly"
---
Q: How do I use Strict mode?
A: Simply use the preset:
```csharp
JsonSerializerOptions options = JsonSerializerOptions.Strict;
MyObject obj = JsonSerializer.Deserialize<MyObject>(json, options);
```

## UTF-8 Hex Conversion

---
tags: ["intermediate", "encoding", "performance", "hex"]
validation: "Code compiles and converts bytes to hex UTF-8"
---
Q: What are the new UTF-8 hex conversion methods?
A: Convert class now has methods that work directly with UTF-8 byte sequences for hex conversion without requiring intermediate string allocations:
```csharp
byte[] data = {0x48, 0x65, 0x6C, 0x6C, 0x6F}; // "Hello" in bytes
Span<byte> hexBuffer = stackalloc byte[data.Length * 2];
Convert.TryToHexString(data, hexBuffer, out int written);
```

---
tags: ["intermediate", "encoding", "performance", "guidance"]
validation: "Provides clear performance guidance for UTF-8 hex methods"
---
Q: When should I use UTF-8 hex methods over string-based ones?
A: Use UTF-8 methods when you're already working with byte data or UTF-8 encoded text to avoid string allocation overhead and UTF-8 to UTF-16 conversion costs.

---
tags: ["intermediate", "encoding", "api", "reference"]
validation: "Lists correct UTF-8 hex method signatures"
---
Q: What UTF-8 hex methods are available?
A: The main methods are:
- FromHexString(ReadOnlySpan<byte>) - Convert hex UTF-8 bytes to binary
- TryToHexString(ReadOnlySpan<byte>, Span<byte>, out int) - Convert binary to hex UTF-8
- TryToHexStringLower(ReadOnlySpan<byte>, Span<byte>, out int) - Convert to lowercase hex

## Tensor Enhancements

---
tags: ["advanced", "tensors", "math", "performance"]
validation: "Accurately describes tensor API stability and improvements"
---
Q: What's new with tensors in .NET 10?
A: Tensor APIs are now stable and no longer experimental. They include a nongeneric IReadOnlyTensor interface, improved slice operations that don't copy data, and support for C# 14 extension operators.

---
tags: ["advanced", "tensors", "performance", "slicing"]
validation: "Accurately describes zero-copy slice improvements"
---
Q: How do tensor slice operations improve performance?
A: Slice operations no longer copy data, they create views into the original tensor data, significantly improving performance for large tensors.

---
tags: ["advanced", "tensors", "operators", "math"]
validation: "Code compiles and demonstrates tensor arithmetic operators"
---
Q: What are C# 14 extension operators for tensors?
A: When the tensor's element type T supports generic math interfaces like IAdditionOperators<T,T,T>, you can use arithmetic operators directly:
```csharp
Tensor<int> a = ..., b = ...;
Tensor<int> result = a + b; // Available for int, not for bool
```

---
tags: ["advanced", "tensors", "interfaces", "api"]
validation: "Accurately describes IReadOnlyTensor interface purpose"
---
Q: What is the IReadOnlyTensor interface for?
A: It provides nongeneric access to tensor properties like Lengths and Strides, and allows boxing tensor data to object when performance isn't critical.

---
tags: ["advanced", "tensors", "packages", "support"]
validation: "Correctly describes NuGet package status"
---
Q: Do I still need the System.Numerics.Tensors NuGet package?
A: Yes, but the APIs are now stable and fully supported rather than experimental.