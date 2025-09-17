#!/bin/bash
# Generate embeddings for all content in the repository

set -e

# Check if embedding tool exists
EMBEDDING_TOOL="_tools/embedding-tool"
if [ ! -f "$EMBEDDING_TOOL" ]; then
    echo "❌ embedding-tool not found in _tools/"
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh $(pwd)/_tools"
    exit 1
fi

echo "🔨 Generating embeddings for docs directory..."

# Set Ollama server using .NET configuration environment variable format
export Embedding__BaseUrl="http://merritt:11434"

# Generate embeddings for docs directory only
"$EMBEDDING_TOOL" generate --path docs

echo "✅ Embeddings generated successfully"