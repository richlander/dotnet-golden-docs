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

### Basic Format

The basic format includes question and answer lines. Typically one question line and possibly multiple answer lines, which may include a list. This may be followed be a code fence. `Tags` and other descriptive information may follow that describe the Q&A pair.

````markdown
Q: [Question in natural language]
A: [Complete, standalone answer]
```csharp
// Code if relevant
```
Tags: [category1, category2, category3]
Validation: [How to verify the answer is correct]
````

### Multi-Question Format
A Q&A pair may have multiple questions with the same answer.

````markdown
Q: [First question variant]
Q: [Second question variant]
A: [Single authoritative answer]
Tags: [category1, category2, category3]
Validation: [How to verify the answer is correct]
````

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

## Anti-Patterns to Avoid

### Overspecification
- Don't include unnecessary details that make answers hard to match
- Avoid code comments that restate the obvious
- Don't answer questions that weren't asked

### Scope Creep
- Keep each Q&A focused on a single concern
- Split overloaded questions into focused variants
- Don't mix basic and advanced concepts in the same answer

### Poor Validation
- Don't grade LLM answers as wrong for being more precise
- Avoid validation criteria that penalize better phrasing
- Don't require exact word matching over semantic equivalence

### Generic Content
- Avoid answers that could apply to any technology
- Include specific syntax, commands, and examples
- Don't use placeholder values without clear context