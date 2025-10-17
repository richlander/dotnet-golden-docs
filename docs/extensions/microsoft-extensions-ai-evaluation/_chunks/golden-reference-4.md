# Microsoft.Extensions.AI.Evaluation
## Alternative Syntax Options
### Multi-Evaluator Analysis Pipeline

```csharp
public class ComprehensiveEvaluationPipeline
{
    private readonly List<IEvaluator> _evaluators;
    private readonly IReportingService _reporting;

    public async Task<EvaluationReport> RunComprehensiveEvaluation(
        IEnumerable<TestCase> testCases)
    {
        var results = new List<EvaluationResult>();

        foreach (var testCase in testCases)
        {
            var aiResponse = await GenerateAIResponse(testCase.Input);

            // Run all evaluators in parallel
            var evaluationTasks = _evaluators.Select(evaluator =>
                evaluator.EvaluateAsync(testCase.Input, aiResponse, testCase.Context));

            var evaluationResults = await Task.WhenAll(evaluationTasks);

            results.AddRange(evaluationResults);
        }

        // Generate comprehensive report
        return await _reporting.GenerateReportAsync(results, new ReportOptions
        {
            IncludeDetailedAnalysis = true,
            GroupByEvaluator = true,
            CalculateTrends = true,
            ExportFormat = ReportFormat.Json | ReportFormat.Html
        });
    }
}
```

### Real-time Evaluation with Caching

```csharp
public class ProductionEvaluationService
{
    private readonly IChatClient _chatClient;
    private readonly IEvaluationCache _cache;
    private readonly IEvaluator _qualityEvaluator;

    public async Task<EvaluatedResponse> GetEvaluatedResponseAsync(string userInput)
    {
        // Check cache first
        var cacheKey = GenerateCacheKey(userInput);
        if (await _cache.TryGetAsync(cacheKey) is CachedEvaluation cached)
        {
            return cached.Response;
        }

        // Generate and evaluate response
        var response = await _chatClient.GetResponseAsync(userInput);
        var evaluation = await _qualityEvaluator.EvaluateAsync(userInput, response.Message.Text);

        var evaluatedResponse = new EvaluatedResponse
        {
            Content = response.Message.Text,
            QualityScore = evaluation.Score,
            Reasoning = evaluation.Reasoning,
            Timestamp = DateTime.UtcNow
        };

        // Cache for future requests
        await _cache.SetAsync(cacheKey, new CachedEvaluation
        {
            Response = evaluatedResponse,
            ExpiresAt = DateTime.UtcNow.AddHours(24)
        });

        return evaluatedResponse;
    }
}
```

## Alternative Syntax Options

Microsoft.Extensions.AI.Evaluation provides multiple approaches for different evaluation scenarios:

### Fluent Builder vs Direct Instantiation

```csharp
// Fluent builder approach (recommended)
var evaluation = new EvaluationBuilder()
    .AddQualityEvaluators(chatClient)
    .AddSafetyEvaluators(azureCredential, endpoint)
    .AddNLPEvaluators()
    .AddResponseCaching()
    .Build();

// Direct instantiation (more control)
var relevanceEvaluator = new RelevanceEvaluator(chatClient);
var safetyEvaluator = new ContentHarmEvaluator(endpoint, credential);
var bleuEvaluator = new BleuEvaluator();
```
