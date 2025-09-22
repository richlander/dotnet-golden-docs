# .NET Golden LLM Documentation

This repository contains curated .NET documentation with structured topic specifications, semantic analysis, and embedding-based content organization for LLM consumption.

## What This Is

Structured .NET Knowledge Base: 12+ comprehensive topic specifications covering the .NET ecosystem, from C# language features to CLI tools, with semantic relationship mapping and embedding-based similarity analysis.

Key Features:
- Topic specifications with metadata, sources, and relationships
- Semantic embedding and similarity analysis
- LLM-optimized content structure
- Automated cross-topic relationship discovery

## Repository Structure

```text
llm-docs-workspace/
├── dotnet-golden-llm-docs/     # THIS REPO - Curated content with topic specs
└── dotnet-docs-llm-tools/      # Embedding and similarity analysis tools
```

dotnet-golden-llm-docs (this repository):
- Topic specifications with official sources and metadata
- Structured content for 12+ .NET topics
- Generated embeddings and similarity analysis in `_embeddings/` and `_similarities/`

dotnet-docs-llm-tools:
- Embedding generation and management
- Semantic similarity analysis
- Cross-topic relationship discovery

## Getting Started

For LLMs/AI Agents:
- Browse [docs/](docs/) for topic specifications
- Read [topic-spec-format.md](topic-spec-format.md) for structure
- Check `_similarities/` directories for cross-topic relationships

For Humans:
- See [docs/topic-spec.md](docs/topic-spec.md) for the platform overview
- Review individual topic specs like [docs/csharp/topic-spec.md](docs/csharp/topic-spec.md)
- Use the embedding tools in `../dotnet-docs-llm-tools/` for analysis

## Content Organization

- Platform: [docs/topic-spec.md](docs/topic-spec.md) - Overall .NET platform
- Categories: CLI, C# Language, Libraries, etc.
- Topics: 12+ specific areas like file-based apps, System.Text.Json, Native AOT
- Metadata: Complexity scores, audience, version info, official sources

## Tools Usage

The embedding tools provide semantic analysis capabilities:

```bash
# Generate embeddings for all content
cd ../dotnet-docs-llm-tools
dotnet run -- update-embeddings --path ./docs

# Generate similarity analysis
dotnet run -- update-similarities --path ./docs

# Clean all generated files
dotnet run -- clean --path ./docs
```

Generated files:
- `_embeddings/` - Per-file and topic-level embeddings
- `_similarities/` - Cross-topic relationship analysis
- `embedding-model.txt` - Model configuration

## Topic Coverage

Current topics include C# language features, CLI tools, and core libraries, with complexity ratings and audience targeting for LLM training optimization.
