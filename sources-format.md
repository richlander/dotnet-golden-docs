# Sources Format Guide

This document defines the format and quality standards for sources documentation across all topics in the documentation set. Sources files establish authoritative provenance and validation requirements for all technical claims.

## Purpose

Sources documentation serves as the authority foundation for the knowledge architecture:

- **Provenance tracking**: Clear attribution for all technical claims and examples
- **Quality assurance**: Verification requirements and testing standards
- **Authority grading**: Confidence levels for different types of sources
- **Currency maintenance**: Update schedules and verification tracking

## Format Structure

### Document Title

The H1 will be structured as: `# {Feature Name} - Sources`

### Required Sections

#### Primary Sources (High Confidence)

Authoritative documentation with the highest trust levels:

**Subsection Structure**:

- **Official Microsoft Documentation**: Core product documentation
- **Source Code Repository**: Implementation references and threat models
- **API Reference Documentation**: Method signatures and detailed specifications

**Entry Format**:

- **Link title**: <https://full-url>
  - Last verified: YYYY-MM-DD
  - Content: Brief description of what information is sourced
  - Authority: Team or organization responsible

#### Secondary Sources (Good Quality)

High-quality community content and additional references:

**Subsection Structure**:

- **Migration and Comparison Guides**: Transition documentation
- **Performance Benchmarks**: Verified performance data
- **Community Resources**: Stack Overflow, Reddit, recognized blogs

**Entry Format**: Same as primary sources with clear authority attribution

#### Code Examples Sources

Specific repositories and locations for working code samples:

**Subsection Structure**:

- **Official Sample Repository**: Microsoft-maintained examples
- **Framework Integration Examples**: Real-world usage patterns

**Entry Format**: Include repository paths and specific verification status

#### Validation Status

Current testing and verification state:

**Subsection Structure**:

- **Code Compilation Tests**: Compilation verification across frameworks
- **Cross-Platform Testing**: Platform-specific validation
- **Version Compatibility**: Feature availability across .NET versions

**Entry Format**: Checkbox lists with specific test criteria

#### Update Schedule

Maintenance and verification schedules:

**Subsection Structure**:

- **Regular Verification**: Routine check schedules
- **Event-Based Updates**: Trigger conditions for updates

#### Quality Metrics

Source authority grading and freshness tracking:

**Subsection Structure**:

- **Source Authority Grading**: A+ to C rating system
- **Content Freshness**: Green/Yellow/Red status indicators
- **Validation Requirements**: Testing and verification standards

## Authority Grading System

### Grade Definitions

- **A+**: Official Microsoft documentation, source code, threat models
- **A**: Microsoft team blogs, official sample repositories
- **B+**: High-score Stack Overflow answers, established community guides
- **B**: Community blogs with verifiable examples and testing
- **C**: Unverified community content (use sparingly)

### Authority Attribution

- **Microsoft official docs team**: Core product documentation
- **Microsoft .NET team**: Implementation and architecture documentation
- **Microsoft Security team**: Threat models and security guidance
- **Microsoft API documentation team**: Reference documentation
- **Developer community**: Stack Overflow, Reddit, community blogs

## Verification Standards

### Last Verified Date Requirements

- **Primary sources**: Verified within last 6 months
- **Secondary sources**: Verified within last year
- **Code examples**: Verified with each major .NET release
- **Performance benchmarks**: Verified annually or when architecture changes

### Content Accuracy Validation

- **Code compilation**: All examples must compile against specified versions
- **Functional testing**: Examples must produce expected outputs
- **Cross-platform verification**: Platform-specific claims tested on target platforms
- **Performance verification**: Benchmark claims must be reproducible

### Version Compatibility Tracking

- **Feature availability**: Verify features exist in claimed .NET versions
- **API changes**: Track breaking changes and deprecations
- **Platform support**: Verify platform-specific feature availability
- **Migration accuracy**: Ensure migration guidance reflects actual API changes

## Validation Checklist Format

### Code Compilation Tests

```markdown
- [x] Basic serialization examples compile with .NET 8
- [x] Source generation examples work with Native AOT
- [x] ASP.NET Core integration examples functional
- [x] .NET 10 feature examples verified
```

### Cross-Platform Testing

```markdown
- [x] Windows (x64, ARM64)
- [x] Linux (x64, ARM64)
- [x] macOS (x64, ARM64)
```

### Version Compatibility

```markdown
- [x] .NET Core 3.0 basic features
- [x] .NET 5 improvements
- [x] .NET 6 source generation
- [x] .NET 7 type resolver chains
- [x] .NET 8 streaming optimizations
- [x] .NET 10 strict options and PipeReader
```

## Update Schedule Standards

### Regular Verification Schedules

- **Monthly**: Check primary documentation links for availability
- **Quarterly**: Validate code examples against current frameworks
- **Semi-annually**: Cross-platform testing across all supported platforms
- **Annually**: Comprehensive review of all secondary sources

### Event-Based Update Triggers

- **New .NET version releases**: Update version compatibility and new features
- **Major security advisories**: Review and update security guidance
- **Breaking changes in APIs**: Update examples and migration guidance
- **Performance benchmark updates**: Refresh performance claims and comparisons

## Quality Criteria

### Source Selection Standards

- **Primary sources must be official**: No exceptions for core technical claims
- **Secondary sources must be verifiable**: Include working examples or clear testing
- **Community sources must be high-quality**: Stack Overflow answers with high scores, recognized authority authors
- **All sources must be current**: Outdated sources flagged for review or removal

### Verification Rigor

- **All code examples tested**: No untested code in sources documentation
- **Performance claims benchmarked**: No unverified performance assertions
- **Security advice validated**: Must reference official threat models
- **Migration guidance tested**: Must cover actual breaking changes

### Content Freshness Requirements

- **Green status**: Updated within last 6 months
- **Yellow status**: Updated within last year, needs review
- **Red status**: Older than 1 year, requires immediate verification
- **Broken links**: Immediate removal or replacement required

## Anti-Patterns to Avoid

### Authority Issues

- Don't mix authority levels within primary source sections
- Avoid community sources for core technical claims
- Don't include sources without clear authority attribution
- Ensure all Microsoft sources are official, not personal blogs

### Verification Problems

- Don't include unverified last-checked dates
- Avoid validation checklists that cannot be automatically tested
- Don't specify validation criteria without corresponding test procedures
- Ensure all validation requirements are actionable and specific

### Content Organization Issues

- Don't organize sources by URL instead of authority level
- Avoid duplicate sources across primary and secondary sections
- Don't include sources that are not actually referenced in content
- Ensure source descriptions accurately reflect content utility

## Integration with Content Generation

### Source Material Utilization

- **Content generation**: Sources provide authoritative material for all output formats
- **Validation pipeline**: Sources define testing requirements for generated content
- **Quality benchmarking**: Sources establish ground truth for accuracy validation
- **Update triggers**: Source changes trigger content regeneration

### Authority Propagation

- **High-confidence claims**: Only from A+ and A sources
- **Performance assertions**: Must trace to benchmarked sources
- **Security guidance**: Must reference official threat models
- **Migration advice**: Must be verified against actual API changes

### Verification Automation

- **Link checking**: Automated verification of source availability
- **Code compilation**: Automated testing of all code examples
- **Version compatibility**: Automated testing across .NET versions
- **Cross-platform validation**: Automated testing on supported platforms
