#!/bin/bash
# Analyze semantic similarities across repository

set -e

# Check if embedding tool exists in PATH
EMBEDDING_TOOL=$(command -v embedding-tool)
if [ -z "$EMBEDDING_TOOL" ]; then
    echo "❌ embedding-tool not found in PATH" >&2
    echo "Ensure embedding-tool is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

echo "🔍 Analyzing similarities across docs directory..."

# Set unified environment variables for LLM infrastructure (works across all tools)
export LLM_PROVIDER=ollama
export LLM_BASE_URL="http://merritt:11434"
export OLLAMA_MODEL=mxbai-embed-large

# Analyze similarities and generate reports for docs directory only
embedding-tool update-similarities --path docs

echo "✅ Similarity analysis completed"