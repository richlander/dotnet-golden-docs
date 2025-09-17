# AI-First Documentation Architecture for .NET

## Overview
A multi-pass, build-time documentation processing pipeline that transforms curated source content into an AI-optimized knowledge graph. The system emphasizes rigorous templating, semantic understanding, and efficient retrieval for LLM augmentation.

## Architecture Principles
- **Build-time computation**: Expensive operations (embeddings, similarities) computed once during build, not at runtime
- **Fixed templates**: Standardized formats enable both human curation and LLM generation at scale
- **Semantic-first organization**: Graph relationships based on meaning, not just structure
- **Token budget awareness**: Content sized for LLM context windows (limits, not targets)
- **Multi-signal retrieval**: Combines lexical matching, semantic similarity, and graph traversal

## Repository Architecture

### Three-Repository Design
- **`dotnet-golden-llm-docs/`**: Private source content with human curation and embedding analysis
- **`dotnet-docs-llm-tools/`**: Public build pipeline for transforming source to output
- **`dotnet-docs-llms/`**: Public LLM-consumable structured content with navigable graph

### Hard Separation Principle
LLMs never access the source repository directly. All LLM interactions use the processed output repository, ensuring clean separation between curation and consumption.

## Pipeline Phases

### Phase 1: Source Content (Human + LLM Curated)
**Input**: Markdown files following fixed templates
**Templates**: `golden-reference.md`, `qa-pairs.md`, `sources.md`, `topic-spec.md`, `validation.md`
**Key Feature**: Each topic includes a curated `sources.md` with high-quality references, enabling LLM copy-cat generation for new topics

### Phase 2: Embedding Generation
**Process**: Single-pass embedding computation with semantic analysis
**Outputs**:
- `.embedding` files for each markdown document
- `semantic-neighbors/` directory with relationship analysis
- Token counts per document
- Statistical thresholds (P75) for meaningful relationships

**Key Innovation**: All embedding computation happens once at build time, not during retrieval

### Phase 3: Knowledge Graph Construction
**Process**: Build navigable hypermedia graph from semantic relationships
**Outputs**: HAL+JSON indexes with:
- Topic nodes with metadata (category, complexity, priority)
- Weighted edges from semantic similarities
- Hierarchical organization (uber topics → categories → features)
- Pre-computed relationship strengths for navigation

### Phase 4: LLM-Optimized Output Generation
**Process**: Template-driven content generation with token budgets
**Templates**:
- `one-shot-600.md` (essential knowledge)
- `one-shot-2400.md` (comprehensive coverage)
- `examples-600.md` (minimal code samples)
- `troubleshooting.md` (problem-solving focused)

**Key Feature**: Content stops when quality drops rather than padding to reach token targets

### Phase 5: Retrieval and Augmentation
**Process**: Multi-signal graph retrieval system
**Workflow**:
1. Tool performs lexical analysis of environment (project properties, errors)
2. Tool generates candidate topics using graph traversal + pre-computed similarities
3. LLM re-ranks candidates with semantic understanding
4. Tool downloads selected subgraph to local machine
5. Downloaded content forms coherent local graph for offline LLM processing

## Key Innovations

### Separation of Concerns
- **Lexical search** (tool): Fast, deterministic, based on word matching
- **Semantic understanding** (LLM): Contextual, nuanced, based on meaning
- **Graph navigation** (pre-computed): Efficient traversal using build-time similarities

### Scalability Through Templates
Once 2-3 exemplar topics are perfected, LLMs can generate new topics following the same patterns, using the curated sources as authoritative input. This "copy-cat" model ensures consistency while dramatically reducing manual effort.

### Runtime Efficiency
By pre-computing embeddings and similarities at build time, the runtime tool needs no GPU or embedding infrastructure. It simply navigates the pre-computed graph using lexical matching and stored similarity scores.

## Use Case: Modern Feature Documentation
**Scenario**: Developer uses `PublishAot=true` in project file (feature released after LLM training cutoff)

1. Tool detects "PublishAot" property lexically
2. Searches graph for ["publish", "aot", "native", "compilation"] matches
3. Returns candidates with similarity scores from pre-computed graph
4. LLM recognizes semantic intent and re-ranks native AOT documentation higher
5. Tool downloads native AOT subgraph with related topics (publishing, performance, limitations)
6. LLM augments its response with current, authoritative documentation

## Architectural Benefits
- **Deterministic retrieval**: Same inputs produce same candidate sets
- **Explainable ranking**: Clear signal separation between lexical/semantic/structural
- **Offline capability**: Downloaded subgraphs work without connectivity
- **Version control friendly**: All artifacts are text-based (markdown, JSON)
- **LLM-agnostic**: Works with any LLM that can process JSON and markdown

## Quality Assurance
- **Human curation**: Source content maintained by domain experts
- **Template validation**: Consistent structure enforces quality standards
- **Semantic validation**: Generated content compared against golden references
- **Statistical rigor**: P75 thresholds ensure only meaningful relationships surface
- **Copy-cat generation**: New topics follow proven patterns from exemplars