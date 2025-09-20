# Q&A Pairs Format Guide

This document defines the format and quality standards for Q&A pairs across all topics in the documentation set. They label valid question with correct answer.

## Purpose

Q&A pairs serve multiple purposes in the LLM knowledge architecture:

- **LLM evaluation**: Validate that generated content enables correct LLM responses
- **Content generation**: Source material for generating multiple output formats
- **Quality benchmarking**: Ground truth for evaluating LLM performance
- **Developer self-service**: Direct answers to common questions

## Format Structure

## Document title

The H1 will be structured as: `# Topic name -- Q&A`

## Sections

There will likely be multiple sections with descriptive names relevant to the domain. Each section will contain multiple Q&A pairs related to the section title.

### Basic Format with Structured Metadata

Each Q&A pair uses JSON frontmatter for programmatic access followed by human-readable content. Frontmatter uses 3 dashes (`---`) and Q&A separators use 6 dashes (`------`).

````markdown
---
difficulty: "beginner"
validation: "code-compiles"
topics: ["cli", "execution"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2024-09-15"
---
Q: [Question in natural language]
A: [Complete, standalone answer]
```csharp
// Code if relevant
```

------
````

### Multi-Question Format

A Q&A pair may have multiple questions with the same answer.

````markdown
---
difficulty: "intermediate"
validation: "runtime"
topics: ["troubleshooting", "arguments"]
audience: ["all-developers"]
source-authority: "official-docs"
last-verified: "2024-09-15"
---
Q: [First question variant]
Q: [Second question variant]
A: [Single authoritative answer]

------
````

## Structured Metadata Fields

### Required Fields

- **`difficulty`**: Skill level required (see Difficulty Levels section)
- **`validation`**: How to verify answer correctness (see Validation Methods section)
- **`topics`**: Array of topic tags for categorization and cross-referencing
- **`audience`**: Target developer audience (see Content Types section)
- **`source-authority`**: Authority level of source material
- **`last-verified`**: ISO date when content was last validated (YYYY-MM-DD)

### Optional Fields

- **`related-qa`**: Array of related Q&A identifiers for cross-linking
- **`version-specific`**: .NET version requirements (e.g., "10+", "8-10")
- **`platform-specific`**: Platform constraints (e.g., ["windows"], ["linux", "macos"])

### Field Value Standards

**Source Authority Values:**

- `"official-docs"`: Microsoft official documentation
- `"community-high"`: High-quality community content (Andrew Lock, etc.)
- `"community-good"`: Good community content (blog posts, tutorials)
- `"stack-overflow"`: Stack Overflow answers with high scores

**Audience Values:**

- `"all-developers"`: Applicable to all .NET developers
- `"beginners"`: New to .NET or programming
- `"backend-developers"`: Server-side development focus
- `"platform-developers"`: Framework and tooling developers

## Labeling Taxonomy

### Difficulty Levels

- **beginner**: Basic concepts, getting started, simple examples
- **intermediate**: Common workflows, integration patterns, practical scenarios
- **advanced**: Complex configurations, optimization, edge cases
- **expert**: Deep internals, custom implementations, debugging complex issues

### Content Types

- **concept**: What something is, when to use it, fundamental understanding
- **usage**: How to perform specific tasks, step-by-step instructions
- **troubleshooting**: Problem-solving, error resolution, debugging
- **performance**: Optimization, benchmarking, efficiency considerations
- **security**: Best practices, vulnerability prevention, secure configurations
- **migration**: Moving between versions, converting formats, upgrade paths

### Response Styles

- **concise**: Brief, direct answers for experienced developers
- **detailed**: Comprehensive explanations with context and rationale
- **step-by-step**: Sequential instructions for complex procedures
- **code-focused**: Primarily code examples with minimal explanation

### Validation Methods

- **compilation**: Code examples must compile successfully
- **runtime**: Code must execute and produce expected output
- **benchmark**: Performance claims must be measurable
- **manual-review**: Conceptual accuracy verified by domain experts

## Quality Criteria

### Accuracy Requirements

- Must match official documentation sources
- Code examples must be tested and working
- Version-specific information must be clearly marked
- No speculation or unverified claims

### Completeness Standards

- Answers must be self-contained and not assume external context
- Include essential context for understanding
- Cover the most common variations of the question
- Address critical limitations or gotchas when relevant

### Currency Requirements

- Reflect current best practices and latest stable versions
- Avoid deprecated approaches unless specifically discussing migration
- Include version requirements when features are version-specific
- Update examples to use modern syntax and patterns

### Clarity Guidelines

- Use clear, precise language appropriate to the target audience
- Define technical terms when first introduced
- Provide examples that illustrate key concepts
- Structure complex answers with clear organization

### Coverage Expectations

- Address 80% of common scenarios for the topic
- Include both basic and advanced use cases
- Cover primary workflows and common variations
- Address frequent troubleshooting scenarios

## Validation Rules

Before content is considered complete, verify:

- [ ] **Code Quality**: All code examples compile against target framework
- [ ] **Pattern Compliance**: Examples follow established framework patterns
- [ ] **Functionality**: Publishing/deployment examples produce working outputs
- [ ] **Cross-Platform**: Platform-specific examples work on target platforms
- [ ] **Answer Verification**: All Q&A pairs have verified, accurate answers
- [ ] **Taxonomy Compliance**: All tags are valid according to labeling taxonomy
- [ ] **Source Authority**: Claims are backed by authoritative sources
- [ ] **Scope Precision**: Each Q&A addresses exactly what is asked, no more

## Benefits of Structured Metadata

### Programmatic Access

- **Automated filtering**: Tools can filter by difficulty, validation type, topics
- **Quality gates**: Validation field drives automated testing pipelines
- **Cross-referencing**: Topics array enables automatic relationship discovery
- **Analytics**: Easy coverage analysis by difficulty, topic, audience

### Content Management

- **Currency tracking**: `last-verified` dates enable staleness detection
- **Authority assessment**: `source-authority` enables confidence scoring
- **Targeted generation**: Audience and difficulty enable personalized content
- **Relationship mapping**: `related-qa` and `topics` build knowledge graph

## Anti-Patterns to Avoid

### Metadata Quality

- Don't use generic topic tags that could apply to any technology
- Avoid outdated `last-verified` dates without actual verification
- Don't mix difficulty levels within single Q&A pairs
- Ensure `validation` method actually applies to the answer content

### Content Structure

- Keep each Q&A focused on a single concern despite rich metadata
- Don't let metadata complexity overshadow answer quality
- Avoid inconsistent separator usage (always 6 dashes for Q&A separation)
- Don't duplicate information between metadata and answer content

### Scope and Validation

- Don't grade LLM answers as wrong for being more precise
- Avoid validation criteria that penalize better phrasing
- Don't require exact word matching over semantic equivalence
- Include specific syntax, commands, and examples rather than generic content
