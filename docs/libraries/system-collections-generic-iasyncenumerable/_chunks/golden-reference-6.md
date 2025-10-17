# IAsyncEnumerable&lt;T&gt;
## Common Scenarios
### Real-Time Data Processing

**When to use**: Processing live data feeds, event streams, or message queues.

```csharp
public async IAsyncEnumerable<StockPrice> StreamStockPricesAsync(
    string symbol,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    using var webSocket = new ClientWebSocket();
    await webSocket.ConnectAsync(new Uri($"wss://api.example.com/stocks/{symbol}"), cancellationToken);
    
    var buffer = new byte[4096];
    
    while (!cancellationToken.IsCancellationRequested)
    {
        var result = await webSocket.ReceiveAsync(buffer, cancellationToken);
        
        if (result.MessageType == WebSocketMessageType.Close)
            break;
        
        var price = ParseStockPrice(buffer, result.Count);
        yield return price;
    }
}

// Usage with filtering
await foreach (var price in StreamStockPricesAsync("MSFT")
    .Where(p => p.Change > 0))
{
    Console.WriteLine($"${price.Value} (+{price.Change})");
}
```

**Considerations**: WebSocket stays open during iteration. Implement proper cleanup and error handling.

### Async Data Transformation Pipeline

**When to use**: Building multi-stage async processing pipelines.

```csharp
public async IAsyncEnumerable<EnrichedOrder> ProcessOrdersAsync(
    IAsyncEnumerable<Order> orders,
    [EnumeratorCancellation] CancellationToken cancellationToken = default)
{
    await foreach (var order in orders.WithCancellation(cancellationToken))
    {
        // Stage 1: Validate
        if (!await ValidateOrderAsync(order))
            continue;
        
        // Stage 2: Enrich with customer data
        var customer = await FetchCustomerAsync(order.CustomerId);
        
        // Stage 3: Calculate pricing
        var pricing = await CalculatePricingAsync(order, customer);
        
        // Stage 4: Apply discounts
        var discounts = await GetApplicableDiscountsAsync(customer);
        
        yield return new EnrichedOrder(order, customer, pricing, discounts);
    }
}

// Chain multiple pipelines
IAsyncEnumerable<Order> rawOrders = FetchOrdersAsync();
IAsyncEnumerable<EnrichedOrder> enriched = ProcessOrdersAsync(rawOrders);
IAsyncEnumerable<EnrichedOrder> filtered = enriched.Where(o => o.Total > 100);

await foreach (var order in filtered)
{
    await FulfillOrderAsync(order);
}
```

**Considerations**: Each stage can perform async operations. Consider parallel processing with `Channels` for better throughput.
