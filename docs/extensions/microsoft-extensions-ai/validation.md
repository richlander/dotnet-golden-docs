# Microsoft.Extensions.AI - Validation Document

## Validation Criteria

This document outlines the validation criteria for Microsoft.Extensions.AI content to ensure accuracy, completeness, and alignment with official documentation.

### Technical Accuracy

- [ ] Interface definitions match official API: All `IChatClient` and `IEmbeddingGenerator` method signatures, parameters, and return types are accurate
- [ ] Package references are correct: NuGet package names, versions, and dependencies align with official releases
- [ ] Code examples compile: All code snippets compile against the specified .NET version and package versions
- [ ] Middleware composition order: Examples demonstrate proper middleware ordering for optimal performance and functionality
- [ ] Function calling syntax: AI function definitions and invocation patterns match official guidelines

### Content Completeness

- [ ] Core interfaces covered: Both `IChatClient` and `IEmbeddingGenerator` interfaces are thoroughly documented
- [ ] Middleware patterns: Caching, telemetry, rate limiting, and custom middleware examples are included
- [ ] Dependency injection: DI registration patterns and service configuration are demonstrated
- [ ] Function calling scenarios: Tool invocation, automatic function discovery, and best practices are covered
- [ ] Cross-provider patterns: Examples show provider-agnostic usage and switching capabilities

### Documentation Alignment

- [ ] Consistent with official docs: Content aligns with learn.microsoft.com documentation for Microsoft.Extensions.AI
- [ ] Package guidance matches: Library vs application package reference guidance is consistent
- [ ] API surface accuracy: All public types, methods, and properties are correctly represented
- [ ] Configuration patterns: DI and builder pattern usage matches official examples
- [ ] Best practices alignment: Recommendations align with official guidance and community standards

### Example Quality

- [ ] Realistic scenarios: Examples demonstrate practical, real-world usage patterns
- [ ] Progressive complexity: Examples build from simple to advanced scenarios logically
- [ ] Error handling: Examples include appropriate error handling and resilience patterns
- [ ] Resource management: Proper disposal and memory management patterns are demonstrated
- [ ] Security considerations: Examples avoid exposing sensitive operations through AI function calling

### Version Compatibility

- [ ] Target framework accuracy: .NET version requirements are correctly specified
- [ ] Package version consistency: All referenced package versions are compatible and current
- [ ] API availability: Features are correctly attributed to package versions where they were introduced
- [ ] Preview considerations: Preview/experimental features are clearly marked as such

## Validation Checklist

### Code Compilation Tests

- [ ] Basic `IChatClient` usage examples compile
- [ ] Streaming response examples compile
- [ ] Function calling examples compile with correct `AIFunction` usage
- [ ] Middleware composition examples compile with proper builder syntax
- [ ] Dependency injection examples compile with correct service registration
- [ ] Custom middleware examples compile with proper `DelegatingChatClient` inheritance

### Functional Validation

- [ ] Package installation commands work with specified versions
- [ ] DI registration examples work with Microsoft.Extensions.DependencyInjection
- [ ] Builder pattern examples produce functional client instances
- [ ] Function calling examples properly bind .NET methods to AI tools
- [ ] Caching examples work with Microsoft.Extensions.Caching abstractions
- [ ] Telemetry examples integrate with OpenTelemetry correctly

### Content Cross-References

- [ ] Links to official documentation are valid and current
- [ ] Cross-references to related .NET features (DI, caching, telemetry) are accurate
- [ ] Package references link to correct NuGet pages
- [ ] Blog post and announcement references are current
- [ ] Code sample repositories are accessible and contain relevant examples

### Performance and Security

- [ ] Middleware ordering recommendations follow performance best practices
- [ ] Memory management guidance is appropriate for streaming scenarios
- [ ] Function calling security considerations are properly addressed
- [ ] Rate limiting examples demonstrate proper resource protection
- [ ] Caching examples show appropriate key management and cache invalidation

## Update Requirements

### When to Update

- New preview releases of Microsoft.Extensions.AI packages
- Changes to core interfaces or middleware APIs
- Updates to official documentation or best practices
- New integration examples or supported providers
- Security advisories or breaking changes

### Update Process

1. Review official sources: Check learn.microsoft.com, NuGet packages, and GitHub repository for changes
2. Validate examples: Ensure all code examples still compile and function correctly
3. Update version references: Modify package versions and .NET framework targets as needed
4. Test middleware composition: Verify builder patterns and middleware ordering still work
5. Check cross-references: Validate all external links and documentation references

### Quality Gates

- All validation criteria must pass before content updates
- Code examples must be tested against latest package versions
- Content must align with current official documentation
- Breaking changes must be clearly documented and migration guidance provided

## Known Limitations

### Preview Technology

- API surface may change between preview releases
- Not recommended for production use without careful consideration
- Limited long-term support guarantees during preview period

### Provider Dependencies

- Actual AI service implementations required for functional testing
- Some middleware may not work with all provider implementations
- Function calling support varies by AI service provider

### Testing Constraints

- Full end-to-end testing requires API keys and external service access
- Some validation scenarios require integration with cloud AI services
- Performance testing requires representative workloads and infrastructure