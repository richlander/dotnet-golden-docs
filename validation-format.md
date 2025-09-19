# Validation Format Guide

This document defines the format and quality standards for validation documentation across all topics in the documentation set. Validation files specify testing requirements and verification rules for ensuring content accuracy and code functionality.

## Purpose

Validation documentation serves as the quality assurance foundation:
- **Testing requirements**: Specific criteria for validating content accuracy
- **Automated validation**: Machine-readable requirements for CI/CD pipelines
- **Quality gates**: Standards that must be met before content approval
- **Verification procedures**: Step-by-step testing protocols

## Format Structure

### Document Title

The H1 will be structured as: `# {Feature Name} - Validation`

### Required Sections

#### Validation Requirements
Core testing criteria that must be satisfied:

**Checkbox Format**:
```markdown
- [ ] Code examples compile and run on .NET 10
- [ ] Feature-specific functionality works correctly
- [ ] Cross-platform testing for platform-specific features
- [ ] Performance benchmarks meet documented expectations
- [ ] Security validation against threat model
```

**Requirements should be**:
- **Specific**: Clear, unambiguous testing criteria
- **Testable**: Can be verified automatically or through defined procedures
- **Measurable**: Success/failure can be determined objectively
- **Relevant**: Directly related to the topic's core functionality

#### Code Compilation Standards
Programming language and framework-specific compilation requirements:

**Structure**:
- **Target frameworks**: Specific .NET versions that must be supported
- **Compilation flags**: Required compiler settings or warnings
- **Dependency resolution**: Package and reference requirements
- **Platform targeting**: Architecture-specific compilation needs

#### Runtime Behavior Validation
Functional testing requirements for executable code:

**Structure**:
- **Expected outputs**: Specific results that code must produce
- **Error handling**: Exception scenarios that must be properly managed
- **Performance thresholds**: Minimum acceptable performance levels
- **Resource usage**: Memory, CPU, or I/O constraints

#### Cross-Platform Testing Requirements
Platform-specific validation criteria:

**Structure**:
- **Windows**: x64, ARM64 architecture testing
- **Linux**: Distribution and architecture requirements
- **macOS**: Architecture-specific testing needs
- **Mobile**: Platform-specific considerations (if applicable)

#### Security Validation Standards
Security-related testing and verification:

**Structure**:
- **Threat model alignment**: Security practices must match official guidance
- **Vulnerability testing**: Specific security scenarios to validate
- **Credential handling**: Secure practices for authentication and authorization
- **Data protection**: Encryption and data handling validation

#### Documentation Accuracy Verification
Content quality and accuracy standards:

**Structure**:
- **Technical accuracy**: Claims must be verifiable against official sources
- **Code-to-documentation sync**: Examples must match documented behavior
- **Version accuracy**: Features correctly attributed to .NET versions
- **Link validation**: All references must be accessible and current

## Validation Requirement Types

### Compilation Validation
```markdown
- [ ] Code examples compile with zero warnings using recommended compiler flags
- [ ] All necessary using statements and dependencies are included
- [ ] Examples compile against minimum supported .NET version
- [ ] Native AOT compilation succeeds for AOT-compatible examples
```

### Functional Validation
```markdown
- [ ] Code produces documented output when executed
- [ ] Error cases handle exceptions appropriately
- [ ] Performance meets documented expectations
- [ ] Integration examples work with specified frameworks
```

### Platform Validation
```markdown
- [ ] Windows x64 and ARM64 execution successful
- [ ] Linux x64 and ARM64 execution successful
- [ ] macOS x64 and ARM64 execution successful
- [ ] Platform-specific features work only on supported platforms
```

### Security Validation
```markdown
- [ ] No hardcoded credentials or secrets in examples
- [ ] Security practices align with official threat model
- [ ] Cryptographic examples use current, secure algorithms
- [ ] Authentication examples follow current best practices
```

### Version Compatibility Validation
```markdown
- [ ] Features are available in specified .NET versions
- [ ] Breaking changes are accurately documented
- [ ] Migration guidance reflects actual API changes
- [ ] Deprecated features are clearly marked with alternatives
```

