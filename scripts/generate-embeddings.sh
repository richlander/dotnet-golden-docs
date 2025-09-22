#!/bin/bash
# Generate embeddings for all content in the repository

set -e

# Check if embedding tool exists in PATH
EMBEDDING_TOOL=$(command -v embedding-tool)
if [ -z "$EMBEDDING_TOOL" ]; then
    echo "❌ embedding-tool not found in PATH" >&2
    echo "Ensure embedding-tool is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

echo "🔨 Generating embeddings for docs directory..."

# Set Ollama server using .NET configuration environment variable format
export Embedding__BaseUrl="http://merritt:11434"

# Generate embeddings for docs directory only
embedding-tool update-embeddings --path docs

echo "✅ Embeddings generated successfully"