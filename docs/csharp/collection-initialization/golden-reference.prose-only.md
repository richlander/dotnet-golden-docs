# Collection Initialization
## Overview
Collection initialization solves a fundamental programming task: creating a collection and specifying its initial values in a single statement. Rather than creating an empty collection and then adding elements one by one, you can declare the collection and populate it at the same time.
Different collection types have different requirements. Arrays, spans, and  instances need their complete set of values upfront - once created, their size is fixed. Lists and dictionaries can start with an initial set of values and have more added later.
Collection expressions provide the simplest syntax for most scenarios. When you know the values as you write the code, collection expressions offer the clearest way to express your intent:
## The Primary Collection Initialization Pattern: Collection Expressions
When you know the values upfront, collection expressions provide the clearest syntax for collection initialization:
### Combining Collections
The spread operator  enables composing collections from existing ones:
### Other Collection Types
Collection expressions work with most collection types:
For comprehensive coverage of collection expressions including performance characteristics and advanced patterns, see the Collection Expressions documentation.
## Dictionary Initialization
Dictionaries don't support collection expressions, so they use collection initializer syntax:
### Nested Dictionary Values
## Imperative Construction Patterns
When values aren't known statically, the imperative construction initialization syntax the flexibility you need:
### Capacity Planning
Pre-sizing collections improves performance when you know the approximate size:
## Target-Typed New
The  syntax eliminates redundant type information:
### Method Calls
Target-typed new works naturally with method parameters and returns:
## Collection Initializer Syntax
Collection initializers provide an alternative to collection expressions:
## Array Initialization
Arrays offer multiple syntax options:
## Span Initialization
Spans offer similar syntax options, with collection expressions as the preferred approach:
## Initialization from Data Sources
Collections can be initialized from existing data:
## Nested Collections
Complex data structures combine initialization patterns:
## Performance Considerations
### Collection Type Selection
Choose the collection type that matches your usage:
### Capacity and Allocation
## Common Patterns
### Conditional Elements
### Method Returns
### LINQ Integration
## Best Practices
1. **Use collection expressions for known values**: Most direct syntax when elements are known upfront
2. **Use initializers for dictionaries**: Collection expressions don't support dictionary syntax
3. **Pre-size for large collections**: Specify capacity when building collections imperatively
4. **Choose appropriate collection types**: Match the collection to your access patterns
5. **Use target-typed new**: Eliminate redundant type information with 
6. **Leverage spread operator**: Compose collections cleanly from existing sources
## Common Pitfalls
### Null Reference Issues
### Shared References
### Type Inference Limitations