# Document Format Specifications

This directory contains format specifications for all document types used in the .NET LLM documentation system.

General formatting guidelines and standards are specific in: **[general-format.md](general-format.md)**.

## Source Graph Formats

These formats are used in the source graph (`dotnet-golden-llm-docs`) for curated content creation:

- **[index-format.md](index-format.md)** - HAL+JSON navigation structure
- **[golden-reference-format.md](golden-reference-format.md)** - Authoritative content for each topic
- **[qa-pairs-format.md](qa-pairs-format.md)** - Question-answer pairs for validation
- **[topic-spec-format.md](topic-spec-format.md)** - Topic metadata and organization
- **[validation-format.md](validation-format.md)** - Quality assurance specifications

## Consumption Graph Formats

These formats are generated in the consumption graph (`dotnet-docs-llms`) by the ContentGenerator tool:

- **[overview-format.md](overview-format.md)** - Conceptual foundation documents
- **[one-shot-format.md](one-shot-format.md)** - Complete guides with token budgets
- **[examples-format.md](examples-format.md)** - Practical code patterns and implementations
- **[troubleshooting-format.md](troubleshooting-format.md)** - Common problems and solutions
- **[integration-format.md](integration-format.md)** - Cross-system patterns and usage
- **[advanced-format.md](advanced-format.md)** - Edge cases, performance, and complex scenarios

Note: Some source graph formats are re-used in the consumption graph, with the index being the most obvious.

## Usage

- **Content Authors**: Use source graph formats when creating curated content
- **ContentGenerator Tool**: Use consumption graph formats when generating LLM-optimized content
- **Quality Validation**: All formats include similarity and validation requirements
- **Cross-References**: Formats reference each other appropriately for consistency

See [../ARCHITECTURE.md](../ARCHITECTURE.md) for complete system overview and process flow.