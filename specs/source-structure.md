# Source Repository Structure and Data Flow

## Repository Organization

### Hierarchical Knowledge Graph
The source repository follows a hierarchical structure with uber topics, categories, and individual features:

```
dotnet-golden-llm-docs/
├── index.json                      # Knowledge graph definition
├── embedding-model.txt              # Declared embedding model
├── dotnet/                          # Uber .NET topic
├── csharp/                          # Uber C# topic
├── cli/                             # CLI category
├── libraries/                       # Libraries category
├── runtime/                         # Runtime category
└── cross-cutting/                   # Cross-category topics
```

### Topic Structure
Each topic directory contains a standardized set of files:

```
{category}/{topic-id}/
├── topic-spec.md                    # Feature relationships and metadata
├── topic-spec.md.embedding          # Vector representation
├── topic-spec.md.tokencount         # Token count
├── golden-reference.md              # Comprehensive reference baseline
├── golden-reference.md.embedding    # Vector representation
├── golden-reference.md.tokencount   # Token count
├── qa-pairs.md                      # Structured Q&A with metadata
├── qa-pairs.md.embedding            # Vector representation
├── qa-pairs.md.tokencount           # Token count
├── sources.md                       # Authoritative source references
├── sources.md.embedding             # Vector representation
├── sources.md.tokencount            # Token count
├── validation.md                    # Testing requirements
├── validation.md.embedding          # Vector representation
├── validation.md.tokencount         # Token count
└── semantic-neighbors/              # Relationship analysis
    ├── self.md                      # Within-topic similarities
    ├── {other-category}.md          # Cross-category relationships
    └── metadata.json                # Statistical thresholds (categories only)
```

## Document Templates

### Topic Specification (topic-spec.md)
Defines feature relationships, hierarchy, and generation hints:
- **Feature description**: What the feature is and its purpose
- **Relationships**: Enables, conflicts with, alternatives, prerequisites
- **Hierarchy**: Category, complexity, audience, priority
- **Generation hints**: What to emphasize and avoid
- **Critical limitations**: Key constraints to communicate

### Golden Reference (golden-reference.md)
Comprehensive reference document serving as validation baseline:
- **Overview**: Complete conceptual explanation
- **Essential syntax & examples**: Core code patterns
- **Relationships & integration**: Ecosystem connections
- **Common scenarios**: Real-world usage patterns
- **Gotchas & limitations**: Critical knowledge
- **See also**: Natural cross-references

### Q&A Pairs (qa-pairs.md)
Structured question-answer pairs with rich metadata:
- **JSON frontmatter**: difficulty, validation, topics, audience, source-authority, last-verified
- **Question-answer format**: Natural language Q&A
- **Code examples**: Working code with explanations
- **Validation notes**: How to verify correctness

### Sources (sources.md)
Authoritative source references and provenance:
- **Primary sources**: Official documentation with verification dates
- **Secondary sources**: High-quality community content
- **Validation requirements**: Testing and verification standards

### Validation (validation.md)
Testing requirements and validation rules:
- **Validation requirements**: How to verify content accuracy
- **Testing standards**: Compilation, runtime, cross-platform requirements

## Semantic Analysis Structure

### Within-Topic Analysis (semantic-neighbors/self.md)
Two-column markdown table showing file similarities:
```markdown
| Neighbor | Similarity |
|----------|------------|
| golden-reference.md | 1.0000 |
| qa-pairs.md | 0.7492 |
| topic-spec.md | 0.7109 |
```
**Coverage**: ALL files within the topic (no filtering)

### Cross-Category Analysis (semantic-neighbors/{category}.md)
Format depends on analysis level:

**Topic level** (2-column):
```markdown
| Neighbor | Similarity |
|----------|------------|
| csharp/scripting | 0.8700 |
| csharp/console-apps | 0.7500 |
```

**Category level** (3-column):
```markdown
| Topic (cli) | Neighbor (csharp) | Similarity |
|-------------|-------------------|------------|
| cli/file-based-apps | csharp/scripting | 0.8700 |
| cli/native-aot | csharp/compilation | 0.8200 |
```
**Coverage**:

- **TARGET**: P70 (70th percentile)
- **SIMILARITY**: Similarity at applied threshold (after threshold algorithm)
- **Include relationships**: >= applied threshold
- **Algorithm**: Try P70 first (need ≥6 items), fallback to P60, then P50
- **Distribution reporting**: 5-value system (P50, P60, P70, P80, P90)
  - If P70 successful: Show [P70, P80, P90] (conditional on dataset size)
  - If P60 fallback: Show [P60] only
  - If P50 fallback: Show [P50] only
- **Minimum dataset requirements**:
  - P80: Requires ≥30 items for meaningful reporting
  - P90: Requires ≥60 items for meaningful reporting

### Statistical Metadata (metadata.json)
Category-level statistical analysis with new distribution schema:
```json
{
  "generatedOn": "2025-09-18T05:34:37.492482Z",
  "nodes": {
    "cli": {
      "percentile": 0.7,
      "similarity": 0.6234,
      "totalPairs": 100,
      "distribution": [
        {"percentile": 0.7, "count": 30},
        {"percentile": 0.8, "count": 20},
        {"percentile": 0.9, "count": 10}
      ]
    },
    "csharp": {
      "percentile": 0.5,
      "similarity": 0.5226,
      "totalPairs": 5,
      "distribution": [
        {"percentile": 0.5, "count": 3}
      ]
    }
  }
}
```

## Index Schema

### HAL+JSON Structure
Each directory with content contains an `index.json` file defining its structure and relationships:

