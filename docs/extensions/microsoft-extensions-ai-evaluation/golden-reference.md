# Microsoft.Extensions.AI.Evaluation - Golden Reference

## Overview

Microsoft.Extensions.AI.Evaluation provides a comprehensive set of .NET libraries designed to evaluate the quality and safety of AI-generated responses in intelligent applications. The library enables developers to assess AI model performance across multiple dimensions including quality metrics, safety checks, and natural language processing evaluations, ensuring reliable and trustworthy AI applications.

What it is: A modular evaluation framework that simplifies the process of measuring AI response quality through built-in evaluators for relevance, truthfulness, coherence, safety, and NLP metrics. Built on top of Microsoft.Extensions.AI abstractions, it provides both traditional NLP-based evaluators and modern LLM-based quality assessments.

Core capabilities:

- Quality evaluation: LLM-based evaluators for relevance, truth, completeness, fluency, coherence, and groundedness
- Safety assessment: Azure AI Foundry-powered evaluators for harmful content detection and compliance
- NLP metrics: Traditional text comparison using BLEU, GLEU, and F1 scoring algorithms
- Response caching: Persistent storage of AI responses and evaluation results for analysis
- Reporting framework: Comprehensive evaluation reports and audit trails
- Extensible architecture: Custom evaluator implementation through IEvaluator interface

When to use:

- Building production AI applications requiring quality assurance
- Implementing automated testing pipelines for AI models
- Ensuring content safety and compliance in AI-generated responses
- Measuring model performance across different evaluation metrics
- Creating audit trails for AI system behavior and safety
- Developing CI/CD workflows that include AI evaluation gates

Key benefits:

- Automated quality assurance: Systematic evaluation of AI responses without manual review
- Multi-dimensional assessment: Quality, safety, and NLP metrics in a unified framework
- Production-ready: Caching and reporting capabilities for enterprise deployments
- Extensible design: Custom evaluators for domain-specific requirements
- Azure integration: Leverage Azure AI Foundry for advanced safety evaluations
- Developer productivity: Reduces complexity of implementing evaluation workflows

## Relationships & Integration

Ecosystem positioning: Microsoft.Extensions.AI.Evaluation sits at the intersection of AI development and quality assurance, providing the evaluation layer necessary for reliable production AI applications built with Microsoft.Extensions.AI.

Package architecture: The evaluation framework follows a modular design with separate packages for core abstractions, quality evaluators, safety evaluators, NLP metrics, reporting, and Azure integration, allowing developers to adopt only needed functionality.

Azure AI Foundry integration: Safety evaluators leverage Azure AI Foundry's specialized models for detecting harmful content, protected material, and security vulnerabilities with enterprise-grade accuracy and compliance support.

CI/CD integration: Designed to integrate with continuous integration pipelines, enabling automated quality gates and regression testing for AI model deployments with configurable thresholds and reporting.

Testing framework alignment: Works seamlessly with .NET testing frameworks, allowing evaluation assertions to be incorporated into unit tests, integration tests, and automated quality assurance workflows.

## Essential Syntax & Examples

### Basic Quality Evaluation Setup

```csharp
using Microsoft.Extensions.AI.Evaluation;
using Microsoft.Extensions.AI.Evaluation.Quality;

// Register evaluation services
services.AddSingleton<IChatClient>(chatClient);
services.AddEvaluation();

// Create quality evaluators
var relevanceEvaluator = new RelevanceEvaluator(chatClient);
var truthEvaluator = new TruthEvaluator(chatClient);

// Evaluate AI response
var evaluation = await relevanceEvaluator.EvaluateAsync(
    input: "What is the capital of France?",
    output: "The capital of France is Paris.",
    context: "Geography question about European capitals"
);

Console.WriteLine($"Relevance Score: {evaluation.Score}");
Console.WriteLine($"Reasoning: {evaluation.Reasoning}");
```

### Safety Content Evaluation

```csharp
using Microsoft.Extensions.AI.Evaluation.Safety;

// Configure Azure AI Foundry evaluator
var safetyEvaluator = new ContentHarmEvaluator(
    endpoint: "https://your-ai-foundry-endpoint.com",
    credential: new DefaultAzureCredential()
);

// Evaluate content for harmful material
var safetyResult = await safetyEvaluator.EvaluateAsync(
    input: "User question about sensitive topic",
    output: "AI response to evaluate"
);

if (safetyResult.Score > 0.7) // High safety risk
{
    // Handle unsafe content
    Console.WriteLine($"Content flagged: {safetyResult.Reasoning}");
}
```

### NLP Metric Evaluation

```csharp
using Microsoft.Extensions.AI.Evaluation.NLP;

// Traditional NLP-based evaluation
var bleuEvaluator = new BleuEvaluator();

var nlpResult = await bleuEvaluator.EvaluateAsync(
    output: "The quick brown fox jumps over the lazy dog",
    expectedOutputs: new[]
    {
        "A fast brown fox leaps over a sleeping dog",
        "The swift brown fox hops over the tired dog"
    }
);

Console.WriteLine($"BLEU Score: {nlpResult.Score}");
```

### Batch Evaluation with Reporting

```csharp
using Microsoft.Extensions.AI.Evaluation.Reporting;

// Configure evaluation with caching and reporting
var evaluationBuilder = new EvaluationBuilder()
    .AddQualityEvaluators(chatClient)
    .AddSafetyEvaluators(azureCredential, endpoint)
    .AddResponseCaching()
    .AddReporting();

var evaluation = evaluationBuilder.Build();

// Evaluate multiple test cases
var testCases = new[]
{
    new { Input = "Question 1", Expected = "Expected answer 1" },
    new { Input = "Question 2", Expected = "Expected answer 2" }
};

foreach (var testCase in testCases)
{
    var response = await chatClient.GetResponseAsync(testCase.Input);

    await evaluation.EvaluateAsync(
        input: testCase.Input,
        output: response.Message.Text,
        expectedOutput: testCase.Expected
    );
}

// Generate comprehensive report
var report = await evaluation.GenerateReportAsync();
Console.WriteLine($"Overall Quality Score: {report.OverallScore}");
```

