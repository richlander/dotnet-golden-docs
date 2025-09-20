# .NET Libraries - Golden Reference

## Overview

The .NET library ecosystem provides a comprehensive foundation of APIs, frameworks, and components that enable developers to build applications across multiple platforms and scenarios. This includes the Base Class Library (BCL), runtime libraries, application frameworks, and the broader NuGet ecosystem of third-party packages.

Core library categories:

- **Base Class Library (BCL)**: Fundamental types and system functionality (System.*)
- **Runtime Libraries**: Platform services, I/O, networking, security
- **Application Frameworks**: ASP.NET Core, MAUI, desktop frameworks
- **Specialized Libraries**: Data access, machine learning, cloud services
- **Community Packages**: Open-source and third-party components via NuGet

The library ecosystem serves multiple development paradigms:

- **Cross-platform development**: Consistent APIs across Windows, macOS, Linux
- **Cloud-first architecture**: Built-in support for microservices, containers, serverless
- **Performance optimization**: High-performance collections, spans, async patterns
- **Modern development practices**: Dependency injection, configuration, logging, testing

Key architectural principles:

- **Namespace organization**: Hierarchical naming with System.* as foundation
- **API consistency**: Common patterns across different functional areas
- **Performance focus**: Memory-efficient, allocation-aware designs
- **Extensibility**: Interfaces, abstractions, and dependency injection patterns

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

## Application Framework Libraries

### ASP.NET Core Web Development

```csharp
// Minimal API development
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();
builder.Services.AddScoped<IDataService, DataService>();

var app = builder.Build();
app.MapGet("/api/data", (IDataService service) => service.GetData());
app.MapPost("/api/data", (DataModel model, IDataService service) =>
    service.SaveData(model));
app.Run();
```

### Configuration and Options

```csharp
// Configuration binding and dependency injection
public class AppSettings
{
    public string ConnectionString { get; set; }
    public LoggingSettings Logging { get; set; }
}

// Service registration and configuration
builder.Services.Configure<AppSettings>(
    builder.Configuration.GetSection("AppSettings"));
builder.Services.AddScoped<IBusinessService, BusinessService>();
```

### Logging and Diagnostics

```csharp
// Structured logging with Microsoft.Extensions.Logging
public class BusinessService
{
    private readonly ILogger<BusinessService> _logger;

    public BusinessService(ILogger<BusinessService> logger)
    {
        _logger = logger;
    }

    public async Task ProcessOrderAsync(int orderId)
    {
        _logger.LogInformation("Processing order {OrderId}", orderId);
        try
        {
            await ProcessOrderCore(orderId);
            _logger.LogInformation("Order {OrderId} processed successfully", orderId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to process order {OrderId}", orderId);
            throw;
        }
    }
}
```

## Data Access and Serialization Libraries

### JSON Processing with System.Text.Json

```csharp
// High-performance JSON serialization
public class Product
{
    public int Id { get; set; }
    public string Name { get; set; }
    public decimal Price { get; set; }
}

// Serialization with source generation (recommended)
[JsonSerializable(typeof(Product))]
[JsonSerializable(typeof(List<Product>))]
internal partial class ProductContext : JsonSerializerContext { }

string json = JsonSerializer.Serialize(product, ProductContext.Default.Product);
Product restored = JsonSerializer.Deserialize(json, ProductContext.Default.Product);
```

### Entity Framework Core (Data Access)

```csharp
// Database context and entity configuration
public class ApplicationDbContext : DbContext
{
    public DbSet<Product> Products { get; set; }
    public DbSet<Order> Orders { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Product>()
            .Property(p => p.Price)
            .HasPrecision(18, 2);
    }
}

// Repository pattern with async operations
public class ProductRepository
{
    private readonly ApplicationDbContext _context;

    public async Task<Product> GetByIdAsync(int id)
    {
        return await _context.Products
            .FirstOrDefaultAsync(p => p.Id == id);
    }

    public async Task<List<Product>> GetActiveProductsAsync()
    {
        return await _context.Products
            .Where(p => p.IsActive)
            .ToListAsync();
    }
}
```

## Performance and Memory Management Libraries

### High-Performance Collections and Spans

```csharp
// Memory-efficient string operations with Span<T>
public static bool IsValidEmail(ReadOnlySpan<char> email)
{
    int atIndex = email.IndexOf('@');
    if (atIndex <= 0 || atIndex >= email.Length - 1) return false;

    ReadOnlySpan<char> domain = email.Slice(atIndex + 1);
    return domain.Contains('.');
}

// High-performance collections
using System.Collections.Concurrent;
var cache = new ConcurrentDictionary<string, object>();
var queue = new ConcurrentQueue<WorkItem>();

// Memory pooling for reduced allocations
using System.Buffers;
byte[] buffer = ArrayPool<byte>.Shared.Rent(1024);
try
{
    // Use buffer for operations
}
finally
{
    ArrayPool<byte>.Shared.Return(buffer);
}
```

