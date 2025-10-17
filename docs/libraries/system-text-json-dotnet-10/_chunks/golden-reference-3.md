# System.Text.Json - What's New in .NET 10
## ASP.NET Core Integration

Configure .NET 10 features globally in ASP.NET Core:

```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);

// Configure JSON options for all endpoints
builder.Services.ConfigureHttpJsonOptions(options =>
{
    // Use strict validation
    options.SerializerOptions.AllowDuplicateProperties = false;
    options.SerializerOptions.UnmappedMemberHandling = 
        JsonUnmappedMemberHandling.Disallow;
    
    // Add custom configuration
    options.SerializerOptions.PropertyNamingPolicy = 
        JsonNamingPolicy.CamelCase;
});

var app = builder.Build();

// All API endpoints now use these settings
app.MapPost("/api/payment", (Payment payment) =>
{
    // Payment was validated during deserialization
    return ProcessPayment(payment);
});

app.Run();

record Payment(decimal Amount, string Currency);
```

## Migration Guidance

### Adopting Strict Options

Start with strict options for new APIs:

```csharp
// For new APIs - start with strict
var strictOptions = JsonSerializerOptions.Strict;

// For existing APIs - test first, then migrate gradually
var testOptions = new JsonSerializerOptions
{
    AllowDuplicateProperties = false  // Start with just this
};

// Test with production-like data
var result = JsonSerializer.Deserialize<MyType>(json, testOptions);
```

### Enabling Duplicate Detection

Add duplicate detection incrementally:

```csharp
// Step 1: Add to new deserialization code
var options = new JsonSerializerOptions 
{ 
    AllowDuplicateProperties = false 
};

// Step 2: Monitor for failures in logs

// Step 3: Roll out to existing code paths after validation
```

### Using PipeReader

Migrate from streams to `PipeReader`:

```csharp
// Before
using var stream = GetDataStream();
var data = await JsonSerializer.DeserializeAsync<MyData>(stream);

// After - wrap stream in PipeReader
var pipeReader = PipeReader.Create(GetDataStream());
var data = await JsonSerializer.DeserializeAsync<MyData>(pipeReader);

// Or use directly with System.IO.Pipelines
var pipe = new Pipe();
// ... use pipe.Reader and pipe.Writer
```
