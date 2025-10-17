# .NET Libraries
## Fundamental System Libraries

### Core Data Types and Primitives

```csharp
// Fundamental value types
int number = 42;                          // System.Int32
string text = "Hello";                    // System.String
bool isActive = true;                     // System.Boolean
DateTime now = DateTime.UtcNow;           // System.DateTime
Guid id = Guid.NewGuid();                 // System.Guid

// Collections and data structures
List<T> items = new List<T>();            // System.Collections.Generic.List<T>
Dictionary<K,V> map = new();              // System.Collections.Generic.Dictionary<K,V>
ReadOnlySpan<char> span = text.AsSpan();  // System.ReadOnlySpan<T>
```

### I/O and File System Operations

```csharp
// File system operations
using System.IO;
string content = File.ReadAllText("file.txt");
await File.WriteAllTextAsync("output.txt", content);

// Streams and advanced I/O
using var stream = new FileStream("data.bin", FileMode.Open);
using var reader = new StreamReader(stream);
string line = await reader.ReadLineAsync();

// Path manipulation
string fullPath = Path.Combine("folder", "subfolder", "file.txt");
string extension = Path.GetExtension(fullPath);
```

### Networking and HTTP

```csharp
// HTTP client operations
using System.Net.Http;
using var client = new HttpClient();
HttpResponseMessage response = await client.GetAsync("https://api.example.com");
string json = await response.Content.ReadAsStringAsync();

// Advanced HTTP scenarios
using var request = new HttpRequestMessage(HttpMethod.Post, endpoint);
request.Content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");
HttpResponseMessage result = await client.SendAsync(request);
```

### Asynchronous Programming

```csharp
// Task-based asynchronous patterns
public async Task<string> ProcessDataAsync()
{
    string data = await ReadDataAsync();
    string processed = await TransformDataAsync(data);
    await SaveDataAsync(processed);
    return processed;
}

// Parallel execution and coordination
await Task.WhenAll(
    ProcessFileAsync("file1.txt"),
    ProcessFileAsync("file2.txt"),
    ProcessFileAsync("file3.txt")
);

// Cancellation and timeout handling
using var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));
await LongRunningOperationAsync(cts.Token);
```