```json
{
  "kind": "topic-index",
  "title": "File-based Apps",
  "description": "Single .cs file execution without project structure",
  "category": "CLI",
  "complexity": "beginner to intermediate",
  "priority": 2,
  "links": {
    "self": { "href": "cli/file-based-apps/index.json" },
    "similarities": {
      "within_topic": {
        "href": "_similarities/self.md",
        "baseline": "golden-reference.md",
        "total_files": 5
      },
      "cross_category": {
        "metadata": {
          "href": "_similarities/metadata.json",
          "generated_on": "2025-09-18T03:05:08.844564Z"
        },
        "relationships": [
          {
            "category": "csharp",
            "href": "_similarities/csharp.md",
            "percentile": 0.75,
            "threshold": 0.662,
            "total_pairs": 20,
            "above_threshold": 6,
            "items": [
              { "topic": "csharp/scripting", "similarity": 0.8700 },
              { "topic": "csharp/console-apps", "similarity": 0.7500 }
            ]
          },
          {
            "category": "dotnet",
            "href": "_similarities/dotnet.md",
            "percentile": 0.90,
            "threshold": 0.785,
            "total_pairs": 11,
            "above_threshold": 3,
            "items": [
              { "topic": "dotnet/publishing", "similarity": 0.8200 }
            ]
          }
        ]
      }
    }
  },
  "embedded": {
    "documents": [
      {
        "name": "topic-spec",
        "type": "markdown",
        "title": "Topic Specification",
        "links": { "self": { "href": "cli/file-based-apps/topic-spec.md" } }
      },
      {
        "name": "golden-reference",
        "type": "markdown",
        "title": "Golden Reference",
        "links": { "self": { "href": "cli/file-based-apps/golden-reference.md" } }
      }
    ],
    "topics": null
  },
  "metadata": {
    "generated_on": "2025-09-18T02:13:03Z",
    "generated_by": "IndexTool"
  }
}
```

### Schema Elements

**Top-level links**: Files that the topic node contains
- **`self`**: Reference to this index file
- **`similarities`**: Related topics with pre-computed vector similarity scores

**Embedded section**: Children of this node
- **`documents`**: Markdown files within this topic directory
- **`topics`**: Child topic directories (null for leaf topics, array for categories)

**Key distinction**:
- **`links.similarities`**: Horizontal relationships to peer topics via vector similarity
- **`embedded.topics`**: Vertical relationships to child topics
- **`embedded.documents`**: Files owned by this specific topic

### Category vs Topic Indexes

**Category-level index** (e.g., `cli/index.json`):
```json
{
  "kind": "topic-index",
  "title": "cli",
  "embedded": {
    "documents": [
      {
        "name": "golden-reference",
        "type": "markdown",
        "title": "CLI Golden Reference",
        "links": { "self": { "href": "cli/golden-reference.md" } }
      },
      {
        "name": "topic-spec",
        "type": "markdown",
        "title": "CLI Topic Specification",
        "links": { "self": { "href": "cli/topic-spec.md" } }
      }
    ],
    "topics": [
      {
        "name": "file-based-apps",
        "title": "File-based Apps",
        "category": "CLI",
        "complexity": "beginner to intermediate",
        "priority": 2,
        "links": {
          "self": { "href": "cli/file-based-apps/index.json" }
        }
      },
      {
        "name": "native-aot",
        "title": "Native AOT",
        "category": "CLI",
        "complexity": "intermediate to advanced",
        "priority": 2,
        "links": {
          "self": { "href": "cli/native-aot/index.json" }
        }
      }
    ]
  }
}
```

**Topic-level index** (e.g., `cli/file-based-apps/index.json`):
```json
{
  "kind": "topic-index",
  "title": "File-based Apps",
  "embedded": {
    "documents": [
      { "name": "topic-spec", "type": "markdown" },
      { "name": "golden-reference", "type": "markdown" },
      { "name": "qa-pairs", "type": "markdown" }
    ],
    "topics": null
  }
}
```

## Data Flow

### Embedding Generation
1. **Content detection**: Monitor .md file changes
2. **Vector generation**: Create embeddings using declared model
3. **Token counting**: Calculate token counts for budget planning
4. **Consistency**: Ensure all embedding-derived data matches declared model

### Semantic Analysis
1. **Within-topic analysis**: Compare all files to golden-reference.md baseline
2. **Cross-category analysis**: Calculate similarities between all topic pairs
3. **Statistical filtering**: Apply P75 thresholds to identify meaningful relationships
4. **Relationship storage**: Write structured markdown tables and metadata

### Graph Construction
1. **Index generation**: Create HAL+JSON navigation structure
2. **Relationship integration**: Incorporate semantic similarity data
3. **Metadata enrichment**: Add priority, complexity, audience information
4. **Cross-reference validation**: Ensure graph completeness and accuracy

## Quality Assurance

### Content Standards
- **Authority**: All claims backed by official sources with verification dates
- **Currency**: Reflects latest stable versions and best practices
- **Completeness**: Covers 80% of common scenarios per topic
- **Precision**: Each document addresses exactly its stated scope
- **Testability**: All code examples are verified working

### Validation Pipeline
- **Code compilation**: All examples compile against target framework
- **Cross-platform testing**: Platform-specific examples work on target platforms
- **Source verification**: Claims backed by authoritative sources
- **Semantic consistency**: Generated embeddings maintain expected similarity to golden reference
- **Template compliance**: All documents follow established format standards

## Tool Dependencies

### Embedding Tool
**Responsibility**: Generate and maintain all embedding-derived data
**Key outputs**: .embedding files, semantic-neighbors/ directory, token counts
**Consistency guarantee**: All outputs consistent with declared embedding model

### Index Tool
**Responsibility**: Transform source structure into navigable knowledge graph
**Key inputs**: Source content, semantic relationships, topic specifications
**Key outputs**: HAL+JSON indexes, metadata enrichment, navigation structure