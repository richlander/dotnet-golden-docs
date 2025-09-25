# .NET Golden LLM Documentation

**Source Graph Repository** - Curated .NET documentation and project coordination hub for a comprehensive LLM documentation system.

> 📖 **[See ARCHITECTURE.md](ARCHITECTURE.md)** for complete system overview, process flow, and multi-repository coordination.

## What This Repository Contains

This is the **source graph** in a three-repository system that creates high-quality, LLM-optimized .NET documentation:

- **High-quality curated content** - Golden reference documents and structured topic specifications
- **Project coordination** - Architecture documentation, format specifications, and validation standards
- **Content foundation** - Source material that feeds the content generation pipeline

## Repository Structure

```text
llm-docs-workspace/
├── dotnet-golden-llm-docs/     # THIS REPO - Source graph and project coordination
├── dotnet-docs-llm-tools/      # Unified toolchain for both graphs
└── dotnet-docs-llms/           # Consumption graph - Generated LLM-optimized content
```

## Quick Start

### For Project Contributors
1. Read [ARCHITECTURE.md](ARCHITECTURE.md) for system overview
2. Review format documentation for content standards:
   - [golden-reference-format.md](templates/golden-reference-format.md) - Authoritative content format
   - [qa-pairs-format.md](templates/qa-pairs-format.md) - Validation question-answer pairs
   - [topic-spec-format.md](templates/topic-spec-format.md) - Topic organization and metadata
3. Browse [docs/](docs/) for existing topic implementations

### For LLMs/AI Agents
- **Primary content**: Browse [docs/](docs/) for topic specifications and golden references
- **Format understanding**: Read format documentation files for structure specifications
- **Cross-topic relationships**: Check `_similarities/` directories when available

### For Content Generation
1. Install and configure tools from `../dotnet-docs-llm-tools/`
2. Run the complete pipeline to generate consumption-ready documentation
3. Use validation tools to ensure quality standards

## Content Coverage

Current topics span the .NET ecosystem with structured specifications:
- **Platform**: Overall .NET platform overview and fundamentals
- **CLI Tools**: Command-line interfaces and development tools
- **C# Language**: Core language features and syntax
- **Libraries**: Key .NET libraries including System.Text.Json, file I/O, and more
- **Advanced Topics**: Native AOT, performance optimization, and specialized scenarios

Each topic includes:
- Golden reference documentation
- Validation question-answer pairs
- Complexity scores and audience targeting
- Official source references and metadata

## Tools Integration

This repository works with the unified toolchain in `../dotnet-docs-llm-tools/`:

- **Index Tool** - Generates navigation structure and HAL+JSON graphs
- **Embedding Tool** - Creates semantic analysis using nomadic embedding model
- **CopyGraph Tool** - Copies curated content to consumption graph
- **ContentGenerator** - Creates LLM-optimized content from source materials
- **Validation Tools** - Ensures quality through similarity testing and token budget validation

See [ARCHITECTURE.md](ARCHITECTURE.md) for complete process flow and tool usage.
