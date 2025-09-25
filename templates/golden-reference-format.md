# Golden Reference Format Guide

This document defines the format and quality standards for golden reference documents across all topics in the documentation set. Golden references serve as comprehensive validation baselines and primary source material for content generation.

## Purpose

Golden reference documents serve multiple critical functions:

- Validation baseline: Ground truth for evaluating generated content quality
- Content generation source: Primary material for creating output formats
- Comprehensive coverage: Complete reference including edge cases and integrations
- Authority establishment: Definitive technical accuracy standard

## Format Structure

### Document Title

The H1 will be structured as: `# {Feature Name} - Golden Reference`

### Required Sections

#### Overview

Conceptual foundation providing context and orientation:

- What it is: Clear definition and technical positioning
- Key advantages: Primary benefits and value propositions (3-6 bullet points)
- Main approaches: Different usage patterns or modes (if applicable)
- When to use: Primary scenarios and decision criteria

#### Essential Syntax & Examples

Core technical content with working code:

- Basic operations: Fundamental usage patterns with minimal examples
- Configuration: Key options and customization approaches
- Advanced patterns: Important but less common usage scenarios
- Version-specific features: New capabilities in recent versions

#### Relationships & Integration

Ecosystem connections and context:

- Framework integration: How it works with ASP.NET Core, Entity Framework, etc.
- Migration considerations: Moving from alternative approaches
- Compatibility requirements: Version and platform constraints
- Performance characteristics: Key optimization considerations

#### Common Scenarios

Real-world usage patterns organized by complexity:

- Scenario title: Descriptive name for the use case
- When to use: Specific conditions that make this pattern appropriate
- Implementation: Working code example with explanation
- Considerations: Important details, limitations, or alternatives

#### Alternative Syntax Options

Showcase equivalent approaches and migration patterns:

- Traditional approaches: Show existing syntax options that remain valid
- Multiple patterns: Demonstrate different ways to accomplish the same goals
- Migration examples: When appropriate, show how concepts translate between approaches
- Ecosystem compatibility: How different approaches work within the broader .NET ecosystem

#### Best Practices

Guidance for effective usage:

- Recommended patterns: When and how to use the feature effectively
- Performance guidance: Optimization considerations and trade-offs
- Common scenarios: Typical use cases and implementation approaches
- Integration recommendations: How to combine with other .NET features

#### Limitations and Considerations

Critical knowledge for avoiding problems:

- Technical constraints: What the feature cannot do or where it doesn't apply
- Performance considerations: Important optimization guidance
- Security limitations: Security model constraints and best practices
- Common pitfalls: Frequent mistakes and how to avoid them

#### See Also

Natural cross-references to related topics:

- Direct relationships: Immediately relevant related features
- Workflow continuations: Logical next steps in development workflows
- Alternative approaches: Different solutions to similar problems
- Advanced topics: Deeper dives and specialized scenarios

## Topic Metadata Requirements

Each topic must include a metadata table with standardized properties for consistent organization and searchability:

### Required Metadata Properties

