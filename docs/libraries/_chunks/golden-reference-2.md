# .NET Libraries
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
