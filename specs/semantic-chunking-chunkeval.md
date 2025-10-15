# Semantic Chunking Specification

## Overview

This document specifies the sliding window semantic chunking algorithm used by varrious tools. The algorithm splits markdown documents at heading boundaries while respecting token constraints and maintaining semantic coherence.

## Design Goals

1. **Semantic Boundaries**: Chunks align with document structure (headings) rather than arbitrary token counts
2. **Context Preservation**: Include parent headings in chunks to maintain hierarchical context
3. **Retrieval Optimization**: Each major section (H2) gets prominence for better RAG performance
4. **Size Constraints**: Balance between too-small (lacking context) and too-large (overwhelming embeddings)
5. **Sliding Window**: Enable overlapping context while avoiding content duplication

## Token Constraints

| Constraint | Value | Purpose |
|------------|-------|---------|
| **minTokens** | 250 | Minimum chunk size for same/shallower heading boundaries |
| **minTokensDeeper** | 500 | Minimum chunk size when going deeper into subsections |
| **maxTokens** | 750 | Hard maximum - chunks are sealed immediately upon reaching this limit |

## Algorithm Rules

### 1. Heading Hierarchy Context

Every chunk includes parent headings for context:

```markdown
# System.Text.Json          <- H1 (parent context)
## Quick Start               <- H2 (chunk start)
### Installation             <- H3 (subsection)
Content here...
```

**Implementation**: Parent headings (levels < chunk start level) are prepended to the chunk content.

### 2. Two-Tier Minimum Token Strategy

The algorithm uses different minimum token thresholds based on heading transitions:

#### Same or Shallower Level (250 tokens)
When encountering a heading at the **same or shallower level** as the deepest heading seen:
- **Example**: H2 → H2, H3 → H2, H3 → H3
- **Threshold**: minTokens (250)
- **Rationale**: Natural section boundary; chunk has collected a complete semantic unit

#### Going Deeper (500 tokens)
When encountering a heading **deeper** than any seen so far:
- **Example**: H2 → H3, H1 → H2
- **Threshold**: minTokensDeeper (500)
- **Rationale**: Prevent sealing while diving into subsections; collect more context

### 3. H1 Special Rule

**Rule**: Chunks starting at H1 (document beginning) can only collect ONE H2 section.

**Behavior**:
- Seal at the second H2 heading, regardless of token count
- Ensures each H2 section gets prominence
- Prevents burying important sections in large introductory chunks

**Example**:
```markdown
# Document Title (H1)          <- Chunk 1 starts
Intro content...
## Quick Start (H2)            <- First H2, continue collecting
Content...
## Basic Use (H2)              <- Second H2, SEAL CHUNK 1 HERE

# Document Title (H1)          <- Chunk 2 starts (context)
## Basic Use (H2)              <- Continue...
```

### 4. Maximum Token Limit

**Rule**: If adding a line would exceed maxTokens (750), immediately seal the current chunk.

**Behavior**:
- Hard stop, no exceptions
- Prevents oversized chunks that degrade embedding quality
- Next chunk continues from the sealed position

### 5. Deepest Level Tracking

The algorithm tracks the **deepest heading level** seen in the current chunk to make smart sealing decisions.

**Example**:
```markdown
# H1 starts chunk (level 1)
## H2 (level 2, deepest = 2)
### H3 (level 3, deepest = 3)
### Another H3 (level 3, deepest still 3)
    → Compare: 3 <= 3 (same level)
    → Use minTokens (250) threshold
```

### 6. Position Tracking

**StartPosition**: Records the position in the **original source file** where the chunk's content begins (not including prepended parent headings).

**Purpose**: Enables mapping back to the source document and ensures chunks don't overlap in the original content.

## Algorithm Flow

### Initialization
```
currentChunkLines = []
currentTokens = 0
chunkStartPosition = 0
chunkStartLevel = null
deepestLevelInChunk = null
hasSeenH2 = false
headingHierarchy = {}
```

### Main Loop (for each line)

#### When encountering a heading:

1. **Check H1 special rule**:
   ```
   if (chunk started at H1) AND (current heading is H2) AND (already seen H2):
       SEAL CHUNK (hard boundary)
   ```

2. **Check two-tier strategy**:
   ```
   if heading level <= chunkStartLevel:
       // Same or shallower
       if tokens >= minTokens (250):
           SEAL CHUNK

   else if heading level <= deepestLevelInChunk:
       // Went deep, now coming back
       if tokens >= minTokens (250):
           SEAL CHUNK

   else:
       // Going deeper
       if tokens >= minTokensDeeper (500):
           SEAL CHUNK
   ```

3. **Update state**:
   - Update `headingHierarchy[level]`
   - Clear deeper levels from hierarchy
   - Update `deepestLevelInChunk` if deeper
   - Track `hasSeenH2` if level == 2

4. **Add heading to current chunk**

#### When encountering non-heading content:

1. **Check max tokens**:
   ```
   if (currentTokens + lineTokens) > maxTokens (750):
       SEAL CHUNK immediately
       START NEW CHUNK with this line
   ```

2. **Otherwise**: Add line to current chunk

#### When sealing a chunk:

