# Document Chunking Specification

## Overview

Document chunking transforms large markdown documents into semantically-organized, retrievable fragments. Instead of creating a separate consumption graph, chunks are stored in-place alongside their source documents, with metadata in `index.json` enabling efficient retrieval.

## Core Principles

- **In-place chunking**: Chunks stored in subdirectories alongside source documents
- **Build-time MMR**: Stripe ordering provides Maximal Marginal Relevance without runtime computation
- **Semantic organization**: Similarity-based ordering relative to baseline chunk
- **Progressive disclosure**: Request N chunks, get representative N-width sample
- **Pre-computed relationships**: All embeddings and similarities calculated at build time

## Chunking Process

### 1. Source Documents

Initial implementation targets:

- `golden-reference.md` (primary)
- `qa-pairs.md` (future enhancement)

### 2. Chunk Generation

**Chunking Algorithm**: Documents are chunked using the semantic chunking algorithm from the Common.Chunking library. See [semantic-chunking-chunkeval.md](semantic-chunking-chunkeval.md) for complete algorithm specification.

**Storage pattern**:

```text
docs/libraries/system-text-json-source-generation/
  ├── golden-reference.md
  ├── _chunks/
  │   ├── golden-reference-0.md    # Overview (baseline)
  │   ├── golden-reference-1.md.   # Quick Reference (technical baseline)
  │   ├── golden-reference-2.md
  │   └── ...
  ├── _keywords/
  │   └── words.md
  ├── topic-spec.md
  └── index.json
```

**Persistence**:

- Chunks written as markdown files in `_chunks/` directory
- Numbered sequentially in document order (0, 1, 2, ...)
- Chunk 0 is always the overview/introduction section (baseline)
- Chunk 1 may be "Quick Reference" (technical baseline, if present)

### 3. Embedding Generation and Caching

**Embedding generation**:

1. Generate embeddings for all chunks using configured model
2. Calculate similarity of each chunk to baseline(s)
3. Extract keywords present in chunk from pre-computed `_keywords/words.md`
4. Use existing authority scores (no chunk-specific computation needed)

**Caching strategy** (reuse Common.EmbeddingCache):

Cache structure:

```text
.embedding-cache/
  {chunking-strategy}/          # e.g., "semantic-250-750"
    {model-name}/               # e.g., "mxbai-embed-large"
      {file-hash}/              # SHA256 (first 16 chars) of source file
        metadata.json           # FileMetadata record
        chunk-0.bin             # Float array (binary)
        chunk-1.bin
        ...
```

**Cache key components**:

- `ChunkingStrategy.GetCacheKey()` - identifies chunking approach
- Model name - embedding model identifier
- File hash - computed from source file content (SHA256)

**Cache validation**:

- Model name must match
- Chunking strategy must match
- Chunk count must match
- On mismatch → cache miss → regenerate embeddings

**Benefits**:

