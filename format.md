# Format Standards for Documentation Files

This document defines formatting rules and standards that apply to all format specification documents (files ending in `-format.md`) and structured content throughout the documentation system.

## Related Format Documents

| Name | Path | Description |
| --- | --- | --- |
| Topic Specification Format | topic-spec-format.md | Topic specification structure and requirements |
| Golden Reference Format | golden-reference-format.md | Reference content format standards |
| QA Pairs Format | qa-pairs-format.md | Question-answer pair format specification |
| Validation Format | validation-format.md | Quality validation criteria format |
| Index Format | index-format.md | Topic metadata and configuration format |
| File Types Reference | file-types.md | Complete file type reference and organization |

## Core Principles

### LLM-Optimized Content

All content is designed for Large Language Model consumption and automated processing:

- No markdown formatting for emphasis (no bold, italics, or other decorative formatting)
- Plain text with clear structure through headings and tables
- Descriptive language that conveys meaning without visual formatting cues
- Consistent terminology and phrasing patterns

### Structured Data Representation

Content organization follows consistent patterns:

- Lists represent array-like data (string[] equivalents)
- Tables represent structured objects with descriptive column headers
- Hierarchical relationships expressed through heading levels
- Cross-references use plain text identifiers

### Content Hierarchy and Deduplication

Information placement follows a clear hierarchy to avoid repetition:

- Topic-specific content stays in individual topic specifications
- Category-wide patterns move to category-level specifications
- Global infrastructure resides in dedicated files (repos.md, format.md)
- Format specifications define structure without repeating content

## Formatting Rules

### Markdown Compliance

All files must be markdownlint compliant:

- Proper heading hierarchy without skipping levels
- Consistent table formatting with aligned columns
- Single trailing newline at file end
- No multiple consecutive blank lines
- Proper spacing around headings and tables
- Code elements containing angle brackets (`<` and `>`) must be wrapped in backticks to prevent HTML parsing issues

### URL and Link Format

URL handling for optimal parsing:

- Plain text URLs without angle bracket notation
- No markdown link syntax unless absolutely necessary
- Repository references use short names from repos.md registry
- External URLs preserved in full for direct access

### Table Standards

Consistent table structure across all documents:

- Descriptive column headers that explain content purpose
- Consistent column ordering within document types
- No placeholder rows with dashes or empty content
- Each row must provide actionable, concrete information
- Code elements in table cells containing `<` and `>` characters must use backticks for markdown compliance

### List Format

Bullet point lists for array-like content:

- Single dash followed by space for list items
- One concept or term per list item
- No sub-bullets unless representing hierarchical data
- Consistent formatting across similar content types

## Content Organization Patterns

### Directory Organization

Topic specifications should be organized by namespace-based categorization:

- `libraries/` - All `System.*` namespaces (both built-in libraries and NuGet packages)
- `extensions/` - All `Microsoft.Extensions.*` namespaces
- `csharp/` - C# language features and syntax
- `cli/` - .NET CLI tools and commands
- `dotnet/` - .NET platform and runtime features

Examples:

- `docs/libraries/system-commandline/` - System.CommandLine namespace
- `docs/libraries/system-text-json/` - System.Text.Json namespace
- `docs/extensions/microsoft-extensions-ai/` - Microsoft.Extensions.AI namespace

Distribution method (built-in vs NuGet package) should be documented in the metadata Prerequisites field rather than affecting directory structure.

### Information Hierarchy

Content placement follows this priority order:

1. Global files (repos.md, format.md) - infrastructure and cross-cutting concerns
2. Category specifications - patterns shared across related topics
3. Topic specifications - feature-specific information and sources
4. Supporting files - examples, references, and detailed content

### Avoiding Duplication

Content should appear at the most appropriate level:

- Repository definitions belong in repos.md, not individual topic specs
- Generation patterns belong in category specs, not individual features
- Format rules belong in format.md, not scattered across multiple files
- Source discovery workflows belong in category specs for reuse

### Cross-Reference Strategy

References between files use consistent patterns:

- Relative paths for files within the same repository
- Repository short names from the central registry
- Topic identifiers that match directory and file naming
- Category relationships expressed through clear hierarchies

## File Type Standards

### Topic Specification Files

Structure and content requirements:

- Required sections: Feature Description, Relationships, Metadata, Sources
- Optional sections: Keywords (as bullet lists)
- Table format: consistent column headers across all source tables
- No generation hints at individual topic level (use category level)

### Format Specification Files

Documentation structure standards:

- Clear section hierarchy with descriptive headings
- Example patterns using consistent formatting
- Validation rules expressed as actionable requirements
- Anti-patterns section to prevent common mistakes

### Supporting Documentation

Additional file requirements:

- Clear purpose statement at document beginning
- Consistent formatting with other files in same directory
- Cross-references to related documentation
- Regular review and update schedule for currency

## Validation Requirements

### Automated Compliance

All files must pass automated validation:

- Markdownlint rules as defined in .markdownlint.json
- Link validation for accessibility and currency
- Table structure validation for consistency
- Content completeness checks for required sections

### Manual Review Standards

Regular review processes ensure quality:

- Content accuracy against source material
- Relationship consistency across related topics
- Format compliance with established patterns
- Currency of external references and sources

### Quality Metrics

Measurable standards for content quality:

- All tables contain actionable information (no placeholder content)
- Cross-references resolve to existing topics or external resources
- Source verification dates maintained and current
- Consistent terminology usage across related documents

## Evolution and Maintenance

### Format Updates

Process for updating format standards:

- Changes to format.md trigger review of all affected files
- Category-level changes require validation of dependent topics
- Global infrastructure changes need comprehensive testing
- Version control tracks format evolution for rollback capability

### Content Lifecycle

Regular maintenance ensures continued value:

- Source verification and URL validation
- Relationship mapping updates for new features
- Category pattern refinement based on usage
- Format specification updates for new content types

This format standard ensures consistency, maintainability, and optimal processing across the entire documentation system while supporting both automated tools and human users.