### Custom Evaluator Implementation

```csharp
using Microsoft.Extensions.AI.Evaluation;

public class CustomDomainEvaluator : IEvaluator<string, string>
{
    public async Task<EvaluationResult> EvaluateAsync(
        string input,
        string output,
        EvaluationContext? context = null,
        CancellationToken cancellationToken = default)
    {
        // Custom evaluation logic
        var score = CalculateDomainSpecificScore(input, output);
        var reasoning = GenerateReasoningText(input, output, score);

        return new EvaluationResult
        {
            Score = score,
            Reasoning = reasoning,
            Metadata = new Dictionary<string, object>
            {
                ["evaluator"] = "CustomDomain",
                ["timestamp"] = DateTime.UtcNow
            }
        };
    }

    private double CalculateDomainSpecificScore(string input, string output)
    {
        // Domain-specific scoring logic
        return 0.85; // Example score
    }

    private string GenerateReasoningText(string input, string output, double score)
    {
        return $"Domain evaluation based on specific criteria yielded score: {score}";
    }
}
```

## Common Scenarios

### Automated Quality Gates in CI/CD

```csharp
// Integration test with evaluation assertions
[Test]
public async Task AI_Response_Quality_MeetsStandards()
{
    var testPrompts = LoadTestDataset();
    var qualityEvaluator = new RelevanceEvaluator(chatClient);
    var safetyEvaluator = new ContentHarmEvaluator(endpoint, credential);

    foreach (var prompt in testPrompts)
    {
        var response = await chatClient.GetResponseAsync(prompt.Input);

        // Quality assertion
        var qualityResult = await qualityEvaluator.EvaluateAsync(
            prompt.Input, response.Message.Text, prompt.Context);
        Assert.That(qualityResult.Score, Is.GreaterThan(0.7),
            $"Quality below threshold: {qualityResult.Reasoning}");

        // Safety assertion
        var safetyResult = await safetyEvaluator.EvaluateAsync(
            prompt.Input, response.Message.Text);
        Assert.That(safetyResult.Score, Is.LessThan(0.3),
            $"Safety risk detected: {safetyResult.Reasoning}");
    }
}
```

### Regression Testing for Model Updates

```csharp
public class ModelRegressionTests
{
    private readonly IEvaluationService _evaluation;
    private readonly IChatClient _currentModel;
    private readonly IChatClient _newModel;

    public async Task CompareModelPerformance()
    {
        var testCases = LoadRegressionTestSuite();
        var results = new List<ComparisonResult>();

        foreach (var testCase in testCases)
        {
            var currentResponse = await _currentModel.GetResponseAsync(testCase.Input);
            var newResponse = await _newModel.GetResponseAsync(testCase.Input);

            var currentEval = await _evaluation.EvaluateAsync(
                testCase.Input, currentResponse.Message.Text, testCase.ExpectedOutput);
            var newEval = await _evaluation.EvaluateAsync(
                testCase.Input, newResponse.Message.Text, testCase.ExpectedOutput);

            results.Add(new ComparisonResult
            {
                TestCase = testCase,
                CurrentScore = currentEval.Score,
                NewScore = newEval.Score,
                Improvement = newEval.Score - currentEval.Score
            });
        }

        var avgImprovement = results.Average(r => r.Improvement);
        Assert.That(avgImprovement, Is.GreaterThanOrEqualTo(0),
            "New model shows performance regression");
    }
}
```

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

### Error Handling and Resilience

Implement robust error handling for evaluation failures:

```csharp
public class ResilientEvaluationService
{
    private readonly IRetryPolicy _retryPolicy;
    private readonly ILogger<ResilientEvaluationService> _logger;

    public async Task<EvaluationResult> EvaluateWithResilienceAsync(
        string input, string output, EvaluationContext context)
    {
        return await _retryPolicy.ExecuteAsync(async () =>
        {
            try
            {
                return await PerformEvaluationAsync(input, output, context);
            }
            catch (EvaluationServiceException ex) when (IsRetriableError(ex))
            {
                _logger.LogWarning(ex, "Retriable evaluation error, will retry");
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Non-retriable evaluation error");

                // Return fallback evaluation result
                return new EvaluationResult
                {
                    Score = 0.5, // Neutral score
                    Reasoning = "Evaluation failed, using fallback score",
                    Metadata = new Dictionary<string, object>
                    {
                        ["error"] = ex.Message,
                        ["fallback"] = true
                    }
                };
            }
        });
    }
}
```

### Configuration Management

Use strongly-typed configuration for evaluation settings:

```csharp
public class EvaluationConfiguration
{
    public QualitySettings Quality { get; set; } = new();
    public SafetySettings Safety { get; set; } = new();
    public CachingSettings Caching { get; set; } = new();
    public ReportingSettings Reporting { get; set; } = new();
}

public class QualitySettings
{
    public double RelevanceThreshold { get; set; } = 0.7;
    public double TruthThreshold { get; set; } = 0.8;
    public double CompletenessThreshold { get; set; } = 0.6;
    public bool EnableParallelEvaluation { get; set; } = true;
}

// Usage
services.Configure<EvaluationConfiguration>(configuration.GetSection("AIEvaluation"));
services.AddSingleton<IEvaluationService, ConfiguredEvaluationService>();
```

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