- Skip embedding generation for unchanged documents
- Strategy-specific caching (can coexist with different chunk sizes)
- Model-specific caching (different models won't conflict)
- Automatic invalidation on document changes

**Rationale for baseline-only comparisons**:

- Reduces computation from O(n²) to O(n)
- Baseline (chunk 0) represents topic overview/essence
- Sufficient for MMR-style ordering

### 4. Stripe Ordering (Build-time MMR)

**Minimum threshold**: Only apply striping if chunk count ≥ 8. Below this threshold, use simple similarity ordering.

**Stripe factor calculation**:

```text
if chunk_count < 8:
    stripe_factor = 1 (no striping, just ordered by similarity)
else:
    stripe_factor = max(2, min(chunk_count/2, round(√chunk_count)))
```

**Examples**:

- 7 chunks → no striping (factor = 1)
- 8 chunks → factor = 3
- 12 chunks → factor = 4
- 16 chunks → factor = 4
- 25 chunks → factor = 5

**Algorithm**:

1. Order chunks 1-N by similarity to baseline
2. If chunk_count < 8: Use ordered list as stripe_order
3. Otherwise: Apply median-picking stripe pattern with calculated factor
4. Store stripe_order in index.json

**Stripe pattern** (12 chunks, factor = 4 example):

```text
Stripe 1: chunks 1, 5, 9      (every 4th, offset 0)
Stripe 2: chunks 2, 6, 10     (every 4th, offset 1)
Stripe 3: chunks 3, 7, 11     (every 4th, offset 2)
Stripe 4: chunks 4, 8, 12     (every 4th, offset 3)
```

**Retrieval behavior**:

- Request 3 chunks → Return stripe 1 → [1, 5, 9] (maximum diversity)
- Request 6 chunks → Return stripes 1-2 → [1, 5, 9, 2, 6, 10]
- Request 12 chunks → Return all stripes → [1, 5, 9, 2, 6, 10, 3, 7, 11, 4, 8, 12]

**Rationale**:

- Minimum threshold avoids unnecessary complexity for small documents
- Dynamic factor scales with document size
- Avoids surfacing niche content first (problem with pure distance-based ordering)
- Balances relevance (to baseline) with diversity (spacing)
- Deterministic, reproducible ordering
- No runtime MMR computation needed

### 5. Code vs Non-Code Classification

**Classification rule**:

- Count total lines in chunk
- Count lines within fenced code blocks (any language)
- If code_lines / total_lines > 0.5 → classify as "code"
- Otherwise → classify as "non-code"

**Purpose**:

- Enables code-focused vs concept-focused retrieval strategies
- Stored as `is_code` boolean in chunk metadata

### 6. Query Expansion via Prompt Matching (Experimental)

**Concept**: Pre-compute query-to-chunk mappings at build time, enabling fast retrieval without runtime vector search. This is a static implementation of "Document Expansion" / "indexing-time query generation" techniques like HyDE.

**Algorithm**:

1. Extract questions from `qa-pairs.md` as representative queries
2. Generate embeddings for all questions (with caching)
3. For each chunk:
   - Calculate cosine similarity between chunk embedding and all question embeddings
   - Store SimHash of questions that exceed similarity threshold
   - Threshold TBD (requires experimentation)

4. Store in chunk metadata:

```json
{
  "index": 0,
  "href": "_chunks/golden-reference-0.md",
  "prompt_hashes": [18446744073709551615, 12345678901234567890]
}
```

**Retrieval flow**:

1. User submits query
2. Generate SimHash of query (fast, no embedding needed)
3. Compare query SimHash against stored `prompt_hashes` (fast bitwise operations)
4. Return chunks with matching hashes

**Benefits**:

- O(1) hash comparison vs O(n) vector similarity
- No runtime embedding generation for simple queries
- Static, pre-computed like rest of system
- Falls back to embedding-based search when no hash matches

**Open questions** (requires testing):

- **Similarity threshold**: What cutoff maximizes precision/recall?
- **Top-k vs threshold**: Store top-k questions per chunk, or all above threshold?
- **Hash collisions**: How often do different questions hash to same value?
- **Coverage**: What % of real queries match pre-computed prompts?

**Status**: Experimental. Requires validation before production use.

### 7. Technical Baseline Detection

**Quick Reference detection**:

- After chunking, examine chunk 1 title/heading
- If title contains "Quick Reference", "API Reference", or similar → use as technical baseline
- Otherwise, no separate technical baseline

**Dual-baseline striping** (when Quick Reference detected):

1. **Conceptual stripe**: Order chunks by similarity to chunk 0 (Overview)
   - Suitable for prose-heavy, conceptual content
   - Stored as `stripe_order` in `_embedded.chunks`

2. **Technical stripe**: Order chunks by similarity to chunk 1 (Quick Reference)
   - Suitable for code-heavy, API-focused content
   - Stored as `stripe_order_technical` in `_embedded.chunks`

**Single-baseline fallback** (no Quick Reference):

- Only use chunk 0 as baseline
- Generate single `stripe_order`
- `stripe_order_technical` field omitted

## Index.json Schema Extensions

### Chunk Metadata in _embedded

Add chunks to the `_embedded` section of index.json:

```json
{
  "id": "libraries/system-text-json-source-generation",
  "title": "System.Text.Json Source Generation",
  "_links": {
    "self": { "href": "/libraries/system-text-json-source-generation/index.json" },
    "parent": { "href": "/libraries/index.json" }
  },
  "_embedded": {
    "topics": [],
    "chunks": {
      "golden-reference": {
        "source": "golden-reference.md",
        "count": 12,
        "baseline_conceptual": 0,
        "baseline_technical": 1,
        "stripe_order": [1, 5, 9, 2, 6, 10, 3, 7, 11, 4, 8, 12],
        "stripe_order_technical": [2, 7, 11, 3, 8, 12, 4, 9, 5, 10, 6],
        "items": [
          {
            "index": 0,
            "href": "_chunks/golden-reference-0.md",
            "title": "Overview",
            "is_code": false,
            "similarity_conceptual": 1.0,
            "similarity_technical": 0.75,
            "prompt_hashes": [18446744073709551615, 12345678901234567890],
            "keywords": [
              {
                "name": "source generation",
                "score": 7
              },
              {
                "name": "compile-time",
                "score": 9
              }
            ]
          },
          {
            "index": 1,
            "href": "_chunks/golden-reference-1.md",
            "title": "Quick Reference",
            "is_code": true,
            "similarity_conceptual": 0.82,
            "similarity_technical": 1.0,
            "keywords": [
              {
                "name": "naming policies",
                "score": 4
              }
            ]
          }
        ]
      }
    }
  }
}
```

**Schema notes**:

- Chunks placed in `_embedded.chunks` to match HAL+JSON pattern
- `baseline_conceptual`: Index of conceptual baseline chunk (always 0)
- `baseline_technical`: Index of technical baseline chunk (1 if Quick Reference detected, otherwise omitted)
- `stripe_order`: Conceptual ordering (similarity to chunk 0)
- `stripe_order_technical`: Technical ordering (similarity to chunk 1), omitted if no technical baseline
- `is_code`: Boolean indicating if chunk is >50% code blocks
- `similarity_conceptual`: Similarity to baseline_conceptual
- `similarity_technical`: Similarity to baseline_technical (omitted if no technical baseline)
- `prompt_hashes`: Array of SimHash values for matched questions (experimental, optional)
- `items`: Array of chunk metadata

### Keyword Authority

Chunks reference pre-computed keyword scores from `_keywords/words.md`. Each chunk includes only the keywords present in that chunk, with their global authority scores.

**Format** (matches existing topic-level keyword format):

```json
{
  "keywords": [
    {
      "name": "source generation",
      "score": 7
    }
  ]
}
```

**Fields**:

- **name**: Keyword from global authority table (`_keywords/words.md`)
- **score**: Pre-computed authority score (from global table)

**Extraction process**:

1. For each chunk, scan for keywords from `_keywords/words.md`
2. Include only keywords that appear in the chunk
3. Use the pre-computed score from the global table (no chunk-specific calculation)

**Purpose**:

- Enables keyword-based chunk filtering and retrieval
- Maintains consistency with existing topic-level keyword format
- Simple, static representation requiring no runtime computation

## Tool Responsibilities

### ChunkingTool (New)

**Purpose**: Generate chunks from source documents

**Operations**:

1. Parse markdown into semantic sections using Common.Chunking
2. Generate chunk files in document order
3. Classify each chunk as code/non-code (>50% lines in code blocks)
4. Detect Quick Reference in chunk 1 (title matching)
5. Output: Chunk files in `_chunks/` subdirectory

**Input**: Source document path

**Output**: Directory of numbered chunk files with metadata (title, is_code)

### TopicSpec (Enhanced)

**Purpose**: Calculate embeddings and similarities

**Operations**:

1. Read all chunks for a topic (including is_code metadata)
2. Generate embeddings with caching (Common.EmbeddingCache)
3. Calculate similarity to chunk 0 (conceptual baseline)
4. If Quick Reference detected: Calculate similarity to chunk 1 (technical baseline)
5. Extract keywords present in chunks (from `_keywords/words.md`)
6. Use pre-computed scores from global keyword table (no chunk-specific calculation)
7. **(Experimental)** Query expansion via prompt matching:
   - Extract questions from `qa-pairs.md`
   - Generate embeddings for questions (with caching)
   - For each chunk: find similar questions above threshold
   - Generate SimHash for matched questions
8. Normalize to `topic-spec.md`

**Input**: Topic directory with chunks, metadata, `_keywords/words.md`, and optionally `qa-pairs.md`

**Output**: Updated `topic-spec.md` with chunk metadata (similarities, keywords with scores, is_code, optional prompt_hashes)

### IndexTool (Enhanced)

**Purpose**: Generate graph representation with chunks

**Operations**:

1. Read chunk metadata from `topic-spec.md` (similarities, keywords with scores, is_code, optional prompt_hashes)
2. Apply stripe ordering algorithm for conceptual baseline (chunk 0)
3. If Quick Reference present: Apply stripe ordering for technical baseline (chunk 1)
4. Generate HAL+JSON `index.json` with `_embedded.chunks` section
5. Include keywords with pre-computed scores from global table
6. Include is_code classification for each chunk
7. **(Experimental)** Include prompt_hashes if present

**Input**: Topic directory with `topic-spec.md`

**Output**: `index.json` with chunk metadata in `_embedded.chunks`

## Deployment

**Web server requirements**:

- Serve `index.json` for graph navigation
- Serve chunk files at paths specified in `chunks[].href`
- Support range requests for efficient retrieval
- Enable CORS for cross-origin access

**Example retrieval flow**:

1. Client fetches `index.json`
2. Reads `_embedded.chunks.golden-reference.stripe_order` or `stripe_order_technical`
3. Requests first N chunks from chosen stripe order
4. Fetches chunk files via `_embedded.chunks.golden-reference.items[].href`

## Benefits

- **No consumption graph**: Chunks stored with source content
- **Static computation**: All similarity calculated at build time
- **Progressive disclosure**: Request any number of chunks, get representative sample
- **Keyword matching**: Enables keyword-based chunk filtering using global authority scores
- **Code classification**: Enables filtering for code-heavy vs conceptual content
- **Fast query matching** (experimental): SimHash-based retrieval without runtime embeddings
- **Uniform tooling**: Same tools work on chunked and non-chunked content
- **Simple deployment**: Standard file serving, no special runtime
- **MMR-like diversity**: Build-time striping provides balanced retrieval without runtime computation
- **Dual-baseline flexibility**: Conceptual or technical ordering based on content type
- **Embedding cache**: Avoid re-computing embeddings for unchanged documents

## Shared Libraries

- **Common.Chunking**: Provides semantic chunking algorithm
- **Common.EmbeddingCache**: File-based embedding cache with strategy/model isolation
- **Common.LlmInfrastructure**: Embedding generation infrastructure
- **KeywordExtractor**: Generates `_keywords/words.md` authority tables

## Related Specifications

- [semantic-chunking-chunkeval.md](semantic-chunking-chunkeval.md): Detailed chunking algorithm
- [overview.md](overview.md): Information Graph Architecture overview
