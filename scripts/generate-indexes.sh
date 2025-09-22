#!/bin/bash
# Generate index.json files for all topics in the repository

set -e

# Check if index tool exists in PATH
INDEX_TOOL=$(command -v index-tool)
if [ -z "$INDEX_TOOL" ]; then
    echo "❌ index-tool not found in PATH" >&2
    echo "Ensure index-tool is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

echo "📋 Generating index.json files for all topics in docs directory..."

# Set docs root
DOCS_ROOT="$(pwd)/docs"

# Use generate-all command to properly handle root index and topic hierarchy
index-tool generate-all --root-path "$DOCS_ROOT"

echo "✅ Index generation completed"