# Knowledge Graph Consumption Patterns

## Overview

The consumption system provides intelligent retrieval from the pre-computed knowledge graph using multi-signal analysis. It combines fast lexical matching, pre-computed semantic similarities, and LLM re-ranking to deliver contextually relevant documentation subgraphs.

## Architecture Principles

### Separation of Concerns

- Lexical analysis (tool): Fast, deterministic environment scanning and keyword matching
- Graph navigation (tool): Efficient traversal using pre-computed similarity scores
- Semantic understanding (LLM): Contextual re-ranking and relevance assessment
- Subgraph caching (tool): Coherent offline documentation sets

### Performance Characteristics

- No GPU required: Tool uses only pre-computed embeddings and similarities
- Deterministic candidates: Same environment produces same candidate set
- Offline capable: Downloaded subgraphs work without connectivity
- Explainable results: Clear signal separation between lexical/semantic/structural matches

## Consumption Workflow

### Phase 1: Environment Analysis

Tool responsibility: Scan developer environment for contextual signals

Input sources:

- Project files: `.csproj`, `.props`, `Directory.Build.props`
- Configuration: `appsettings.json`, environment variables
- Error messages: Compiler errors, runtime exceptions
- Code context: Current file, namespace, using statements
- Command context: CLI commands, MSBuild targets

Signal extraction:

```csharp
// Tool detects these patterns lexically:
PublishAot=true              → ["publish", "aot", "native", "compilation"]
<TargetFramework>net10.0     → ["net10", "latest", "modern"]
System.CommandLine           → ["cli", "command-line", "parsing"]
CA1234: Missing XML comment  → ["documentation", "xml-comments", "ca1234"]
```

### Phase 2: Candidate Generation

Tool responsibility: Generate candidate topics using multi-signal matching

Lexical matching:

1. Keyword extraction: Extract meaningful terms from environment
2. Index scanning: Search topic titles, descriptions, and metadata
3. Exact matches: High-priority candidates for exact keyword matches
4. Fuzzy matches: Medium-priority candidates for partial matches

Graph traversal:

1. Initial candidates: Topics matching lexical analysis
2. Semantic expansion: Include neighbors above similarity threshold
3. Hierarchical inclusion: Add parent/child topics for context
4. Priority weighting: Use topic priority and complexity metadata

Candidate scoring:

```json
{
  "candidates": [
    {
      "topic": "cli/file-based-apps",
      "signals": {
        "lexical_match": 0.95,     // "dotnet run app.cs" detected
        "semantic_similarity": 0.82, // Pre-computed from graph
        "priority_weight": 0.8,     // Priority 2 topic
        "context_relevance": 0.7    // Based on project structure
      },
      "composite_score": 0.84
    }
  ]
}
```

### Phase 3: LLM Re-ranking

LLM responsibility: Apply semantic understanding to refine candidate ranking

Input to LLM:

```json
{
  "environment_context": {
    "project_type": "console_application",
    "target_framework": "net10.0",
    "detected_patterns": ["PublishAot=true", "single .cs file"],
    "user_intent": "wants to understand native compilation options"
  },
  "candidates": [
    {
      "topic": "cli/native-aot",
      "description": "Native ahead-of-time compilation",
      "tool_score": 0.76
    },
    {
      "topic": "cli/file-based-apps",
      "description": "Single .cs file execution",
      "tool_score": 0.84
    }
  ]
}
```

LLM re-ranking criteria:

- Intent alignment: How well topic matches likely user goal
- Context appropriateness: Relevance to detected environment
- Completeness: Whether topic provides comprehensive coverage
- Learning progression: Appropriate complexity for user's apparent level

### Phase 4: Subgraph Download

Tool responsibility: Assemble coherent documentation subset for offline use

Subgraph assembly:

1. Primary topics: Top-ranked candidates from LLM re-ranking
2. Dependency inclusion: Required prerequisite topics
3. Related topics: Semantically connected content above threshold
4. Context topics: Parent categories and overview content

Content selection:

```json
{
  "subgraph": {
    "primary": ["cli/file-based-apps"],
    "related": ["cli/native-aot", "cli/publishing"],
    "context": ["cli/index.json", "dotnet/index.json"],
    "formats": {
      "overview": "always_include",
      "one_shot": "budget_2400",  // Based on available context
      "examples": "budget_600",
      "troubleshooting": "if_available"
    }
  }
}
```

Quality assurance:

- Completeness: All cross-references resolvable within subgraph
- Consistency: Compatible content versions and metadata
- Freshness: Recent generation timestamps
- Authority: Verified source provenance

