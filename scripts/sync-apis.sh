#!/bin/bash
# Extract and sync API references to topic-spec.md files

set -e

# Check if api-extractor tool exists in PATH
API_TOOL=$(command -v api-extractor)
if [ -z "$API_TOOL" ]; then
    echo "❌ api-extractor not found in PATH" >&2
    echo "Ensure api-extractor is built and available in your PATH" >&2
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

echo "🔧 Extracting API references from docs directory..."

# Extract APIs for all topics
api-extractor analyze-apis docs

echo "🔄 Syncing APIs to topic-spec.md files..."

# Sync APIs to topic-spec files
topic-spec sync-apis docs

echo "✅ API sync completed"
