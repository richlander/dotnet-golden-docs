# .NET Libraries
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
