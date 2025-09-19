# Golden Reference Format Guide

This document defines the format and quality standards for golden reference documents across all topics in the documentation set. Golden references serve as comprehensive validation baselines and primary source material for content generation.

## Purpose

Golden reference documents serve multiple critical functions:
- **Validation baseline**: Ground truth for evaluating generated content quality
- **Content generation source**: Primary material for creating output formats
- **Comprehensive coverage**: Complete reference including edge cases and integrations
- **Authority establishment**: Definitive technical accuracy standard

## Format Structure

### Document Title

The H1 will be structured as: `# {Feature Name} - Golden Reference`

### Required Sections

#### Overview
Conceptual foundation providing context and orientation:
- **What it is**: Clear definition and technical positioning
- **Key advantages**: Primary benefits and value propositions (3-6 bullet points)
- **Main approaches**: Different usage patterns or modes (if applicable)
- **When to use**: Primary scenarios and decision criteria

#### Essential Syntax & Examples
Core technical content with working code:
- **Basic operations**: Fundamental usage patterns with minimal examples
- **Configuration**: Key options and customization approaches
- **Advanced patterns**: Important but less common usage scenarios
- **Version-specific features**: New capabilities in recent versions

#### Relationships & Integration
Ecosystem connections and context:
- **Framework integration**: How it works with ASP.NET Core, Entity Framework, etc.
- **Migration considerations**: Moving from alternative approaches
- **Compatibility requirements**: Version and platform constraints
- **Performance characteristics**: Key optimization considerations

#### Common Scenarios
Real-world usage patterns organized by complexity:
- **Scenario title**: Descriptive name for the use case
- **When to use**: Specific conditions that make this pattern appropriate
- **Implementation**: Working code example with explanation
- **Considerations**: Important details, limitations, or alternatives

#### Gotchas & Limitations
Critical knowledge for avoiding problems:
- **Critical differences**: How behavior differs from similar features or previous versions
- **Performance considerations**: Important optimization guidance
- **Security limitations**: Security model constraints and best practices
- **Common pitfalls**: Frequent mistakes and how to avoid them

#### See Also
Natural cross-references to related topics:
- **Direct relationships**: Immediately relevant related features
- **Workflow continuations**: Logical next steps in development workflows
- **Alternative approaches**: Different solutions to similar problems
- **Advanced topics**: Deeper dives and specialized scenarios

## Content Standards

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

### Cross-Reference Integration
- Link to related topics naturally within content flow
- Avoid generic "see also" lists without context
- Explain why the cross-reference is relevant
- Maintain bidirectional relationship awareness

## Validation Rules

Before content is considered complete, verify:

- [ ] **Code Compilation**: All examples compile against target frameworks
- [ ] **Functional Testing**: Examples produce expected outputs
- [ ] **Cross-Platform Compatibility**: Platform-specific content works on target platforms
- [ ] **Version Accuracy**: Features are correctly attributed to .NET versions
- [ ] **Authority Verification**: Claims backed by official sources
- [ ] **Completeness Coverage**: Common scenarios adequately addressed
- [ ] **Integration Accuracy**: Framework integration examples functional
- [ ] **Security Compliance**: Security guidance aligns with official recommendations

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