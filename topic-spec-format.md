# Topic Specification Format Guide

This document defines the format and content standards for topic specification files across all topics in the documentation set. Topic specifications define feature relationships, hierarchy, and generation guidance.

## Purpose

Topic specifications serve as the metadata foundation for the knowledge graph:

- Relationship mapping: Define how features connect to and depend on each other
- Content generation guidance: Provide hints for LLM content generation
- Quality boundaries: Set scope and token budget expectations
- Authority tracking: Establish source validation requirements

## Format Structure

### Document Title

The H1 will be structured as: `# {Feature Name} - Topic Specification`

### Required Sections

#### Feature Description

A concise paragraph explaining what the feature is and its primary purpose. Should be 2-3 sentences covering the essence of the feature without diving into implementation details.

#### Official Sources

Primary Microsoft documentation and announcements using a four-column table:

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| <https://docs.microsoft.com/>... | rendered | Main official documentation | - |
| <https://devblogs.microsoft.com/>... | rendered | Official announcement or blog post | - |

Type values:

- rendered: Browser-rendered pages (docs.microsoft.com, devblogs, GitHub web interface)
- raw: Direct file content for LLM consumption (raw.githubusercontent.com URLs)
- community: Non-specific community content

#### Primary Sources

High-quality sources with preference for raw markdown URLs for LLM readability using a four-column table:

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| <https://raw.githubusercontent.com/>... | raw | Authoritative content from official repositories | - |
| <https://github.com/dotnet/>... | rendered | GitHub repository or issue links | - |

#### Secondary Sources

Good-quality community and supplementary sources using a four-column table:

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| <https://example.com/>... | rendered | Community tutorials and guides | - |
| <https://github.com/>... | rendered | Community repositories and examples | - |

Note: All rows must contain actual URLs. Placeholder rows with dashes (`-`) or generic descriptions like "Community tutorials" are not allowed. Each row must provide a concrete, accessible URL.

#### Metadata

Structured metadata for categorization and discovery using a two-column table:

| Property | Value |
| --- | --- |
| Name | Display name for the feature |
| ID | Unique identifier (kebab-case) |
| Category | Primary organizational category |
| Description | Brief description of the feature |
| Complexity | Numeric complexity score from 0.0 (beginner) to 1.0 (advanced expert) |
| Audience | Target developer groups |
| Priority | Importance ranking (1=Critical, 2=Important, 3=Useful, 4=Specialized) |
| Version | .NET version when the feature was first introduced (e.g., "8.0") |
| Year | Year when the feature was first introduced (e.g., "2023") |

#### Relationships

Structured relationship mapping using a two-column table:

| Type | Target |
| --- | --- |
| Enables | Features or capabilities this feature makes possible |
| Conflicts with | Features that cannot be used simultaneously |
| Alternative to | Other approaches that solve similar problems |
| Prerequisite | Required dependencies or foundational knowledge |
| Synergistic with | Features that work particularly well together |

#### Keywords

Key terms and phrases associated with the feature for discoverability and search. List as bullet points:

- primary feature name
- alternative names or terminology
- related concepts and technologies
- common search terms developers might use

#### Diagnostic Codes

Error, warning, and analysis codes that relate to the topic. Use a two-column table sorted by priority (high-value codes first):

| Code | Message |
| --- | --- |
| CS9176 | There is no target type for the collection expression. |
| CS9174 | Cannot initialize type '{0}' with a collection expression because the type is not constructible. |

