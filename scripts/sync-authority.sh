#!/bin/bash
# Calculate and sync authority scores to topic-spec.md files

set -e

# Check if topic-spec tool exists in PATH
TOPIC_SPEC=$(command -v topic-spec)
if [ -z "$TOPIC_SPEC" ]; then
    echo "❌ topic-spec not found in PATH" >&2
    echo "Ensure topic-spec is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

echo "🎯 Calculating authority scores for topic relationships..."

# Calculate and sync authority scores based on shared keywords
topic-spec sync-authority docs

echo "✅ Authority score sync completed"
