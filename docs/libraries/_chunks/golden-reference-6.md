# .NET Libraries
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