### Phase 5: Offline LLM Processing

Tool + LLM responsibility: Process downloaded subgraph for user assistance

Local graph structure:

```
downloaded_subgraph/
├── index.json                  # Navigation root
├── cli/
│   ├── file-based-apps/
│   │   ├── overview.md
│   │   ├── one-shot-2400.md
│   │   ├── examples-600.md
│   │   └── troubleshooting.md
│   └── native-aot/
│       └── [related content]
└── metadata.json              # Download context and timestamps
```

LLM integration patterns:

- Contextual grounding: LLM references specific downloaded content
- Cross-topic synthesis: LLM connects information across related topics
- Progressive disclosure: LLM suggests deeper topics based on user engagement
- Problem-solving focus: LLM prioritizes troubleshooting content for error scenarios

## Use Case Examples

### Scenario 1: Modern Feature Discovery

Context: Developer sees `PublishAot=true` in project but unfamiliar with Native AOT

Workflow:

1. Environment scan: Tool detects "PublishAot" property
2. Candidate generation: ["native-aot", "publishing", "performance", "limitations"]
3. LLM re-ranking: Prioritizes native-aot overview and publishing workflows
4. Subgraph download: Includes native-aot + publishing + performance considerations
5. User assistance: LLM explains Native AOT with current, authoritative examples

### Scenario 2: Error Resolution

Context: Developer gets compilation error with file-based app in multi-file directory

Workflow:

1. Environment scan: Tool detects "multiple .cs files" + "dotnet run error"
2. Candidate generation: ["file-based-apps", "compilation-errors", "project-structure"]
3. LLM re-ranking: Prioritizes troubleshooting content over conceptual overview
4. Subgraph download: Includes file-based-apps troubleshooting + project migration
5. User assistance: LLM provides specific solutions with migration guidance

### Scenario 3: Learning Progression

Context: Developer successfully using file-based apps, wants to understand publishing

Workflow:

1. Environment scan: Tool detects successful file-based app usage patterns
2. Candidate generation: Semantic neighbors of file-based-apps
3. LLM re-ranking: Prioritizes natural progression topics (publishing, native-aot)
4. Subgraph download: Includes publishing workflows + deployment options
5. User assistance: LLM suggests next steps with appropriate complexity

## Tool Interface Design

### Query API

```json
{
  "analyze_environment": {
    "project_path": "/path/to/project",
    "error_context": "optional error message",
    "user_intent": "optional explicit goal"
  },
  "generation_preferences": {
    "max_context_tokens": 4000,
    "complexity_level": "intermediate",
    "format_preference": "examples_focused"
  }
}
```

### Response Format

```json
{
  "candidates": [
    {
      "topic": "cli/file-based-apps",
      "relevance_score": 0.92,
      "reasoning": "Direct match for detected single-file pattern",
      "available_formats": ["overview", "one-shot-2400", "examples-600"]
    }
  ],
  "subgraph_info": {
    "total_topics": 3,
    "estimated_tokens": 3200,
    "download_size": "127KB",
    "offline_duration": "24h"
  }
}
```

### Caching Strategy

- Subgraph TTL: 24-48 hours for typical development sessions
- Incremental updates: Download only changed content
- Priority refresh: Update high-priority topics more frequently
- Context awareness: Refresh based on detected environment changes

## Quality Indicators

### Signal Quality

- Lexical precision: Keyword matching accuracy
- Semantic relevance: Pre-computed similarity score confidence
- Context appropriateness: Environment pattern recognition accuracy
- LLM alignment: Re-ranking correlation with actual user satisfaction

### Content Quality

- Authority verification: Source provenance and verification dates
- Recency indicators: Content generation timestamps
- Completeness metrics: Cross-reference resolution success
- Validation status: Code example compilation and testing results

### User Experience

- Discovery success: Relevant content found within 3 candidates
- Problem resolution: Issue-specific content availability
- Learning progression: Appropriate complexity and depth
- Offline reliability: Subgraph completeness and navigability

## Integration Patterns

### IDE Integration

- Context awareness: Current file, project structure, compilation errors
- Progressive disclosure: Contextual help expanding to full documentation
- Background refresh: Keep relevant subgraphs current during development

### CLI Tool Integration

- Command context: Integrate with dotnet CLI commands and error messages
- Workflow assistance: Suggest documentation during common development tasks
- Error amplification: Enhance error messages with relevant documentation links

### CI/CD Integration

- Build context: Analyze build logs and configuration for relevant documentation
- Deployment assistance: Provide publishing and deployment guidance
- Performance monitoring: Surface performance-related documentation during optimization