1. Build chunk text with `BuildChunkWithHierarchy()`
2. Add to chunks collection
3. Reset state for new chunk:
   - Clear `currentChunkLines`
   - Reset `currentTokens = 0`
   - Set `chunkStartPosition` to current position
   - Set `chunkStartLevel` and `deepestLevelInChunk` to new heading level
   - Reset `hasSeenH2`

### Finalization

After processing all lines:
```
if currentChunkLines.Count > 0:
    if (tokens >= minTokens) OR (no chunks created yet):
        SEAL FINAL CHUNK
    else:
        // Skip undersized final chunk (typically "See also" sections)
```

## Examples

### Example 1: H1 Rule in Action

**Input**:
```markdown
# System.Text.Json
Overview content (100 tokens)

## Quick Start
Quick start content (200 tokens)

## Basic Serialization
Serialization content (150 tokens)
```

**Output**:
- **Chunk 1** (Position 0): H1 + Overview + Quick Start (300 tokens)
  - Sealed at "## Basic Serialization" due to H1 rule
- **Chunk 2** (Position X): H1 (context) + Basic Serialization (150 tokens)

### Example 2: Two-Tier Strategy

**Input**:
```markdown
## Configuration
Intro (100 tokens)

### Basic Setup
Content (100 tokens)

### Advanced Setup
Content (200 tokens)

### Performance
Content (150 tokens)

## Usage
Content (300 tokens)
```

**Output**:
- **Chunk 1** (starts at H2 "Configuration"):
  - Collects: Intro + Basic Setup (200 tokens)
  - At "### Advanced Setup": Going deeper (H2→H3), need 500 tokens
  - At "### Performance": Same level (H3→H3), need 250 tokens, but only have ~450
  - At "## Usage": Same as start (H2→H2), have 550 tokens, SEAL
- **Chunk 2** (starts at H2 "Usage"): Usage content

### Example 3: Max Token Limit

**Input**:
```markdown
## Large Section
Content line 1 (100 tokens)
Content line 2 (200 tokens)
Content line 3 (300 tokens)
Content line 4 (200 tokens) <- Adding this would reach 800 tokens
More content...
```

**Output**:
- **Chunk 1**: Lines 1-3 (600 tokens) - sealed before line 4
- **Chunk 2**: Line 4 onward

## BuildChunkWithHierarchy

This function adds parent heading context to each chunk:

1. **Identify chunk's starting heading**: Find first non-empty line, extract its level
2. **Collect parent headings**: From `headingHierarchy`, include all levels < chunk start level
3. **Combine**: Prepend parent headings + newline + chunk content

**Example**:
```
headingHierarchy = {
  1: "# System.Text.Json",
  2: "## Serialization"
}

chunkLines = [
  "### Custom Converters",
  "Content here..."
]

Output:
"# System.Text.Json
## Serialization
### Custom Converters
Content here..."
```

## Heading Extraction for Display

When displaying chunks in reports, two headings are extracted:

### Document Title (H1)
- **Purpose**: Show which document the chunk came from
- **Extraction**: First H1 heading in the chunk text
- **Display**: Limited to 40 characters

### Retrieved Chunk (Target Heading)
- **Purpose**: Show the specific section the chunk represents
- **Extraction**: First heading after parent context that has content
- **Logic**:
  - If first heading has deeper level than subsequent heading, return the deeper one
  - This skips parent context headings to find the actual target
- **Display**: Limited to 60 characters

## Edge Cases

### 1. Documents without headings
- Treated as single chunk starting at position 0
- No parent context to prepend

### 2. Very small final chunks
- Final chunks < minTokens are skipped
- **Exception**: If it's the only chunk in the document, include it anyway

### 3. H1 rule with insufficient tokens
- H1 rule is a hard boundary - seal regardless of token count
- Ensures H2 sections get proper isolation

### 4. Chunks split mid-section by maxTokens
- StartPosition continues from where previous chunk stopped
- Parent headings are re-prepended for context
- This creates a "sliding window" effect

## Performance Characteristics

- **Time Complexity**: O(n) where n is number of lines in document
- **Space Complexity**: O(m) where m is size of largest chunk
- **Token Counting**: Uses heuristic approximation (words × 1.3)
- **No Lookahead**: Algorithm makes decisions based on current state only

## Rationale

### Why Two-Tier Minimums?

**Problem**: Using a single minimum (250 tokens) causes premature sealing when diving into H3 subsections.

**Example without two-tier**:
```markdown
## Overview (H2)
Brief intro (50 tokens)
### Setup (H3) <- Only 50 tokens, but would seal here
```

**Solution**: Require 500 tokens when going deeper, ensuring substantial content before splitting.

### Why H1 Special Rule?

**Problem**: Documents typically have one H1 with multiple important H2 sections. Without this rule, the first chunk could consume H1 + multiple H2s, burying later sections.

**Solution**: Limit H1 chunks to one H2 section, giving each H2 prominence.

### Why Track Deepest Level?

**Problem**: Need to distinguish "going deeper" (H2→H3) from "returning to same level" (H3→H3 after seeing H3).

**Solution**: Track deepest level seen; when a heading is ≤ deepest, we're at a natural boundary (use 250 token minimum).

## Future Considerations

- **Configurable thresholds**: Allow tuning min/max tokens per document collection
- **Language-specific tokenization**: Replace heuristic with proper tokenizer
- **Lookahead optimization**: Check upcoming headings to avoid awkward splits
- **Section metadata**: Preserve heading IDs, anchor links, etc.
