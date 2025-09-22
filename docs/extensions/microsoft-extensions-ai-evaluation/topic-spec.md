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

- AI evaluation
- AI quality assessment
- AI safety evaluation
- content safety
- evaluation metrics
- AI testing
- response evaluation
- natural language processing
- evaluation reporting

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