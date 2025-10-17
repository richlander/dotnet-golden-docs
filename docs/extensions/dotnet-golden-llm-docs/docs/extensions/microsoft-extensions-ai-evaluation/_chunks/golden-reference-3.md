# Microsoft.Extensions.AI.Evaluation
## Regression Testing for Model Updates
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

## Automated Quality Gates in CI/CD

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

## Regression Testing for Model Updates

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
