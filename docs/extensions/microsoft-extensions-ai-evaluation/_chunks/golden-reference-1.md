# Microsoft.Extensions.AI.Evaluation
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