- Name: Display name of the topic
- ID: Unique identifier (kebab-case)
- Category: Primary category (CLI, C# Language, Libraries, Extensions, etc.)
- Namespace: .NET namespace for code-related topics, "(none)" for concepts/features
- Description: Brief description of the topic
- Complexity: Numeric rating (0.0-1.0) indicating learning difficulty
- Audience: Target developer audience
- Priority: Importance ranking (1=highest, 2=medium, 3=lower)
- Version: .NET version where introduced
- Year: Year of introduction

### Namespace Property Guidelines

The Namespace property enables semantic distinction between code-focused topics and concept-focused topics:

Use actual namespace for topics representing:
- Class libraries and APIs (e.g., "System.Text.Json", "Microsoft.Extensions.AI")
- Specific types and namespaces (e.g., "System.IO", "System.Threading.Tasks")
- NuGet packages with primary namespaces

Use "(none)" for topics representing:
- Language features (e.g., collection expressions, pattern matching)
- Tooling and CLI features (e.g., file-based apps, dotnet commands)
- Deployment concepts (e.g., Native AOT, single-file deployment)
- Development workflows and practices

### Example Metadata Tables

Code-focused topic:
```markdown
| Property | Value |
| --- | --- |
| Name | Microsoft.Extensions.AI |
| ID | microsoft-extensions-ai |
| Category | Extensions |
| Namespace | Microsoft.Extensions.AI |
| Description | Unified approach for .NET developers to integrate AI services |
| Complexity | 0.6 |
| Audience | AI developers, library authors |
| Priority | 1 |
| Version | 9.0 |
| Year | 2024 |
```

Concept-focused topic:
```markdown
| Property | Value |
| --- | --- |
| Name | File-based apps |
| ID | file-based-apps |
| Category | CLI |
| Namespace | (none) |
| Description | Run single .cs files without project structure |
| Complexity | 0.3 |
| Audience | all developers, scripters |
| Priority | 2 |
| Version | 10.0 |
| Year | 2025 |
```

## Content Standards

### Storytelling Guidelines

Positive Narrative Focus: Golden reference documents should tell a positive story about the feature without disparaging existing approaches:

- Focus on benefits and capabilities rather than problems with alternatives
- Avoid "before/after" comparisons that emphasize how "terrible" the old way was
- Present traditional syntax as valid alternatives rather than deprecated approaches
- Use language like "provides", "enables", "offers" instead of "solves", "fixes", "improves"
- When showing multiple approaches, frame them as "options" or "alternatives" rather than "old vs new"

Cross-Language Examples: When showing familiar syntax patterns from other languages:

- Place examples from other programming languages in separate code fences, not in code comments
- Use proper language-specific syntax highlighting
- Show how C# syntax aligns with familiar patterns from Python, JavaScript, Swift, Rust, etc.
- Present these as "familiar to [language] developers" rather than direct comparisons

Document Structure: Organize sections to maintain positive flow:

- Start with overview and core capabilities
- Show syntax and practical examples
- Include alternative approaches and best practices before limitations
- End with limitations and considerations (no concluding summary paragraph)
- Remove emoji indicators (❌/✅) and use plain text instead

### Technical Accuracy Requirements

- All code examples must compile and run on specified .NET versions
- Performance claims must be measurable and verified
- Security guidance must align with official threat models
- Integration examples must work with current framework versions

### Completeness Expectations

- Cover 80% of common scenarios for the topic
- Include both basic and advanced usage patterns
- Address frequent troubleshooting scenarios
- Provide sufficient context for understanding ecosystem position

### Code Quality Standards

- All examples must follow current .NET coding conventions
- Use meaningful variable names and realistic scenarios
- Include necessary using statements and dependencies
- Demonstrate proper error handling where relevant

### Authority and Currency

- Reflect latest stable versions and best practices
- Avoid deprecated approaches unless discussing migration
- Include version requirements for version-specific features
- Update examples to use modern syntax and patterns

## Code Example Guidelines

### Basic Pattern

```csharp
// Simple, focused examples with clear purpose
string json = JsonSerializer.Serialize(weatherForecast);
WeatherForecast forecast = JsonSerializer.Deserialize<WeatherForecast>(json);
```

### Configuration Example

```csharp
// Show configuration with common options
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
    WriteIndented = true,
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
};

string json = JsonSerializer.Serialize(obj, options);
```

### Scenario-Specific Example

```csharp
// Real-world scenario with context
// High-performance API serialization using source generation
[JsonSerializable(typeof(ApiResponse))]
internal partial class ApiContext : JsonSerializerContext { }

// In startup/DI configuration
services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.TypeInfoResolver = ApiContext.Default;
});
```

## Section Organization Principles

### Progressive Complexity

- Start with simplest, most common usage
- Build up to more sophisticated scenarios
- End with edge cases and advanced optimizations
- Maintain clear skill level progression

### Scenario-Based Organization

- Group related examples under descriptive scenario headings
- Explain when each scenario is appropriate
- Show complete, working implementations
- Include relevant context and considerations

### Positive Flow Structure

- Present capabilities and benefits first
- Show practical examples and usage patterns
- Include alternative approaches as valid options
- Cover best practices before limitations
- End with constraints and considerations (no conclusion paragraph)
- Maintain focus on what the feature enables rather than what it replaces

### Cross-Reference Integration

- Link to related topics naturally within content flow
- Avoid generic "see also" lists without context
- Explain why the cross-reference is relevant
- Maintain bidirectional relationship awareness

## Validation Rules

Before content is considered complete, verify:

- [ ] Code Compilation: All examples compile against target frameworks
- [ ] Functional Testing: Examples produce expected outputs
- [ ] Cross-Platform Compatibility: Platform-specific content works on target platforms
- [ ] Version Accuracy: Features are correctly attributed to .NET versions
- [ ] Authority Verification: Claims backed by official sources
- [ ] Completeness Coverage: Common scenarios adequately addressed
- [ ] Integration Accuracy: Framework integration examples functional
- [ ] Security Compliance: Security guidance aligns with official recommendations

## Quality Criteria

### Technical Depth

- Sufficient detail for practical implementation
- Appropriate complexity for target audience
- Clear distinction between basic and advanced usage
- Complete enough to avoid external dependencies for understanding

### Practical Utility

- Examples solve real development problems
- Scenarios reflect actual usage patterns
- Code samples are copy-paste functional
- Guidance enables effective decision-making

### Educational Value

- Explains the "why" behind recommendations
- Provides context for understanding trade-offs
- Builds understanding from basic to advanced concepts
- Connects to broader ecosystem knowledge

## Anti-Patterns to Avoid

### Content Organization Issues

- Don't organize by API structure instead of developer workflows
- Avoid examples without sufficient context to understand purpose
- Don't mix complexity levels within single sections
- Ensure scenarios build logically from simple to complex
- Don't place limitations before showcasing capabilities and best practices
- Avoid concluding paragraphs that summarize the document

### Negative Storytelling Issues

- Don't emphasize how "complex" or "terrible" previous approaches were
- Avoid "before/after" comparisons that disparage existing syntax
- Don't use language that suggests old approaches are deprecated when they're still valid
- Avoid embedding cross-language examples in code comments instead of proper code fences
- Don't use emoji indicators (❌/✅) - use plain text descriptions instead

### Code Example Problems

- Don't use unrealistic or toy examples for serious topics
- Avoid incomplete examples that require external knowledge
- Don't show deprecated patterns without clear migration guidance
- Ensure examples follow current best practices and conventions

### Authority and Accuracy Issues

- Don't make performance claims without benchmarks
- Avoid speculation about future feature availability
- Don't recommend patterns that conflict with official guidance
- Ensure all technical claims are verifiable against official sources

## Benefits of Structured Approach

### Content Generation Quality

- Provides rich source material for multiple output formats
- Enables consistent quality across generated variations
- Supports automated validation of generated content
- Facilitates maintenance and updates across content variants

### Knowledge Graph Construction

- Enables semantic relationship analysis through comprehensive coverage
- Supports cross-topic similarity computation
- Provides authoritative baseline for content comparison
- Facilitates discovery of natural topic relationships
