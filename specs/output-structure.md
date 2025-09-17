# Output Repository Structure and Consumption

## Repository Organization

### Generated Content Structure
The output repository provides LLM-consumable content with navigable indexes:

```
dotnet-docs-llms/
├── README.md                       # Repository purpose and navigation guide
├── llms.txt                        # Instructions for LLMs on graph navigation
├── index.json                      # Root knowledge graph (transformed from source)
├── cli/
│   ├── index.json                  # CLI category index
│   └── {topic-id}/
│       ├── overview.md             # Conceptual foundation
│       ├── one-shot-600.md         # Essential knowledge (tight budget)
│       ├── one-shot-2400.md        # Comprehensive knowledge (medium budget)
│       ├── one-shot-4800.md        # Complete knowledge (full budget)
│       ├── one-shot-syntax-600.md  # Pure syntax reference
│       ├── examples-600.md         # Minimal examples
│       ├── examples-2400.md        # Practical examples
│       ├── examples-4800.md        # Comprehensive examples
│       ├── troubleshooting.md      # Problem-solving guide
│       ├── integration.md          # Cross-system patterns
│       └── advanced.md             # Edge cases, performance
├── libraries/
│   ├── index.json                  # Library category index
│   └── {topic-id}/
├── runtime/
│   ├── index.json                  # Runtime category index
│   └── {topic-id}/
└── cross-cutting/
    ├── index.json                  # Cross-cutting category index
    └── {topic-id}/
```

## Content Templates

### Token Budget Strategy
Content is generated with specific token limits as maximum bounds, not targets:
- **600 tokens**: Essential knowledge for tight context windows
- **2400 tokens**: Comprehensive coverage for medium contexts
- **4800 tokens**: Complete reference for full contexts

**Quality over quantity**: Content stops when quality drops rather than padding to reach limits.

### Overview (overview.md)
Conceptual foundation providing context and orientation:
- **What it is**: Clear definition and purpose
- **When to use**: Primary use cases and scenarios
- **Key concepts**: Essential understanding for effective use
- **Relationships**: How it connects to broader ecosystem

### One-Shot Documents (one-shot-{budget}.md)
Self-contained comprehensive guides:
- **Concept explanation**: What it is, when to use
- **Practical examples**: Working code with different complexity levels
- **Critical limitations**: Most important constraints and gotchas
- **Decision guidance**: When NOT to use this approach

### Syntax Reference (one-shot-syntax-600.md)
Pure syntax guide for experienced developers:
- **Target audience**: Developers who know concepts but need syntax reminders
- **Core patterns**: Essential syntax with minimal explanation
- **Command variations**: Key parameters and options
- **Syntax gotchas**: Differences from similar features

### Examples Documents (examples-{budget}.md)
Progressive example complexity:
- **Minimal (600)**: 1-2 essential examples
- **Practical (2400)**: 2-3 real-world scenarios
- **Comprehensive (4800)**: 4-6 examples covering edge cases

**Quality gates**: Skip entirely if insufficient distinct examples exist.

### Specialized Documents
- **troubleshooting.md**: Problem-solving focused content
- **integration.md**: Cross-system patterns and workflows
- **advanced.md**: Edge cases, performance considerations, expert scenarios

## Navigation Structure

### HAL+JSON Indexes
Transformed from source repository with embellishments for navigation:

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
    "semantic_neighbors": [
      {
        "relative": "dotnet/index.json",
        "title": ".NET",
        "similarity": 0.7638
      }
    ]
  },
  "embedded": {
    "documents": [
      {
        "name": "overview",
        "type": "markdown",
        "title": "Overview",
        "links": { "self": { "href": "cli/file-based-apps/overview.md" } }
      }
    ]
  }
}
```

### Relationship Integration
- **Semantic neighbors**: Pre-computed similarity scores from source analysis
- **Hierarchical links**: Parent-child relationships in category structure
- **Cross-references**: Related topics with contextual similarity scores

## Content Generation Process

### Template-Driven Generation
1. **Source analysis**: Extract patterns from qa-pairs.md and golden-reference.md
2. **Template application**: Apply budget-specific generation templates
3. **Quality filtering**: Skip outputs when insufficient quality content exists
4. **Cross-reference integration**: Include relevant relationships from semantic analysis

### Quality Decision Tree
For each content type:
1. **Analyze source material**: Assess quality and quantity
2. **Apply quality gates**: Skip if insufficient content exists
3. **Generate appropriate size**: Use smaller budget if content doesn't justify larger
4. **Validate output**: Ensure content meets density and accuracy standards

### Index Transformation
1. **Source index consumption**: Read semantic relationships and topic specifications
2. **Navigation enhancement**: Add computed links and metadata
3. **Discoverability optimization**: Include similarity scores for topic discovery
4. **Format standardization**: Consistent HAL+JSON structure across all categories

## Consumption Patterns

### Direct Access
Tools can directly access specific content based on context:
- **Problem-specific**: `troubleshooting.md` for error scenarios
- **Syntax lookup**: `one-shot-syntax-600.md` for quick reference
- **Comprehensive**: `one-shot-2400.md` for complete understanding

### Graph Navigation
Tools traverse relationships for discovery:
1. **Lexical matching**: Find initial candidates through keyword search
2. **Semantic expansion**: Use pre-computed neighbors for related topics
3. **Hierarchical traversal**: Navigate category relationships
4. **Priority filtering**: Use complexity and priority metadata for ranking

### Subgraph Download
Tools can download coherent subsets:
1. **Topic selection**: Choose primary topic and relationship depth
2. **Neighbor inclusion**: Include semantically related topics above threshold
3. **Dependency resolution**: Ensure complete subgraph for offline use
4. **Format selection**: Choose appropriate token budget for context

## LLM Integration Guidelines

### Content Selection
- **Context awareness**: Match token budget to available LLM context
- **Problem alignment**: Select content type based on user need (overview vs troubleshooting)
- **Relationship leverage**: Use semantic neighbors for comprehensive understanding

### Quality Indicators
- **Source authority**: All content traces to verified authoritative sources
- **Recency**: Generation timestamps indicate content freshness
- **Validation status**: All code examples verified against target platforms
- **Relationship strength**: Similarity scores indicate connection confidence

### Offline Capability
- **Self-contained subgraphs**: Downloaded content includes all necessary context
- **Consistent formatting**: Standard markdown and JSON for reliable parsing
- **Explicit relationships**: All cross-references clearly marked and navigable
- **Metadata preservation**: Priority, complexity, and audience information maintained

## Tool Integration Points

### Graph Generator Tool
**Input dependencies**: Source content, semantic relationships, topic specifications
**Output responsibility**: Transform source indexes and generate navigable structure
**Key function**: Maintain consistency between source relationships and output navigation

### Content Generator Tool
**Input dependencies**: Source qa-pairs.md, golden-reference.md, template specifications
**Output responsibility**: Generate all markdown content files within topic directories
**Key function**: Apply quality gates and token budget constraints during generation

### Validation Tool
**Input dependencies**: Generated content, source golden references
**Output responsibility**: Verify semantic consistency and quality standards
**Key function**: Ensure generated content maintains fidelity to source authority