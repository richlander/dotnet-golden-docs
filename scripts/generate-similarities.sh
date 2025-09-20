#!/bin/bash
# Analyze semantic similarities across repository

set -e

# Check if embedding tool exists
EMBEDDING_TOOL="_tools/embedding-tool"
if [ ! -f "$EMBEDDING_TOOL" ]; then
    echo "❌ embedding-tool not found in _tools/"
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh $(pwd)/_tools"
    exit 1
fi

echo "🔍 Analyzing similarities across docs directory..."

# Set Ollama server using .NET configuration environment variable format
export Embedding__BaseUrl="http://merritt:11434"

# Analyze similarities and generate reports for docs directory only
"$EMBEDDING_TOOL" update-similarities --path docs

echo "✅ Similarity analysis completed"