## Automated Testing Integration

### CI/CD Pipeline Requirements
Validation requirements should be structured to enable automated testing:

**Machine-Readable Format**:
- Use consistent checkbox syntax for automated parsing
- Include specific test commands or procedures
- Reference automated test scripts where available
- Specify required test environments and configurations

**Example Integration**:
```markdown
- [ ] Compilation test: `dotnet build --configuration Release --framework net10.0`
- [ ] Unit test execution: `dotnet test --framework net10.0 --verbosity normal`
- [ ] Cross-platform test: Execute on Windows, Linux, macOS
- [ ] Performance benchmark: Execute benchmark suite with baseline comparison
```

### Test Environment Specifications
Define required testing environments:

**Environment Requirements**:
- **Operating systems**: Specific OS versions and configurations
- **Runtime versions**: .NET runtime and SDK version requirements
- **Dependencies**: Required packages, tools, or external services
- **Configuration**: Environment variables, configuration files, or setup procedures

## Quality Criteria

### Testability Standards
- **All requirements must be verifiable**: No subjective or opinion-based criteria
- **Clear success/failure conditions**: Unambiguous pass/fail determination
- **Reproducible procedures**: Same test should produce same results
- **Reasonable execution time**: Tests should complete within practical time limits

### Coverage Expectations
- **Core functionality**: All primary features must have validation requirements
- **Error scenarios**: Common failure modes must be tested
- **Integration points**: Framework and ecosystem integrations must be validated
- **Platform differences**: Platform-specific behavior must be verified

### Maintenance Requirements
- **Version updates**: Requirements must be updated with .NET releases
- **Technology changes**: New testing requirements for evolving technologies
- **Security updates**: Security validation updated with threat model changes
- **Performance baselines**: Performance criteria updated with infrastructure changes

## Validation Workflow

### Pre-Publication Validation
Required validation steps before content is published:

1. **Compilation verification**: All code examples compile successfully
2. **Functional testing**: Examples produce expected outputs
3. **Cross-platform testing**: Platform-specific requirements validated
4. **Security review**: Security practices verified against standards
5. **Documentation accuracy**: Technical claims verified against sources

### Continuous Validation
Ongoing validation requirements:

1. **Monthly**: Link validation and source accessibility
2. **Quarterly**: Code compilation against current frameworks
3. **Semi-annually**: Full cross-platform testing cycle
4. **Annually**: Comprehensive security and performance review

### Update-Triggered Validation
Validation requirements when content changes:

1. **Content updates**: Re-run all applicable validation requirements
2. **Framework updates**: Validate against new .NET versions
3. **Security updates**: Re-validate security practices
4. **Performance changes**: Re-baseline performance expectations

## Anti-Patterns to Avoid

### Validation Requirement Issues
- Don't create requirements that cannot be automatically tested
- Avoid subjective criteria that depend on human judgment
- Don't specify requirements without clear success criteria
- Ensure requirements are specific to the actual content

### Testing Procedure Problems
- Don't reference test procedures that don't exist
- Avoid requirements that are too expensive to execute regularly
- Don't create requirements that are unreliable or flaky
- Ensure test environments are actually available

### Maintenance Issues
- Don't create requirements that become obsolete quickly
- Avoid requirements that are tied to specific infrastructure
- Don't specify validation criteria without update procedures
- Ensure requirements scale with content volume

## Integration with Content Pipeline

### Content Generation Validation
- **Generated content**: All generated content must pass validation requirements
- **Template validation**: Content generation templates must produce valid output
- **Quality gates**: Generated content cannot be published without validation
- **Feedback loops**: Validation failures inform content generation improvements

### Source Material Validation
- **Source accuracy**: Source materials must meet validation standards
- **Code example testing**: All source code examples must be validated
- **Authority verification**: Source authority claims must be validated
- **Currency checking**: Source material freshness must be verified

### Knowledge Graph Validation
- **Relationship accuracy**: Topic relationships must be validated
- **Semantic consistency**: Generated similarities must align with validation
- **Cross-reference integrity**: All cross-references must be validated
- **Navigation accuracy**: Knowledge graph navigation must be functional