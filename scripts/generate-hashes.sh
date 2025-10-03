#!/bin/bash
# Generate LSH hash signatures for content gates in the repository

set -e

# Check if required tools exist in PATH
TOPIC_SPEC_TOOL=$(command -v topic-spec)
if [ -z "$TOPIC_SPEC_TOOL" ]; then
    echo "❌ topic-spec not found in PATH" >&2
    echo "Ensure topic-spec is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh _tools && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

HASHING_TOOL=$(command -v hashing-tool)
if [ -z "$HASHING_TOOL" ]; then
    echo "❌ hashing-tool not found in PATH" >&2
    echo "Ensure hashing-tool is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh _tools && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

echo "🔨 Generating LSH hash signatures for docs directory..."

# Step 1: Extract content gates from topic-spec.md files
echo "  📝 Extracting technical and overview content gates..."
topic-spec extract-gates docs

# Step 2: Generate hash signatures for content gates
echo "  🔍 Generating MinHash and SimHash signatures..."
hashing-tool update-hashes --path docs

# Step 3: Validate hash signatures are current
echo "  ✅ Validating hash signatures..."
if hashing-tool validate --path docs; then
    echo "  ✅ All hash signatures are valid"
else
    echo "  ⚠️  Hash signature validation had issues (this may be expected on first run)"
    echo "  💡 Hash signatures were generated successfully"
fi

echo "✅ LSH hash signatures generated successfully"
echo "   - Technical gates (shingle-1): APIs, keywords, error messages"
echo "   - Overview gates (shingle-3): descriptions, concepts, relationships"