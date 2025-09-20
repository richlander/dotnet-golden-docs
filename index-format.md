# Index Format Guide

This document defines the format and structure of the HAL+JSON index files generated for each topic and category in the documentation knowledge graph. Index files serve as machine-readable navigation and metadata for the hierarchical documentation structure.

## Purpose

Index files serve multiple critical functions:

- **Navigation structure**: Hierarchical links between topics, categories, and documents
- **Machine-readable metadata**: Structured data for automated processing and content generation
- **Semantic relationships**: Cross-references and similarity mappings between related topics
- **Depth information**: Hierarchical structure depth for UI rendering and navigation
- **Embedding metadata**: Information about the semantic embeddings used for similarity calculations

## Format Structure

Index files follow the HAL+JSON (Hypertext Application Language) specification, providing a standardized approach to representing resources and their relationships.

### Root Properties

```json
{
  "id": "cli/file-based-apps",
  "title": "File-based apps",
  "description": "Comprehensive description of the topic or category",
  "category": "CLI",
  "complexity": 0.5,
  "priority": 2,
  "depth_below": 0,
  "_links": { ... },
  "_embedded": { ... },
  "metadata": { ... }
}
```

#### Core Fields

- **id**: Hierarchical path identifier (empty string for root, "cli" for categories, "cli/file-based-apps" for topics)
- **title**: Human-readable display name
- **description**: Detailed explanation of the topic or category's purpose and scope
- **category**: Classification (e.g., "CLI", "Root", "Libraries")
- **complexity**: Difficulty level as float from 0.0 (beginner) to 1.0 (advanced)
- **priority**: Display priority as integer (1 = highest priority)
- **depth_below**: Maximum depth of descendants from this node (0 for leaf topics, 1+ for categories)

### Links Section

The `_links` section provides HAL-compliant navigation relationships:

```json
"_links": {
  "self": {
    "name": "self",
    "href": "/cli/file-based-apps",
    "description": "Self-referential link with topic description"
  },
  "parent": {
    "name": "parent",
    "href": "/cli",
    "description": "Parent category containing this topic"
  },
  "topic-spec": {
    "name": "Topic Specification",
    "href": "/cli/file-based-apps/topic-spec.md",
    "description": "Feature relationship definition including hierarchy, generation hints, and critical limitations"
  },
  "golden-reference": {
    "name": "Golden Reference Document",
    "href": "/cli/file-based-apps/golden-reference.md",
    "description": "Comprehensive reference document serving as validation baseline"
  },
  "qa-pairs": {
    "name": "Question & Answer Pairs",
    "href": "/cli/file-based-apps/qa-pairs.md",
    "description": "Structured Q&A content with JSON frontmatter"
  },
  "sources": {
    "name": "Authoritative Sources",
    "href": "/cli/file-based-apps/sources.md",
    "description": "Reference list of primary and secondary sources"
  },
  "validation": {
    "name": "Validation Requirements",
    "href": "/cli/file-based-apps/validation.md",
    "description": "Testing requirements and validation rules"
  }
}
```

#### Link Types

- **self**: Self-referential link to this resource
- **parent**: Link to containing category (absent for root)
- **Document links**: Links to component markdown files (topic-spec, golden-reference, qa-pairs, sources, validation)

### Embedded Section

The `_embedded` section contains related resources and semantic relationships:

```json
"_embedded": {
  "similar_categories": [
    {
      "category": "cli",
      "threshold": 0.5,
      "topics": [
        {
          "id": "cli/native-aot",
          "title": "Native AOT",
          "similarity": 0.6089
        }
      ]
    }
  ],
  "similar_documents": {
    "baseline": "golden-reference.md",
    "documents": [
      {
        "name": "qa-pairs.md",
        "similarity": 0.6946
      }
    ]
  },
  "topics": [
    {
      "name": "file-based-apps",
      "title": "File-based apps",
      "category": "CLI",
      "complexity": 0.5,
      "priority": 2,
      "_links": {
        "self": {
          "name": "self",
          "href": "/cli/file-based-apps",
          "description": "Topic description"
        }
      }
    }
  ]
}
```

#### Embedded Resources

- **similar_categories**: Cross-category semantic relationships grouped by category with similarity thresholds
- **similar_documents**: Document-level similarities within the same topic using cosine similarity
- **topics**: Child topics for category indexes (null for leaf topics)

### Metadata Section

The `metadata` section provides generation and embedding information:

```json
"metadata": {
  "generated": "2025-09-20T00:24:40.1962003Z",
  "generator": "IndexTool/1.0",
  "embedding_model": "Ollama/nomic-embed-text:latest",
  "embedding_dimensions": 768,
  "similarity_metric": "cosine"
}
```

#### Metadata Fields

- **generated**: ISO 8601 timestamp of index generation
- **generator**: Tool and version used for generation
- **embedding_model**: Semantic embedding model identifier
- **embedding_dimensions**: Vector dimensionality for embeddings
- **similarity_metric**: Distance calculation method (typically "cosine")

## Index Types

### Root Index (`docs/index.json`)

- **id**: Empty string
- **title**: ".NET Knowledge Graph"
- **depth_below**: Maximum depth in the entire hierarchy
- **topics**: Top-level categories only
- **parent link**: Absent

### Category Index (`docs/cli/index.json`)

- **id**: Category path (e.g., "cli")
- **depth_below**: Maximum depth of child topics
- **topics**: All direct child topics
- **parent link**: Points to root ("/")

### Topic Index (`docs/cli/file-based-apps/index.json`)

- **id**: Full topic path (e.g., "cli/file-based-apps")
- **depth_below**: 0 (leaf nodes)
- **topics**: null
- **parent link**: Points to containing category (e.g., "/cli")

## Validation Requirements

### Schema Compliance

- All index files must be valid JSON
- Links must follow HAL specification
- Similarity values must be between 0.0 and 1.0
- Priority must be positive integers
- Complexity must be between 0.0 and 1.0

### Consistency Checks

- Parent-child relationships must be bidirectional
- Self links must match the resource's actual path
- Embedded topics must have corresponding index files
- Similarity calculations must use consistent embedding models

### Quality Standards

- Descriptions must be informative and accurate
- Links must resolve to existing resources
- Metadata must reflect actual generation context
- Depth calculations must be accurate for navigation UIs

## Usage Examples

### Navigation Implementation

Index files enable hierarchical navigation:

- Use `depth_below` to determine tree expansion states
- Follow `parent` links for breadcrumb navigation
- Use `topics` for child navigation menus

### Content Discovery

Leverage semantic relationships:

- Use `similar_categories` for cross-topic recommendations
- Use `similar_documents` for related content within topics
- Filter by `complexity` and `priority` for progressive disclosure

### Metadata Processing

Extract generation context:

- Use `embedding_model` and `embedding_dimensions` for compatibility checks
- Use `generated` timestamp for cache invalidation
- Use `similarity_metric` for understanding relationship calculations

## Generation Process

Index files are generated by the IndexTool using:

1. Directory structure analysis for hierarchy
2. Topic specification parsing for metadata
3. Semantic embedding analysis for relationships
4. Depth calculation for navigation structure
5. HAL+JSON serialization for output format

The generation process ensures consistency across the entire documentation knowledge graph while providing rich metadata for both human navigation and automated processing.
