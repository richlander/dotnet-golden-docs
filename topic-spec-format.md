# Topic Specification Format Guide

This document defines the format and content standards for topic specification files across all topics in the documentation set. Topic specifications define feature relationships, hierarchy, and generation guidance.

## Purpose

Topic specifications serve as the metadata foundation for the knowledge graph:
- **Relationship mapping**: Define how features connect to and depend on each other
- **Content generation guidance**: Provide hints for LLM content generation
- **Quality boundaries**: Set scope and token budget expectations
- **Authority tracking**: Establish source validation requirements

## Format Structure

### Document Title

The H1 will be structured as: `# {Feature Name} - Topic Specification`

### Required Sections

#### Feature Description
A concise paragraph explaining what the feature is and its primary purpose. Should be 2-3 sentences covering the essence of the feature without diving into implementation details.

#### Relationships
Structured relationship mapping using consistent keywords:
- **Enables**: Features or capabilities this feature makes possible
- **Conflicts with**: Features that cannot be used simultaneously
- **Alternative to**: Other approaches that solve similar problems
- **Prerequisite**: Required dependencies or foundational knowledge
- **Synergistic with**: Features that work particularly well together

#### Hierarchy
Structured metadata for categorization and discovery:
- **Name**: Display name for the feature
- **ID**: Unique identifier (kebab-case)
- **Category**: Primary organizational category
- **Complexity**: Skill level range (Beginner | Intermediate | Advanced | Expert)
- **Audience**: Target developer groups
- **Priority**: Importance ranking (1=Critical, 2=Important, 3=Useful, 4=Specialized)

#### Source Authority
Authority and validation requirements:
- **Primary Sources (High confidence)**: Official documentation links with verification dates
- **Secondary Sources (Good quality)**: Community content and additional references
- **Validation Requirements**: Specific testing and verification criteria

#### Generation Hints
Guidance for content generation:
- **Emphasize**: Key aspects to highlight in generated content
- **Avoid**: Topics or approaches to minimize or exclude
- **Cross-reference discover from**: Topics that should link to this one
- **Cross-reference surface to**: Topics this should link to

#### Token Budget Guidance
Content scope expectations for different budget levels:
- **Minimum viable content**: 600 tokens - Essential patterns only
- **Comprehensive coverage**: 2400 tokens - Full practical usage
- **Full reference**: 4800 tokens - Complete scenarios and edge cases

## Content Standards

### Relationship Mapping Precision
- Use specific, actionable relationship types
- Avoid vague terms like "related to" or "works with"
- Include version-specific relationships when relevant
- Reference concrete features, not abstract concepts

### Authority Requirements
- All primary sources must be official Microsoft documentation
- Include last verification dates for all sources
- Specify validation criteria that can be automatically tested
- Secondary sources must be from recognized community authorities

### Generation Guidance Quality
- Emphasize points should be specific and actionable
- Avoid points should prevent common content quality issues
- Cross-references should be bidirectional and meaningful
- Token budgets should reflect realistic content density

## Validation Rules

Before content is considered complete, verify:

- [ ] **Relationship Accuracy**: All relationships verified against official documentation
- [ ] **Authority Verification**: All sources accessible and current
- [ ] **Cross-Reference Completeness**: Bidirectional relationships properly established
- [ ] **Token Budget Realism**: Budget guidance matches actual content generation capacity
- [ ] **Validation Testability**: All validation requirements can be automatically verified
- [ ] **Hierarchy Consistency**: Category and complexity align with broader taxonomy

## Quality Criteria

### Precision Requirements
- Feature descriptions must be technically accurate and current
- Relationships must be specific to actual feature interactions
- Complexity ratings must reflect real developer experience levels
- Priority rankings must consider actual developer usage patterns

### Completeness Standards
- Cover all significant relationships within the .NET ecosystem
- Include both positive relationships (enables, synergistic) and negative (conflicts)
- Address version-specific considerations when relevant
- Provide sufficient cross-reference guidance for navigation

### Currency Requirements
- Reflect current .NET versions and best practices
- Include recent feature additions and deprecations
- Update relationship mappings when ecosystem changes occur
- Maintain verification dates for all authority sources

## Anti-Patterns to Avoid

### Relationship Mapping Issues
- Don't use generic relationship types that could apply to any feature
- Avoid circular dependency specifications
- Don't include obvious prerequisites (like .NET runtime for .NET features)
- Ensure conflict relationships are bidirectional

### Authority and Validation Problems
- Don't specify validation criteria that cannot be automatically tested
- Avoid outdated source verification dates
- Don't mix authority levels within primary sources
- Ensure all validation requirements are actionable

### Generation Guidance Issues
- Don't provide generation hints that contradict source material
- Avoid emphasize points that are too broad to be actionable
- Don't specify cross-references to non-existent topics
- Ensure token budgets are realistic for the feature scope

## Examples

### Good Relationship Specification
```markdown
## Relationships
Enables: Native AOT compatibility, High-performance JSON operations, Secure JSON processing
Conflicts with: System.Runtime.Serialization attributes, ISerializable interface
Alternative to: Newtonsoft.Json, DataContractJsonSerializer
Prerequisite: .NET Core 3.0+ (built-in), .NET Standard 2.0+ (NuGet package)
Synergistic with: ASP.NET Core APIs, Source generators, HttpClient extensions
```

### Good Authority Specification
```markdown
## Source Authority
Primary Sources (High confidence):
- https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/ - Official documentation - Last verified: 2025-01-19
- https://github.com/dotnet/runtime/tree/main/src/libraries/System.Text.Json - Source code - Last verified: 2024-09-12

Validation Requirements:
- [ ] Code examples compile and run across .NET versions
- [ ] Source generation examples work with Native AOT
- [ ] Performance benchmarks vs Newtonsoft.Json
```

### Good Generation Guidance
```markdown
## Generation Hints
Emphasize: Performance benefits, Source generation, UTF-8 optimization, Security features
Avoid: Complex enterprise scenarios, Legacy serialization APIs
Cross-reference discover from: json-serialization, newtonsoft-migration, source-generation
Cross-reference surface to: aspnet-core-apis, httpclient-extensions, native-aot
```