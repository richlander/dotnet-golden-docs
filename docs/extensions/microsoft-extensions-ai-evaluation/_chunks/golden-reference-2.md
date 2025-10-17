# Microsoft.Extensions.AI.Evaluation
## Essential Syntax & Examples
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
