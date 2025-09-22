#!/bin/bash
# Complete knowledge graph update - runs all tools in correct sequence
# Exits immediately on any error

set -e

echo "🚀 Starting complete knowledge graph update for docs directory..."
echo "================================================================="

# Step 1: Validate Q&A pairs before processing
echo ""
echo "📝 Step 1: Validating Q&A pairs..."
if ! ./scripts/validate-qa-pairs.sh; then
    echo "❌ Step 1 failed - aborting update"
    exit 1
fi

# Step 2: Generate embeddings for all content
echo ""
echo "🔨 Step 2: Generating embeddings..."
if ! ./scripts/generate-embeddings.sh; then
    echo "❌ Step 2 failed - aborting update"
    exit 1
fi

# Step 3: Generate similarities and relationships
echo ""
echo "🔍 Step 3: Generating similarities..."
if ! ./scripts/generate-similarities.sh; then
    echo "❌ Step 3 failed - aborting update"
    exit 1
fi

# Step 4: Generate index files for all topics
echo ""
echo "📋 Step 4: Generating indexes..."
if ! ./scripts/generate-indexes.sh; then
    echo "❌ Step 4 failed - aborting update"
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
