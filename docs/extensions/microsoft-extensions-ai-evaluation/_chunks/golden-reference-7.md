# Microsoft.Extensions.AI.Evaluation
## Limitations and Considerations
### Preview Technology Constraints

Microsoft.Extensions.AI.Evaluation is currently in preview with potential API changes:

```csharp
// Pin to specific preview versions for stability
<PackageReference Include="Microsoft.Extensions.AI.Evaluation" Version="9.8.0" />
<PackageReference Include="Microsoft.Extensions.AI.Evaluation.Quality" Version="9.6.0" />
```

### Azure Dependency for Safety Evaluators

Safety evaluators require Azure AI Foundry service access:

```csharp
// Fallback strategy when Azure service unavailable
public async Task<EvaluationResult> EvaluateWithFallbackAsync(string input, string output)
{
    try
    {
        return await _azureSafetyEvaluator.EvaluateAsync(input, output);
    }
    catch (Azure.RequestFailedException ex)
    {
        _logger.LogWarning(ex, "Azure evaluation service unavailable, using local fallback");
        return await _localSafetyEvaluator.EvaluateAsync(input, output);
    }
}
```

### Performance Impact of LLM-based Evaluators

Quality evaluators that use LLMs add latency and cost:

```csharp
// Optimize for production with selective evaluation
public class ProductionEvaluationStrategy
{
    public async Task<EvaluationResult> EvaluateForProductionAsync(
        string input, string output, EvaluationPriority priority)
    {
        return priority switch
        {
            EvaluationPriority.Critical => await FullEvaluationAsync(input, output),
            EvaluationPriority.Standard => await QualityOnlyEvaluationAsync(input, output),
            EvaluationPriority.Fast => await NLPOnlyEvaluationAsync(input, output),
            _ => await MinimalEvaluationAsync(input, output)
        };
    }
}
```

### Evaluation Data Management

Large-scale evaluations generate significant data requiring proper management:

```csharp
// Data lifecycle management
public class EvaluationDataManager
{
    public async Task ManageEvaluationDataAsync()
    {
        // Archive old evaluation results
        await ArchiveOldEvaluationsAsync(TimeSpan.FromDays(90));

        // Aggregate data for trend analysis
        await AggregateEvaluationTrendsAsync();

        // Clean up temporary evaluation artifacts
        await CleanupTemporaryDataAsync();
    }
}
```

### Cost Considerations

Evaluation operations, especially LLM-based ones, have associated costs:

```csharp
// Cost-aware evaluation strategy
public class CostManagedEvaluationService
{
    private readonly ICostTracker _costTracker;

    public async Task<EvaluationResult> EvaluateWithBudgetAsync(
        string input, string output, decimal budgetLimit)
    {
        var estimatedCost = EstimateEvaluationCost(input, output);

        if (await _costTracker.WouldExceedBudgetAsync(estimatedCost, budgetLimit))
        {
            // Use cheaper NLP-based evaluation instead
            return await _nlpEvaluator.EvaluateAsync(input, output);
        }

        return await _llmEvaluator.EvaluateAsync(input, output);
    }
}
```