# Documentation Workflow Guide

This document explains how to effectively use the structured documentation system for .NET topic generation, from individual topics to the complete knowledge graph.

## Overview

The documentation system operates at multiple layers, from innermost to outermost:

1. Topic-level: Individual feature specifications
2. Category-level: Shared patterns and generation guidance
3. Global-level: Cross-cutting infrastructure and format definitions

## Layer 1: Topic-Level Usage

### Within a Topic Directory

Each topic directory contains multiple documents that work together:

```
docs/csharp/collection-expressions/
├── topic-spec.md          # Feature specification with sources and metadata
├── golden-reference.md    # Reference implementation content
└── other supporting files
```

Workflow:
1. Start with `topic-spec.md` - provides feature description, relationships, and authoritative sources
2. Use source discovery workflow - follow repo paths and URLs to gather raw content
3. Reference `golden-reference.md` - see examples of expected output quality and structure
4. Apply topic-specific metadata - complexity, audience, priority from topic-spec

### Source Discovery Process

Step 1: Repository Files
```markdown
| Repo | Path | Description | Last Verified |
| --- | --- | --- | --- |
| dotnet/docs | docs/csharp/language-reference/operators/collection-expressions.md | Language reference documentation | - |
| dotnet/roslyn | docs/Language Feature Status.md | Feature status tracking | - |
```

Step 2: Follow Discovered Links
- Look for GitHub issues referenced in status documents
- Follow proposal links to detailed specifications
- Handle URL evolution (versioned paths, moved content)

Step 3: Convert to Raw URLs
- Transform GitHub blob URLs to raw URLs for LLM consumption
- Use `/docs/repos.md` registry for consistent URL generation

## Layer 2: Category-Level Guidance

### Using Category Topic Specs

Category-level specs (like `docs/csharp/topic-spec.md`) provide:
- Generation hints applicable to all features in the category
- Common repositories and source patterns
- Cross-reference strategies for related features

Workflow:
1. Read category topic-spec first - understand overarching patterns
2. Apply category generation hints - emphasize/avoid patterns for the domain
3. Use category relationships - connect to related features within the category
4. Leverage category source patterns - follow established discovery workflows

### Example: C# Language Features

For any C# feature (like collection expressions):

1. Check `docs/csharp/topic-spec.md` for:
   - Generation hints (emphasize syntax clarity, avoid compiler internals)
   - Source discovery workflow (Roslyn status → csharplang proposals → docs)
   - Repository patterns (dotnet/docs, dotnet/csharplang, dotnet/roslyn)

2. Apply to specific feature:
   - Follow the established source discovery pattern
   - Use category-appropriate generation guidance
   - Connect to related C# features through category relationships

## Layer 3: Global Infrastructure

### Core Infrastructure Documents

`/docs/repos.md` - Repository Registry
- Defines all official .NET repositories with Home, Rendered, and Raw URL patterns
- Enables consistent repo path references across all topic specs
- Single source of truth for repository metadata

`topic-spec-format.md` - Format Specification
- Defines the structure and standards for all topic specifications
- Establishes table formats, relationship types, and validation rules
- Ensures consistency across the entire documentation set

`workflow.md` (this document) - Usage Patterns
- Explains how to navigate and use the entire system
- Provides workflows for different use cases and audiences
- Connects individual components into coherent processes

### Using Global Infrastructure

Repository Resolution:
```markdown
# In topic-spec.md:
| Repo | Path | Description | Last Verified |
| dotnet/docs | docs/csharp/whats-new/csharp-12.md | C# 12 features | - |

# Resolved using /docs/repos.md:
Raw URL: https://raw.githubusercontent.com/dotnet/docs/main/docs/csharp/whats-new/csharp-12.md
Rendered URL: https://github.com/dotnet/docs/blob/main/docs/csharp/whats-new/csharp-12.md
```

Format Validation:
- All topic-spec.md files follow `topic-spec-format.md` standards
- Consistent table structures enable automated processing
- Linter rules ensure formatting compliance

## Complete Workflow Example

### Generating Content for Collection Expressions

1. Global Context
- Read `/docs/repos.md` to understand repository structure
- Understand table formats from `topic-spec-format.md`

2. Category Context
- Read `docs/csharp/topic-spec.md` for C# language patterns
- Apply generation hints: emphasize syntax clarity, avoid compiler internals
- Use established source discovery workflow

3. Topic Context
- Read `docs/csharp/collection-expressions/topic-spec.md`
- Follow repo path references to gather raw content
- Apply topic-specific complexity (0.6) and audience (All C# developers)

4. Content Generation
- Use raw URLs for LLM-friendly markdown content
- Apply category-level generation hints
- Structure according to topic complexity and audience
- Cross-reference related features per relationship mapping

5. Validation
- Compare against `golden-reference.md` for quality standards
- Ensure relationships are bidirectional across related topics
- Verify source accessibility and currency

## Advanced Patterns

### Cross-Category Relationships

When features span categories (e.g., C# features that impact CLI tools):
1. Read both category topic-specs for generation context
2. Apply appropriate hints for the primary category
3. Reference secondary category relationships
4. Ensure cross-references are maintained in both directions

### Version-Specific Content

For evolving features:
1. Use versioned proposal paths when available
2. Check multiple version folders for feature evolution
3. Reference appropriate .NET version in topic metadata
4. Handle deprecated or moved content gracefully

### Source Validation Workflow

Regular maintenance process:
1. Verify `Last Verified` dates in topic-specs
2. Check for 404s and moved content
3. Update repository paths for structural changes
4. Maintain bidirectional relationship integrity

## Benefits of Layered Approach

Maintainability:
- Changes to repositories update once in `/docs/repos.md`
- Format changes propagate through `topic-spec-format.md`
- Category patterns reduce duplication across features

Consistency:
- All C# features follow same generation patterns
- Repository references use standardized short names
- Table structures enable automated processing

Scalability:
- New categories inherit established patterns
- Repository registry supports new official repos
- Format specifications accommodate new content types

Quality:
- Category-level guidance ensures domain-appropriate content
- Global format standards maintain structural consistency
- Source validation workflows preserve authority and currency