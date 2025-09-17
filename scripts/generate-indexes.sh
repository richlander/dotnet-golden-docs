#!/bin/bash
# Generate index.json files for all topics in the repository

set -e

# Check if index tool exists
INDEX_TOOL="_tools/index-tool"
if [ ! -f "$INDEX_TOOL" ]; then
    echo "❌ index-tool not found in _tools/"
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh $(pwd)/_tools"
    exit 1
fi

echo "📋 Generating index.json files for all topics in docs directory..."

# Set docs root
DOCS_ROOT="$(pwd)/docs"

# Use generate-all command to properly handle root index and topic hierarchy
"$INDEX_TOOL" generate-all --root-path "$DOCS_ROOT"

echo "✅ Index generation completed"