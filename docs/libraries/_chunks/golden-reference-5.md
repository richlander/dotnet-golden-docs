# .NET Libraries
## Architecture and Design Patterns
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
