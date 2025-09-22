# Microsoft.Extensions.AI.Evaluation - Validation Document

## Validation Criteria

This document outlines the validation criteria for Microsoft.Extensions.AI.Evaluation content to ensure accuracy, completeness, and alignment with official documentation.

### Technical Accuracy

- [ ] Package references are correct: All evaluation package names, versions, and dependencies align with official releases
- [ ] API signatures match: All IEvaluator implementations, evaluation methods, and result types are accurate
- [ ] Azure integration details: Azure AI Foundry endpoint configurations and authentication methods are correct
- [ ] Code examples compile: All code snippets compile against the specified .NET version and package versions
- [ ] Evaluation metrics definitions: Quality, safety, and NLP metric descriptions match official documentation

### Content Completeness

- [ ] Core evaluation types covered: Quality, safety, and NLP evaluators are thoroughly documented
- [ ] Reporting framework: Caching, storage, and report generation capabilities are explained
- [ ] Azure integration: Azure AI Foundry safety evaluator setup and configuration
- [ ] Custom evaluator patterns: IEvaluator implementation guidance and examples
- [ ] Performance considerations: Caching, batching, and optimization strategies

### Documentation Alignment

- [ ] Consistent with official docs: Content aligns with learn.microsoft.com AI evaluation documentation
- [ ] Package guidance matches: Core vs specialized package usage recommendations are consistent
- [ ] API surface accuracy: All public types, interfaces, and methods are correctly represented
- [ ] Configuration patterns: DI registration and options configuration match official examples
- [ ] Best practices alignment: Recommendations align with AI safety and quality standards

### Example Quality

- [ ] Realistic scenarios: Examples demonstrate practical AI evaluation workflows
- [ ] Progressive complexity: Examples build from basic to advanced scenarios logically
- [ ] Error handling: Examples include appropriate error handling and fallback strategies
- [ ] Performance awareness: Examples demonstrate efficient evaluation patterns
- [ ] Security considerations: Examples follow security best practices for AI evaluation

### Version Compatibility

- [ ] Target framework accuracy: .NET version requirements are correctly specified
- [ ] Package version consistency: All referenced package versions are compatible and current
- [ ] API availability: Features are correctly attributed to package versions where they were introduced
- [ ] Preview considerations: Preview/experimental features are clearly marked as such

## Validation Checklist

### Code Compilation Tests

- [ ] Basic quality evaluator usage examples compile
- [ ] Safety evaluator with Azure integration examples compile
- [ ] NLP evaluator examples compile with correct metric calculations
- [ ] Custom evaluator implementation examples compile with proper IEvaluator inheritance
- [ ] Reporting and caching examples compile with correct service registration
- [ ] Batch evaluation examples compile with proper async patterns

### Functional Validation

- [ ] Package installation commands work with specified versions
- [ ] DI registration examples work with Microsoft.Extensions.DependencyInjection
- [ ] Azure AI Foundry integration examples work with proper credentials
- [ ] Evaluation result serialization and caching work correctly
- [ ] Report generation examples produce valid output formats
- [ ] Command-line tool examples work with actual tool installation

### Content Cross-References

- [ ] Links to AI samples repository are valid and current
- [ ] Cross-references to Microsoft.Extensions.AI documentation are accurate
- [ ] Azure AI Foundry documentation links are current
- [ ] NuGet package references link to correct package pages
- [ ] API documentation references are valid

### AI Evaluation Accuracy

- [ ] Quality evaluator descriptions match actual behavior
- [ ] Safety evaluator capabilities align with Azure AI Foundry service
- [ ] NLP metric calculations are mathematically correct
- [ ] Evaluation scoring ranges and interpretations are accurate
- [ ] Performance characteristics are realistic and measured

## Update Requirements

### When to Update

- New releases of Microsoft.Extensions.AI.Evaluation packages
- Changes to evaluation APIs or scoring algorithms
- Updates to Azure AI Foundry service capabilities
- New evaluator types or safety categories
- Changes to reporting or caching functionality

### Update Process

1. Review official sources: Check learn.microsoft.com, NuGet packages, and GitHub repository for changes
2. Validate examples: Ensure all code examples still compile and function correctly
3. Update version references: Modify package versions and .NET framework targets as needed
4. Test evaluation workflows: Verify end-to-end evaluation scenarios still work
5. Check Azure integration: Validate Azure AI Foundry service integration remains functional

### Quality Gates

- All validation criteria must pass before content updates
- Code examples must be tested against latest package versions
- Content must align with current official documentation
- Breaking changes must be clearly documented with migration guidance
- Performance claims must be verified with actual measurements

## Known Limitations

### Preview Technology

- API surface may change between preview releases
- Not recommended for production use without careful consideration
- Limited long-term support guarantees during preview period

### Service Dependencies

- Azure AI Foundry required for advanced safety evaluations
- Some evaluators require additional AI service calls for LLM-based evaluation
- Network connectivity required for cloud-based evaluation services

### Testing Constraints

- Full end-to-end testing requires Azure credentials and service access
- Some evaluation scenarios require AI model responses for realistic testing
- Performance testing requires representative datasets and infrastructure
- Cost implications for extensive LLM-based evaluation testing