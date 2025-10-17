# Header Analysis

Generated from: `golden-reference.md`
Total headers: 53

## Headers by Level

- **H1**: 1 headers (multiplier: 1.5x)
- **H2**: 8 headers (multiplier: 1.25x)
- **H3**: 44 headers (multiplier: 1.1x)

## All Headers

| Level | Text | Multiplier |
|-------|------|------------|
| H1 | Async and Await | 1.5x |
| H2 | Overview | 1.25x |
| H3 | Key Advantages | 1.1x |
| H3 | Main Approaches | 1.1x |
| H3 | When to Use | 1.1x |
| H2 | Essential Syntax & Examples | 1.25x |
| H3 | Basic Async Method | 1.1x |
| H3 | Async Method Returning Task | 1.1x |
| H3 | Multiple Sequential Async Operations | 1.1x |
| H3 | Concurrent Async Operations | 1.1x |
| H3 | Error Handling | 1.1x |
| H3 | Cancellation Support | 1.1x |
| H3 | ConfigureAwait | 1.1x |
| H3 | Async Void (Event Handlers Only) | 1.1x |
| H2 | Relationships & Integration | 1.25x |
| H3 | Task and Task&lt;T&gt; | 1.1x |
| H3 | IAsyncEnumerable Integration | 1.1x |
| H3 | JSON Serialization with System.Text.Json | 1.1x |
| H3 | Entity Framework Core Integration | 1.1x |
| H3 | ASP.NET Core Integration | 1.1x |
| H3 | File I/O Integration | 1.1x |
| H3 | HttpClient Integration | 1.1x |
| H2 | Common Scenarios | 1.25x |
| H3 | Web API Request with Error Handling | 1.1x |
| H3 | Parallel Async Operations | 1.1x |
| H3 | Retry Logic with Exponential Backoff | 1.1x |
| H3 | Async Initialization Pattern | 1.1x |
| H3 | Processing Items in Batches | 1.1x |
| H3 | Timeout Pattern | 1.1x |
| H3 | Async Lock Pattern | 1.1x |
| H2 | Alternative Syntax Options | 1.25x |
| H3 | Task.Run for CPU-Bound Work | 1.1x |
| H3 | ValueTask for High-Performance Scenarios | 1.1x |
| H3 | Synchronous Wrapper (Avoid in Most Cases) | 1.1x |
| H3 | Task.FromResult for Sync Returns | 1.1x |
| H2 | Best Practices | 1.25x |
| H3 | Use Async All the Way | 1.1x |
| H3 | Always Use CancellationToken | 1.1x |
| H3 | Avoid Async Void | 1.1x |
| H3 | Use ConfigureAwait(false) in Libraries | 1.1x |
| H3 | Don't Block on Async Code | 1.1x |
| H3 | Handle Exceptions Appropriately | 1.1x |
| H3 | Avoid Capturing Too Much Context | 1.1x |
| H2 | Limitations and Considerations | 1.25x |
| H3 | Async Methods Have Overhead | 1.1x |
| H3 | Async Void Swallows Exceptions | 1.1x |
| H3 | Blocking Async Code Can Deadlock | 1.1x |
| H3 | Task.WhenAll Doesn't Short-Circuit | 1.1x |
| H3 | Can't Use Await in Lock Statements | 1.1x |
| H3 | Async Doesn't Make Code Faster | 1.1x |
| H3 | State Machine Allocation | 1.1x |
| H3 | Exceptions in Task.WhenAll | 1.1x |
| H2 | See Also | 1.25x |
