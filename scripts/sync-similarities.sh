#!/bin/bash
# Sync similarity data to topic-spec.md files

set -e

# Check if topic-spec tool exists in PATH
TOPIC_SPEC=$(command -v topic-spec)
if [ -z "$TOPIC_SPEC" ]; then
    echo "❌ topic-spec not found in PATH" >&2
    echo "Ensure topic-spec is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

echo "🔄 Syncing similarities to topic-spec.md files..."

# Sync similarities from _similarities folders to topic-spec files
topic-spec sync-similarities docs

echo "✅ Similarity sync completed"