### System.Threading and Parallelism

```csharp
// Parallel processing with PLINQ
var results = data
    .AsParallel()
    .Where(item => item.IsActive)
    .Select(item => ProcessItem(item))
    .ToList();

// Producer-consumer patterns with channels
using System.Threading.Channels;
var channel = Channel.CreateUnbounded<WorkItem>();
var writer = channel.Writer;
var reader = channel.Reader;

// Background service processing
await foreach (var item in reader.ReadAllAsync(cancellationToken))
{
    await ProcessWorkItemAsync(item);
}
```

## Testing and Quality Assurance Libraries

### Unit Testing with xUnit and MSTest

```csharp
// xUnit test patterns
public class ProductServiceTests
{
    [Fact]
    public async Task GetProductAsync_ValidId_ReturnsProduct()
    {
        // Arrange
        var mockRepo = new Mock<IProductRepository>();
        var service = new ProductService(mockRepo.Object);

        // Act
        var result = await service.GetProductAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
    }

    [Theory]
    [InlineData(0)]
    [InlineData(-1)]
    public async Task GetProductAsync_InvalidId_ThrowsException(int invalidId)
    {
        var service = new ProductService(Mock.Of<IProductRepository>());

        await Assert.ThrowsAsync<ArgumentException>(() =>
            service.GetProductAsync(invalidId));
    }
}
```

### Integration Testing with ASP.NET Core

```csharp
// Integration testing with WebApplicationFactory
public class ProductApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;
    private readonly HttpClient _client;

    public ProductApiTests(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task GetProducts_ReturnsSuccessAndCorrectContentType()
    {
        var response = await _client.GetAsync("/api/products");

        response.EnsureSuccessStatusCode();
        Assert.Equal("application/json",
            response.Content.Headers.ContentType.MediaType);
    }
}
```

## Cloud and Distributed System Libraries

### Azure SDK and Cloud Integration

```csharp
// Azure Service Bus messaging
using Azure.Messaging.ServiceBus;
await using var client = new ServiceBusClient(connectionString);
ServiceBusSender sender = client.CreateSender(queueName);

var message = new ServiceBusMessage(JsonSerializer.Serialize(data));
await sender.SendMessageAsync(message);

// Azure Key Vault integration
using Azure.Security.KeyVault.Secrets;
var client = new SecretClient(vaultUri, new DefaultAzureCredential());
KeyVaultSecret secret = await client.GetSecretAsync("database-connection");
```

### Distributed Caching and State Management

```csharp
// Redis distributed caching
builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = connectionString;
});

public class CacheService
{
    private readonly IDistributedCache _cache;

    public async Task<T> GetOrSetAsync<T>(string key, Func<Task<T>> factory,
        TimeSpan expiration)
    {
        string cached = await _cache.GetStringAsync(key);
        if (cached != null)
        {
            return JsonSerializer.Deserialize<T>(cached);
        }

        T result = await factory();
        await _cache.SetStringAsync(key, JsonSerializer.Serialize(result),
            new DistributedCacheEntryOptions { AbsoluteExpirationRelativeToNow = expiration });

        return result;
    }
}
```

## Library Ecosystem and Package Management

### NuGet Package Discovery and Management

```xml
<!-- Modern package management with Central Package Management -->
<PackageReference Include="Microsoft.Extensions.Hosting" />
<PackageReference Include="Microsoft.Extensions.Http" />
<PackageReference Include="System.Text.Json" />

<!-- Version management in Directory.Packages.props -->
<PackageVersion Include="Microsoft.Extensions.Hosting" Version="8.0.0" />
<PackageVersion Include="System.Text.Json" Version="8.0.0" />
```

### Popular Third-Party Libraries

```csharp
// AutoMapper for object mapping
var config = new MapperConfiguration(cfg => {
    cfg.CreateMap<ProductDto, Product>();
});
IMapper mapper = config.CreateMapper();

// FluentValidation for input validation
public class ProductValidator : AbstractValidator<Product>
{
    public ProductValidator()
    {
        RuleFor(x => x.Name).NotEmpty().MaximumLength(100);
        RuleFor(x => x.Price).GreaterThan(0);
    }
}

// Polly for resilience and fault handling
var retryPolicy = Policy
    .Handle<HttpRequestException>()
    .WaitAndRetryAsync(3, retryAttempt =>
        TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)));

await retryPolicy.ExecuteAsync(async () =>
{
    var response = await httpClient.GetAsync(url);
    response.EnsureSuccessStatusCode();
});
```

