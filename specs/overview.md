# Information Graph Architecture

A static knowledge graph system that transforms curated topic content into LLM-consumable documentation through derived insights and graph representation.

## Core Principles

**Human effort:** Concentrate on golden documents. Everything else derives.

**Quality incentives:** The system works on derived insight from quality content. Humans are incentivized to producing higher-quality content to make the tools work better. The tools are intended to be as simple as possible.

**Insight storage:** Derived data normalizes into topic-spec.md. Single format enables uniform tooling.

**Source/Consumption separation:** Source for authoring, consumption for LLM delivery. Same structure, different content, identical tooling.

**Static architecture:** No runtime computation except prompt hashing. Graph navigation is pure numeric comparison of pre-computed scores.

## Tool Development Pattern

New tools should:

1. Operate on topic-spec.md for input (normalized data layer)
2. Generate their own derived data
3. Normalize results back into topic-spec.md
4. Enable higher-level tools to consume uniformly

Graph-level tools consume index.json and traverse using weighted edges.

## Information Pyramid

### Layer 1: Topics (Foundation)

**Human effort concentrates here.** Topics are the raw materials.

- `golden-reference.md`: Primary representation, highest quality human-curated content
- `qa-pairs.md`: Question-answer validation pairs
- `topic-spec.md`: Normalized metadata and derived insights (curated + generated)

### Layer 2: Derived Insights (Middle)

**Tools extract and normalize.** Multiple tools derive insights from topics:

- Embedding-based similarities (semantic relationships)
- Low-entropy keywords (authority signals)
- Locality-sensitive hashes (search optimization)
- Complexity metrics (content characteristics)

All insights normalize into `topic-spec.md` within each topic. This creates uniform data structure for higher-level tools. Markdown serves as "web-native CSV with rich comments" - structured tables with context.

### Layer 3: Graph Representation (Top)

**HAL+JSON indexes.** Tools generate `index.json` files representing:

- Tree structure with branches
- Weighted directional edges (keyword-derived authority)
- Weighted unidirectional edges (embedding-derived similarity)
- Topic-to-topic navigation graph

### Layer 4: Content Generation

**Source → Consumption transformation.** Generator tool creates:

- Templated documents with token budgets (overview, one-shot, examples, etc.)
- New consumption graph with identical structure to source graph
- Same `index.json` schema, same similarity/authority scoring
- Only difference: templated, token-budgeted content optimized for LLM consumption

Same tools run on both graphs. Same structure, different content.

### Layer 5: Lexical Search

**Static hash-based retrieval.** Search tool navigates both graphs equally:

- LSH-based candidate discovery (hashes prompt, searches subset of branches)
- Weighted edge traversal (finds related topics)
- Scoring-based ranking (similarity + authority)
- No text comparison backbone (hash + scoring only)

**Only dynamic operation:** Hashing the search prompt. Everything else is comparing numbers.
