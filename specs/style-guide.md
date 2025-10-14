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
