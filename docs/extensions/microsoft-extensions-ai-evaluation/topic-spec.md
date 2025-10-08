# Microsoft.Extensions.AI.Evaluation - Topic Specification

## Feature Description

Microsoft.Extensions.AI.Evaluation is a comprehensive set of .NET libraries designed to support building evaluation processes for AI software quality and safety. It provides abstractions, evaluators, and reporting tools to assess AI responses across multiple dimensions including quality metrics (relevance, fluency, coherence), safety evaluations (harmful content detection), and NLP metrics (BLEU, F1 scores).

## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://www.nuget.org/packages/Microsoft.Extensions.AI.Evaluation | rendered | Core evaluation package | 2025-09-21 |
| https://github.com/dotnet/ai-samples/tree/main/src/microsoft-extensions-ai-evaluation | rendered | Comprehensive API usage examples | 2025-09-21 |

## Primary Sources

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/extensions | src/Libraries/Microsoft.Extensions.AI.Evaluation/README.md | Main evaluation library documentation | 2025-09-21 |
| dotnet/ai-samples | src/microsoft-extensions-ai-evaluation/api/ | API usage examples and tutorials | 2025-09-21 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |

## Metadata

| Property | Value |
| --- | --- |
| Name | Microsoft.Extensions.AI.Evaluation |
| ID | microsoft-extensions-ai-evaluation |
| Category | Extensions |
| Namespace | Microsoft.Extensions.AI.Evaluation |
| Description | Comprehensive set of libraries for evaluating AI software quality and safety through metrics, safety checks, and reporting tools. |
| Complexity | 0.8 |
| Audience | AI developers, ML engineers, quality assurance teams, AI safety specialists |
| Priority | 1 (High priority - essential for production AI) |
| Version | 9.0 |
| Year | 2024 |

## Hashes

| Name | Kind | Fingerprint |
|------|------|-------------|
| overview | simhash | 12997269984866959672 |
| technical | simhash | 12992239188741857660 |

## Relationships

| Type | Target |
| --- | --- |
| Enables | AI quality assurance, safety evaluation, automated testing, compliance reporting |
| Neutral | specific AI providers, evaluation backends |
| Conflicts with | none |
| Alternative to | custom evaluation frameworks, manual AI testing |
| Synergistic with | Microsoft.Extensions.AI, Azure AI Foundry, testing frameworks |
| Prerequisite | .NET 9+, Microsoft.Extensions.AI.Abstractions |

## Keywords

| Keyword | Score |
|---------|-------|
| evaluation | 30.00 |
| ai | 22.00 |
| quality | 12.00 |
| microsoft.extensions.ai.evaluation | 5.00 |
| safety | 7.00 |
| safety evaluators | 4.00 |
| azure | 6.00 |
| evaluators | 6.00 |
| metrics | 6.00 |
| extensions | 7.00 |
| microsoft | 7.00 |
| nlp | 5.00 |

## APIs

| API | Type | Count |
|-----|------|-------|
| EvaluateAsync | method | 17 |
| Microsoft.Extensions.AI.Evaluation | type | 8 |
| Microsoft.Extensions | namespace | 6 |
| Microsoft.Extensions.AI | namespace | 6 |
| Console.WriteLine | method | 5 |
| GetResponseAsync | method | 5 |
| AddEvaluation | method | 3 |
| Assert.That | method | 3 |
| ContentHarmEvaluator | method | 3 |
| RelevanceEvaluator | method | 3 |

## Similarity Scores

| Category | Neighbor | Similarity |
|----------|----------|------------|
| extensions | extensions/microsoft-extensions-ai | 0.8279 |
| dotnet | dotnet | 0.6825 |
| libraries | libraries | 0.6506 |
| libraries | libraries/dotnet-10-library-improvements | 0.6445 |
| extensions | extensions/microsoft-extensions-http-resilience | 0.6424 |
| libraries | libraries/system-text-json | 0.6286 |
| csharp | csharp/csharp-14-features | 0.6285 |
| cli | cli/native-aot | 0.6161 |
| libraries | libraries/system-text-json-source-generation | 0.6149 |
| cli | cli | 0.6142 |
| cli | cli/file-based-apps | 0.6092 |
| cli | cli/publishing-and-deployment | 0.5921 |

## Critical limitations

- Preview/early stage technology with potential API changes
- Some evaluators require Azure AI Foundry service for advanced safety checks
- Quality evaluators may require additional AI service calls for LLM-based evaluation
- Performance depends on underlying evaluation services and models
- Safety evaluations have specific content policy constraints

## Key scenarios to cover

1. Basic quality evaluation setup and configuration
2. Safety evaluation for harmful content detection
3. NLP metric evaluation (BLEU, F1 scores) for language tasks
4. Custom evaluator implementation and registration
5. Evaluation reporting and result storage
6. Azure Storage integration for evaluation data
7. Command-line tool usage for evaluation management
8. Batch evaluation scenarios and performance optimization
9. Integration with CI/CD pipelines for automated testing
10. Compliance reporting and audit trail generation

## Anti-patterns to avoid

- Running evaluations in production request paths without caching
- Ignoring safety evaluation results in content generation
- Not configuring proper evaluation thresholds for quality gates
- Missing evaluation data persistence for audit and compliance
- Evaluating without proper test data management and versioning