## Architecture and Design Patterns

### Dependency Injection and IoC Container

```csharp
// Service lifetime management
builder.Services.AddSingleton<IConfigurationService, ConfigurationService>();
builder.Services.AddScoped<IBusinessService, BusinessService>();
builder.Services.AddTransient<IEmailService, EmailService>();

// Factory patterns and advanced DI
builder.Services.AddScoped<Func<string, IPaymentProcessor>>(provider => key =>
{
    return key switch
    {
        "stripe" => provider.GetService<StripePaymentProcessor>(),
        "paypal" => provider.GetService<PayPalPaymentProcessor>(),
        _ => throw new ArgumentException($"Unknown payment processor: {key}")
    };
});
```

### Repository and Unit of Work Patterns

```csharp
// Generic repository pattern
public interface IRepository<T> where T : class
{
    Task<T> GetByIdAsync(int id);
    Task<IEnumerable<T>> GetAllAsync();
    Task AddAsync(T entity);
    Task UpdateAsync(T entity);
    Task DeleteAsync(int id);
}

// Unit of Work pattern
public interface IUnitOfWork : IDisposable
{
    IRepository<Product> Products { get; }
    IRepository<Order> Orders { get; }
    Task<int> SaveChangesAsync();
}
```

### CQRS and MediatR Integration

```csharp
// Command and Query separation with MediatR
public record CreateProductCommand(string Name, decimal Price) : IRequest<int>;

public class CreateProductHandler : IRequestHandler<CreateProductCommand, int>
{
    private readonly IProductRepository _repository;

    public async Task<int> Handle(CreateProductCommand request,
        CancellationToken cancellationToken)
    {
        var product = new Product
        {
            Name = request.Name,
            Price = request.Price
        };

        await _repository.AddAsync(product);
        return product.Id;
    }
}
```

## Performance and Optimization Considerations

### Memory Management and Allocation Patterns

```csharp
// Avoiding allocations with value types and spans
public readonly struct ProductId : IEquatable<ProductId>
{
    public int Value { get; }
    public ProductId(int value) => Value = value;
    public bool Equals(ProductId other) => Value == other.Value;
    public override bool Equals(object obj) => obj is ProductId id && Equals(id);
    public override int GetHashCode() => Value.GetHashCode();
}

// String interning and optimization
private static readonly ConcurrentDictionary<string, string> _stringCache = new();

public static string InternString(string value)
{
    return _stringCache.GetOrAdd(value, v => v);
}
```

### Async Best Practices and Performance

```csharp
// ConfigureAwait for library code
public async Task<string> ProcessDataAsync(string input)
{
    string result = await TransformDataAsync(input).ConfigureAwait(false);
    await SaveResultAsync(result).ConfigureAwait(false);
    return result;
}

// ValueTask for frequently synchronous operations
public ValueTask<string> GetCachedValueAsync(string key)
{
    if (_cache.TryGetValue(key, out string value))
    {
        return ValueTask.FromResult(value);
    }

    return new ValueTask<string>(LoadValueAsync(key));
}
```

## Security and Cross-Cutting Concerns

### Authentication and Authorization Libraries

```csharp
// JWT authentication with ASP.NET Core
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = configuration["Jwt:Issuer"],
            ValidAudience = configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(configuration["Jwt:Key"]))
        };
    });

// Policy-based authorization
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("AdminOnly", policy =>
        policy.RequireRole("Admin"));
    options.AddPolicy("CanEditProducts", policy =>
        policy.RequireClaim("permissions", "products:write"));
});
```

### Data Protection and Encryption

```csharp
// ASP.NET Core Data Protection
builder.Services.AddDataProtection()
    .PersistKeysToFileSystem(new DirectoryInfo("/keys"))
    .SetApplicationName("MyApplication");

public class SecureService
{
    private readonly IDataProtector _protector;

    public SecureService(IDataProtectionProvider provider)
    {
        _protector = provider.CreateProtector("SecureService");
    }

    public string ProtectData(string data)
    {
        return _protector.Protect(data);
    }

    public string UnprotectData(string protectedData)
    {
        return _protector.Unprotect(protectedData);
    }
}
```

## See Also

- **System.Text.Json**: High-performance JSON serialization and modern data interchange
- **Entity Framework Core**: Object-relational mapping and database access patterns
- **ASP.NET Core**: Web application frameworks and API development
- **Azure SDK**: Cloud-native development and distributed system integration
- **Performance optimization**: Memory management, async patterns, high-throughput scenarios
