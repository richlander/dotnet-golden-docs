# .NET 10 Libraries
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
