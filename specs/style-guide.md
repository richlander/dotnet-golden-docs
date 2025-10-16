# Style Guide for Golden Documentation

This style guide defines writing standards for golden reference documents that form the foundation of our LLM-consumable documentation system.

## Writing Guidelines

The following guidelines are adapted from the [Microsoft Writing Style Guide](https://learn.microsoft.com/style-guide/global-communications/writing-tips):

### Clarity and Simplicity

**Write short, simple sentences.** Punctuating a sentence with more than a few commas and end punctuation usually indicates a complex sentence. Consider rewriting it or breaking it into multiple sentences.

**Avoid idioms, colloquial expressions, and culture-specific references.** They can be confusing for non-native English speakers and hard to localize. Consider the worldwide implications of what you write. Customers in other locales may not know much about the history and culture of your country.

**Avoid modifier stacks.** Long chains of modifying words are confusing even to native English speakers. For example, say "Your migration will proceed more smoothly if you have a project plan that's well thought out," not "With an extremely well thought-out Windows migration project plan, your migration will go more smoothly."

**Use active voice and indicative mood most of the time.** Use imperative mood in procedures.

**Keep adjectives and adverbs close to the words they modify.** Pay particular attention to the placement of *only*.

**Avoid linking more than three phrases or clauses by using coordinate conjunctions** such as *and*, *or*, or *but*. Better yet, avoid linking more than two.

### Grammar and Structure

**Use conventional English grammar and punctuation.** Try to balance a friendly voice with clear, accurate English.

**Use simple sentence structures.** Write sentences that use standard word order (that is, subject + verb + object) whenever possible.

**Use one word for a concept, and use it consistently.** Avoid using synonyms to refer to the same concept or feature. And don't use the same word to refer to multiple concepts or features.

**Limit your use of sentence fragments.** Sentence fragments can reduce clarity and comprehension.

### Word Choice for Retrieval

**Prefer simple, direct language over formal alternatives.** Simpler words improve both readability and semantic similarity matching in retrieval systems. Users query with direct language, not formal prose.

**Replace formal phrases with simpler alternatives:**

- "operates through" → "provides" or "uses"
- "fundamental patterns" → "operations" or direct description
- "operational modes" → "modes" or "approaches"
- "utilize/utilizing" → "use/using"
- "facilitate/facilitating" → "allow/enable/support"
- "leverage/leveraging" → "use/using"
- "fundamental ways" → "key ways" or "important ways"

**Avoid vague temporal terms that age quickly:**

- **Don't use "modern"** - What is "modern" changes constantly. Don't write "modern .NET", "modern C#", "modern approaches", etc. Instead, be specific about what you mean or describe the actual characteristic (e.g., "asynchronous", "allocation-free", "strongly-typed").
- **Don't use "current"** - Similar to "modern", this is a temporal qualifier. Just describe the platform as it is. Instead of "current .NET", just say ".NET" or be specific: ".NET 8 and later".
- **Don't use "new"** - Like "modern", this becomes outdated. Instead of "new async APIs", say "asynchronous APIs" or "async APIs added in .NET X".
- **Don't use "recent" or "recently"** - Be specific: ".NET 10 introduces..." or "Starting in .NET 9..." instead of "recent versions".

**Examples:**

❌ **Avoid:**
- "modern .NET applications"
- "current .NET"
- "modern C# features"
- "modern JSON serialization"
- "new performance improvements"

✅ **Prefer:**
- ".NET applications" or ".NET 8 and later" (when version matters)
- ".NET" or ".NET 8 and later"
- "C# 12 features" or "language features"
- "System.Text.Json" or "recommended JSON serialization"
- "performance improvements in .NET 10" or "performance optimizations"

**Break complex sentences into shorter ones.** Each sentence should express one clear idea. This improves both comprehension and retrieval scoring.

❌ **Avoid:**
```markdown
System.Text.Json is a high-performance JSON serialization library that converts between .NET objects and JSON text, prioritizing speed and memory efficiency for modern cloud and web applications.
```

✅ **Prefer:**
```markdown
System.Text.Json is a JSON serialization library for .NET. It converts between .NET objects and JSON text. The library prioritizes speed and memory efficiency for modern cloud and web applications.
```

## Document Structure

### Semantic Headings for RAG

**Use domain-specific headings that define semantic boundaries.** Headings serve as hierarchical anchors for retrieval systems. Each heading should clearly identify the specific domain, pattern, or integration context being discussed.

**Write headings as query targets.** Headings should match common search terms and domain-specific descriptions that users would naturally query. Use simple, direct terms like "Using with [technology]" rather than abstract terms like "Patterns" or "Approaches."

**Avoid generic parent headings.** Generic organizational headings like "Common Scenarios" or "Usage" add minimal semantic value and score lower in retrieval than specific task-focused headings. When you find yourself creating a generic parent heading, consider promoting the subsections directly to H2 level instead.

Testing shows that specific task headings at H2 level perform better than nesting them under generic parents:

❌ **Avoid this structure:**
```markdown
## Usage
### Creating a JsonSerializerContext
### Naming Policies
### Generic Methods with JsonTypeInfo
```

✅ **Prefer this structure:**
```markdown
## Creating a JsonSerializerContext
## Naming Policies
## Generic Methods with JsonTypeInfo
```

When using domain-specific patterns, the pattern is clear from context:

**Example hierarchy:**
```markdown
# System.Text.Json Source Generation

## Using with ASP.NET Core
### Configuring for Web APIs
### Endpoint Serialization

## Using with HttpClient
### GET Operations
### POST Operations
```

In this structure, "Using with ASP.NET Core" provides semantic context for its child sections. A RAG system chunking "Configuring for Web APIs" would include the parent heading, creating a meaningful semantic boundary: "Using with ASP.NET Core → Configuring for Web APIs."

**Summary:**
- ❌ **Avoid:** Generic containers ("Common Scenarios", "Usage", "Examples")
- ✅ **Prefer:** Specific task headings ("Creating a JsonSerializerContext", "Naming Policies")
- ✅ **Prefer:** Domain-specific integration headings ("Using with ASP.NET Core", "Using with HttpClient")

## Topic Segmentation

**Create topics at the right granularity for optimal embeddings.** Topic size directly impacts retrieval quality. Very small topics create weak semantic signals, while overly broad topics dilute meaning and reduce precision.

**Target the 500-1500 token range for themed groupings.** This provides enough context for strong embeddings while maintaining focused semantic meaning.

### Topic Types

Understanding different topic types helps create coherent documentation architecture:

#### Feature Topics

The primary role of topics is to describe a feature, like "collection-expressions" or "system-text-json-jsonserializer". These topics focus on a single API, type, or language feature and explain how to use it.

#### Intersection Topics

Intersection topics describe how multiple features work together. For example, "system-text-json-source-generation" is an intersection topic that includes significant mention of Native AOT, showing how source generation and AOT compilation interact.

#### Family Topics

If a feature area is large, it can be broken into multiple topics, as has been done for System.Text.Json. When that happens, the topics are dedicated to specific features or APIs. The family topic, like "system-text-json", should focus on introducing the area and explaining what the various other features are for or how to choose among different API paths. The family topic should typically not be the largest topic within the family—it's an orientation guide, not comprehensive documentation.

#### Thematic Grouping Topics

It often doesn't make sense to describe every aspect or small API in a feature topic, like for JsonSerializer. Instead, thematic groupings should be selected that provide coherence (in both a thinking and documentation sense). An example would be "JSON Validation and Security" or "Collections Performance". These topics group related features by purpose or use case rather than by API surface area.

#### Version Topics

This topic type is intended to be used the most sparingly. The primary purpose of this topic type is to ship in NuGet packages or other vehicles where we want to share the latest features. We can create version topics for .NET 10 or C# 14. A copy of these topics may be in code repos (like dotnet/runtime) so that they can be included in a NuGet package.

**Version topics are ephemeral.** Once .NET 11 ships, the .NET 10 topic should be deleted and a new .NET 11 version (or C# 15) should be created. The intent is that new features are also included in the other topic types (feature, intersection, thematic grouping) so that when the version-specific topics are deleted, no valuable information is lost.

### Good Topic Scopes

**Major areas** define the primary namespace or technology:
- `System.Text.Json`
- `ASP.NET Core Minimal APIs`

**Major features** focus on a single significant API or capability:
- `System.Text.Json.JsonSerializer`
- `HttpClient`

**Thematic groupings** combine related small features by shared purpose:
- `System.Text.Json Serialization Customization` (custom converters, naming policies, resolver patterns)
- `System.Text.Json Performance Features` (streaming, ref handling, buffer sizing)
- `System.Text.Json Configuration & Options` (JsonSerializerOptions deep dive)

**Functional groupings** organize by integration or scenario:
- `Using System.Text.Json with Native AOT`
- `Using HttpClient with Dependency Injection`

### Poor Topic Scopes

❌ **Avoid large encompassing documents** that try to cover everything about a technology. A 10,000 token "everything about System.Text.Json" document creates embeddings that represent too many concepts, reducing retrieval precision.

❌ **Avoid release-specific documents** like ".NET 10 Features" that group unrelated features by version. These create weak semantic relationships and poor retrieval.

❌ **Avoid very small topics** (< 200 tokens) that lack sufficient context for meaningful embeddings. Combine related small features into themed documents instead.

### Why This Matters for Embeddings

Very small documents (< 200 tokens) often create poor embeddings because they lack enough semantic signal to be distinctive. Large catch-all documents dilute semantic meaning—the embedding represents "everything" rather than specific concepts, leading to poor retrieval. Themed groupings in the 500-1500 token range hit the sweet spot with enough context for good embeddings while remaining focused enough for precision.
