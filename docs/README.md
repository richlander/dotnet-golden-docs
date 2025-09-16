# Documentation Content Organization

This directory contains the structured content that serves as input for LLM-optimized documentation generation. Each topic is organized with focused document types designed for content quality, validation, and multi-format generation.

## Document Types

Each topic is organized with focused document types:

- **`topic-spec.md`**: Feature description, relationships, source authority, generation hints
- **`golden-reference.md`**: Comprehensive reference (validation baseline, never shipped to LLMs)
- **`qa-pairs.md`**: Validated question-answer pairs for testing and generation
- **`sources.md`**: Source authority tracking and provenance
- **`validation.md`**: Validation requirements and test results

## Directory Structure

```
docs/
├── README.md                    # Document format overview
├── qa-pairs-format.md          # Q&A standards and taxonomy
├── golden-reference-format.md   # [PLACEHOLDER] Golden doc standards
├── topic-spec-format.md        # [PLACEHOLDER] Topic spec standards
├── sources-format.md           # [PLACEHOLDER] Source documentation standards
└── {category}/
    └── {topic-id}/
        ├── topic-spec.md        # Feature relationships and generation hints
        ├── golden-reference.md  # Comprehensive validation baseline
        ├── qa-pairs.md         # Validated Q&A pairs
        ├── sources.md          # Source authority tracking
        └── validation.md       # Testing requirements and results
```

## Content Categories

- **`cli/`**: Command-line tools and interfaces
- **`libraries/`**: Framework libraries and APIs *(planned)*
- **`runtime/`**: Runtime behavior and configuration *(planned)*
- **`cross-cutting/`**: Topics spanning multiple categories *(planned)*

## Format Standards

### Shared Standards
- [Q&A Format Guide](qa-pairs-format.md): Standards for question-answer content
- [Golden Reference Format](golden-reference-format.md): *(placeholder)*
- [Topic Specification Format](topic-spec-format.md): *(placeholder)*
- [Sources Format](sources-format.md): *(placeholder)*

### Document-Specific Guidelines
Each document type has specific requirements:
- **Focused scope**: Each document addresses exactly one concern
- **Validation requirements**: All content must be testable and verifiable
- **Source authority**: All claims backed by authoritative references
- **Token efficiency**: Content optimized for embedding and retrieval

## Current Topics

### CLI Category
- **[file-based-apps](cli/file-based-apps/)**: Complete pilot implementation
  - All document types implemented
  - Format standards established
  - Validation testing completed
  - Token optimization verified

## Quality Standards

All content must meet these standards before being used for generation:

- **Authority**: Claims backed by official sources with verification dates
- **Currency**: Reflects latest stable versions and best practices
- **Completeness**: Covers 80% of common scenarios per topic
- **Precision**: Each document addresses exactly its stated scope
- **Testability**: All code examples are verified working

---

*This content organization enables systematic generation of multiple token-budget formats while maintaining high quality and authority through human curation and validation.*