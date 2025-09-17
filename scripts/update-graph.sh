#!/bin/bash
# Complete knowledge graph update - runs all tools in correct sequence
# Exits immediately on any error

set -e

echo "🚀 Starting complete knowledge graph update for docs directory..."
echo "================================================================="

# Step 1: Validate Q&A pairs before processing
echo ""
echo "📝 Step 1: Validating Q&A pairs..."
./scripts/validate-qa-pairs.sh
if [ $? -ne 0 ]; then
    echo "❌ Q&A validation failed - aborting update"
    exit 1
fi

# Step 2: Generate embeddings for all content
echo ""
echo "🔨 Step 2: Generating embeddings..."
./scripts/generate-embeddings.sh
if [ $? -ne 0 ]; then
    echo "❌ Embedding generation failed - aborting update"
    exit 1
fi

# Step 3: Analyze similarities and relationships
echo ""
echo "🔍 Step 3: Analyzing similarities..."
./scripts/analyze-similarities.sh
if [ $? -ne 0 ]; then
    echo "❌ Similarity analysis failed - aborting update"
    exit 1
fi

# Step 4: Generate index files for all topics
echo ""
echo "📋 Step 4: Generating indexes..."
./scripts/generate-indexes.sh
if [ $? -ne 0 ]; then
    echo "❌ Index generation failed - aborting update"
    exit 1
fi

# Success summary
echo ""
echo "================================================================="
echo "✅ Knowledge graph update completed successfully!"
echo ""
echo "📊 Summary:"
echo "  - All Q&A pairs in docs/ validated"
echo "  - Embeddings generated for all docs/ content"
echo "  - Similarity analysis completed across docs/"
echo "  - Index files generated for all docs/ topics"
echo ""
echo "🎯 Ready for content generation pipeline"