Guidelines:
- Include compiler error codes (CS####), analyzer warning codes (CA####), and other diagnostic codes
- Prioritize codes that developers commonly encounter when working with the feature
- Focus on codes that would benefit from dedicated documentation
- Use the exact message text from the compiler/analyzer (including placeholder tokens like {0})
- Multiple rows with the same code are allowed when different methods or contexts produce different messages (e.g., IL2026 for both Serialize and Deserialize methods)
- Use backticks around method names or code elements containing `<` and `>` characters to ensure markdown compliance (e.g., `JsonSerializer.Serialize<TValue>()`)

#### Generation Hints (Category-Level Only)

Note: Generation hints should be defined at the category level (e.g., in `docs/csharp/topic-spec.md`) rather than repeated in each feature specification.

Using a two-column table:

| Property | Value |
| --- | --- |
| Emphasize | Language syntax clarity, Developer productivity improvements, Performance improvements and characteristics, Migration patterns from older syntax |
| Avoid | Compiler implementation, Complex edge cases, Advanced generic scenarios |
| Cross-reference discover from | Related language features, Syntax alternatives, Prerequisite concepts |
| Cross-reference surface to | Complementary features, Common usage patterns, Framework integrations |

### Optional Sections

#### Keywords

Alternative terms and related concepts for discovery and cross-referencing:

```markdown
## Keywords

- collection expressions
- params collection expressions
- collection initializers
- array syntax
- list initialization
- spread operator
```

Guidelines:

- Use an unordered list with one keyword or phrase per item
- Include alternative names, related terminology, and search terms
- Helpful for topics that span multiple feature names or have common aliases

#### Repo Paths (Alternative to URL Tables)

For repository file references, use Repo Path tables instead of full URLs:

| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 feature documentation | - |
| dotnet/csharplang | proposals/collection-expressions.md | Collection expressions proposal | - |

Repository Registry: All repository definitions are maintained in `/docs/repos.md`. Use the short repo names (e.g., `dotnet/docs`) defined in that registry.

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

- [ ] Relationship Accuracy: All relationships verified against official documentation
- [ ] Authority Verification: All sources accessible and current
- [ ] Cross-Reference Completeness: Bidirectional relationships properly established
- [ ] Token Budget Realism: Budget guidance matches actual content generation capacity
- [ ] Validation Testability: All validation requirements can be automatically verified
- [ ] Metadata Consistency: Category and complexity align with broader taxonomy

## Quality Criteria

### Precision Requirements

- Feature descriptions must be technically accurate and current
- Relationships must be specific to actual feature interactions
- Complexity ratings must reflect real developer experience levels using the 0.0-1.0 scale:
  - 0.0-0.2: Beginner level - Basic concepts, simple examples, minimal prerequisites
  - 0.3-0.4: Beginner to Intermediate - Some complexity, requires basic .NET knowledge
  - 0.5-0.6: Intermediate - Moderate complexity, requires solid .NET foundation
  - 0.7-0.8: Intermediate to Advanced - Complex scenarios, deep .NET knowledge needed
  - 0.9-1.0: Advanced Expert - Expert level, complex integrations, edge cases
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

### Code Quality Standards

- Linter Compliance: All topic specification files must be linter-clean using markdownlint
- Formatting Consistency: Use consistent table formatting and spacing
- URL Format: Use plain text URLs without angle bracket notation for better parsing
- Table Structure: Maintain consistent column ordering across all source tables

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

### Good Metadata Specification

```markdown
## Metadata

| Property | Value |
| --- | --- |
| Name | System.Text.Json |
| ID | system-text-json |
| Category | Libraries |
| Description | High-performance JSON serialization library built into .NET Core 3.0+ |
| Complexity | 0.6 |
| Audience | All developers | Web developers | API developers |
| Priority | 1 (Critical) |
| Version | 3.0 |
| Year | 2019 |
```

### Good Relationship Specification

```markdown
## Relationships

| Type | Target |
| --- | --- |
| Enables | Native AOT compatibility, High-performance JSON operations, Secure JSON processing |
| Conflicts with | System.Runtime.Serialization attributes, ISerializable interface |
| Alternative to | Newtonsoft.Json, DataContractJsonSerializer |
| Prerequisite | .NET Core 3.0+ (built-in), .NET Standard 2.0+ (NuGet package) |
| Synergistic with | ASP.NET Core APIs, Source generators, HttpClient extensions |
```

### Good Source Specification

```markdown
## Official Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://docs.microsoft.com/dotnet/standard/serialization/system-text-json/ | rendered | Main official documentation | - |
| https://devblogs.microsoft.com/dotnet/try-the-new-system-text-json-apis/ | rendered | Official announcement blog post | - |

## Primary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://raw.githubusercontent.com/dotnet/docs/main/docs/standard/serialization/system-text-json/overview.md | raw | JSON serialization overview documentation | 2025-01-19 |
| https://raw.githubusercontent.com/dotnet/runtime/main/src/libraries/System.Text.Json/README.md | raw | System.Text.Json library README | 2024-09-12 |

## Secondary Sources

| URL | Type | Description | Last Verified |
| --- | --- | --- | --- |
| https://github.com/dotnet/samples/tree/main/core/json | rendered | Official JSON samples repository | 2024-09-12 |
```

### Good Generation Guidance (Category-Level)

```markdown
## Generation Hints

| Property | Value |
| --- | --- |
| Emphasize | Language syntax clarity, Developer productivity improvements, Performance improvements and characteristics, Migration patterns from older syntax |
| Avoid | Compiler implementation, Complex edge cases, Advanced generic scenarios |
| Cross-reference discover from | Related language features, Syntax alternatives, Prerequisite concepts |
| Cross-reference surface to | Complementary features, Common usage patterns, Framework integrations |
```

### Good Keywords Specification

```markdown
## Keywords

- collection expressions
- params collection expressions
- collection initializers
- array syntax
- list initialization
- spread operator
```
