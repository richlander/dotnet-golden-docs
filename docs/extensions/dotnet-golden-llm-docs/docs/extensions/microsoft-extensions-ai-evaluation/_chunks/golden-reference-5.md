# Microsoft.Extensions.AI.Evaluation
## Best Practices
### Synchronous vs Asynchronous Evaluation

```csharp
// Asynchronous evaluation (recommended for I/O operations)
var result = await evaluator.EvaluateAsync(input, output, context);

// Synchronous evaluation (for non-I/O based evaluators)
var nlpResult = nlpEvaluator.Evaluate(output, expectedOutputs);
```

### Individual vs Batch Processing

```csharp
// Individual evaluation
var singleResult = await evaluator.EvaluateAsync(input, output);

// Batch evaluation (more efficient)
var batchResults = await evaluator.EvaluateBatchAsync(testCases);
```

### Configuration-driven vs Code-based Setup

```csharp
// Configuration-driven approach
services.Configure<EvaluationOptions>(configuration.GetSection("AIEvaluation"));
services.AddEvaluation();

// Code-based configuration
services.AddEvaluation(options =>
{
    options.QualityThreshold = 0.8;
    options.SafetyThreshold = 0.2;
    options.EnableCaching = true;
    options.CacheExpiration = TimeSpan.FromHours(24);
});
```

## Best Practices

### Evaluation Strategy Planning

Design comprehensive evaluation strategies that cover quality, safety, and performance dimensions:

```csharp
public class EvaluationStrategy
{
    public static EvaluationPlan CreateProductionPlan()
    {
        return new EvaluationPlan
        {
            QualityEvaluators = new[]
            {
                nameof(RelevanceEvaluator),
                nameof(TruthEvaluator),
                nameof(CompletenessEvaluator)
            },
            SafetyEvaluators = new[]
            {
                nameof(ContentHarmEvaluator),
                nameof(ProtectedMaterialEvaluator)
            },
            Thresholds = new EvaluationThresholds
            {
                MinimumQualityScore = 0.75,
                MaximumSafetyRisk = 0.25,
                RequiredEvaluatorConsensus = 0.8
            },
            ReportingLevel = ReportingLevel.Detailed
        };
    }
}
```

### Performance Optimization

Optimize evaluation performance through caching and parallel processing:

```csharp
public class OptimizedEvaluationService
{
    private readonly IMemoryCache _memoryCache;
    private readonly IDistributedCache _distributedCache;

    public async Task<EvaluationResult> EvaluateWithCachingAsync(
        string input, string output, TimeSpan? cacheExpiration = null)
    {
        var cacheKey = $"eval:{HashHelper.ComputeHash(input + output)}";

        // Try memory cache first (fastest)
        if (_memoryCache.TryGetValue(cacheKey, out EvaluationResult cached))
            return cached;

        // Try distributed cache
        var distributedResult = await _distributedCache.GetAsync(cacheKey);
        if (distributedResult != null)
        {
            var result = JsonSerializer.Deserialize<EvaluationResult>(distributedResult);
            _memoryCache.Set(cacheKey, result, TimeSpan.FromMinutes(5));
            return result;
        }

        // Perform evaluation and cache results
        var evaluation = await PerformEvaluationAsync(input, output);

        var expiration = cacheExpiration ?? TimeSpan.FromHours(1);
        _memoryCache.Set(cacheKey, evaluation, TimeSpan.FromMinutes(5));
        await _distributedCache.SetAsync(cacheKey,
            JsonSerializer.SerializeToUtf8Bytes(evaluation),
            new DistributedCacheEntryOptions { AbsoluteExpirationRelativeToNow = expiration });

        return evaluation;
    }
}
```
