#!/bin/bash
# Extract and sync keywords to topic-spec.md files

set -e

# Check if keyword-extractor tool exists in PATH
KEYWORD_TOOL=$(command -v keyword-extractor)
if [ -z "$KEYWORD_TOOL" ]; then
    echo "❌ keyword-extractor not found in PATH" >&2
    echo "Ensure keyword-extractor is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

# Check if topic-spec tool exists in PATH
TOPIC_SPEC=$(command -v topic-spec)
if [ -z "$TOPIC_SPEC" ]; then
    echo "❌ topic-spec not found in PATH" >&2
    echo "Ensure topic-spec is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

echo "📝 Extracting keywords from docs directory..."

# Generate global keywords analysis
keyword-extractor generate-unified docs

echo "🔄 Syncing keywords to topic-spec.md files..."

# Sync keywords to topic-spec files
topic-spec update-keywords docs --threshold 3.0

echo "✅ Keyword sync completed"
