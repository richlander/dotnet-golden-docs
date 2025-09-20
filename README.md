# .NET Golden LLM Documentation

This repository contains curated source materials and generation instructions for creating LLM-optimized .NET documentation. It serves as the input content repository in a three-repository architecture designed to transform authoritative sources into multiple token-budget formats for optimal LLM consumption.

## Repository Purpose

**Input Content Curation**: Human-curated, high-quality source materials that serve as the foundation for generating multiple output formats. This repository contains the "golden" references and validated Q&A pairs that ensure accuracy and completeness across all generated content.

**Key Principles**:

- Source authority tracking with provenance chains
- Human-LLM collaborative content creation
- Comprehensive validation and testing
- Token-efficient, embedding-optimized structure

## Architecture Overview

This repository is part of a three-repository system:

```text
llm-docs-workspace/
├── dotnet-golden-llm-docs/     # THIS REPO - Source curation and generation instructions
├── dotnet-docs-llm-tools/      # [PLACEHOLDER] - Reusable content generation pipeline
└── dotnet-docs-llms/           # [PLACEHOLDER] - LLM-consumable structured content only
```

### Repository Relationships

**dotnet-golden-llm-docs** (this repository):

- Contains authoritative source materials
- Maintains topic specifications and relationships
- Stores validation rules and quality criteria
- Never accessed directly by LLMs in production

## For LLMs and AI Agents

This repository is optimized for LLM consumption with structured topic specifications and relationship mapping.

**Quick Start:**

- Read [workflow.md](workflow.md) for complete usage guide
- Check [file-types.md](file-types.md) for file organization and artifact types
- See [format.md](format.md) for content formatting standards
- Browse [docs/repos.md](docs/repos.md) for repository registry
- Review [topic-spec-format.md](topic-spec-format.md) for topic specification structure

**Key Features:**

- Structured topic specifications with relationship mapping
- LLM-optimized content with no decorative formatting
- Centralized repository registry and source tracking
- Multi-layered organization: global → category → topic
- Consistent table formats for easy parsing
- URL type classification: raw/rendered/community

**dotnet-docs-llm-tools** *(planned)*:

- Automated content generation pipeline
- Template-driven multi-format output generation
- Embedding-based validation against golden references
- HAL+JSON index auto-generation

**dotnet-docs-llms** *(planned)*:

- Generated LLM-consumable content only
- Multiple token-budget formats (600/2400/4800 tokens)
- Hierarchical organization with auto-generated indexes
- Optimized for retrieval-augmented generation (RAG)

## Content Organization

See [docs/README.md](docs/README.md) for detailed information about document types, directory structure, and content organization.

## Quality Assurance

### Validation Pipeline

All content must pass validation before being used for generation:

1. **Source Integrity**: Provenance tracking with verification dates
2. **Code Validation**: All examples compile and run successfully
3. **Cross-Reference Accuracy**: Relationships and links verified
4. **Embedding Validation**: Generated content semantically matches golden references
5. **LLM Testing**: Zero-shot accuracy testing using generated content

### Content Standards

- **Authority**: All claims backed by official sources
- **Currency**: Reflects latest stable versions and best practices
- **Completeness**: Covers 80% of common scenarios per topic
- **Precision**: Each document addresses exactly its stated scope
- **Testability**: All code examples are verified working

## Current Status

### Pilot Topic: File-Based Apps

The file-based apps topic serves as the proof-of-concept for the entire architecture:

- ✅ **Complete content set**: All document types implemented
- ✅ **Format standards**: Q&A format guide established
- ✅ **Validation testing**: Critical scenarios verified
- ✅ **Token optimization**: Content sized for embedding efficiency

### Next Steps

1. **Format standardization**: Complete format guides for all document types
2. **Pipeline development**: Build automated generation tools
3. **Content expansion**: Add 2-3 additional pilot topics
4. **Validation automation**: Implement embedding-based quality testing

## Contributing

This repository uses human-LLM collaborative authoring:

1. **Human curation**: Topic specifications, source authority, quality standards
2. **LLM assistance**: Content expansion, format consistency, example generation
3. **Human validation**: Accuracy verification, relationship mapping, final approval

See individual format guides in the `docs/` directory for specific authoring standards.

## Related Documentation

- [Content Generation Plan](docs_llm/CONTENT-GENERATION-PLAN.md): Detailed architecture and implementation plan
- [Q&A Format Guide](docs/qa-pairs-format.md): Standards for question-answer content
- [File-Based Apps Pilot](docs/cli/file-based-apps/): Complete example of the content format
