#!/bin/bash
# Complete knowledge graph update - runs all tools in correct sequence
# Exits immediately on any error

set -e

echo "🚀 Starting complete knowledge graph update for docs directory..."
echo "================================================================="

# Step 1: Extract and sync keywords
echo ""
echo "📝 Step 1: Extracting and syncing keywords..."
if ! ./scripts/sync-keywords.sh; then
    echo "❌ Step 1 failed - aborting update"
    exit 1
fi

# Step 2: Extract and sync API references
echo ""
echo "🔧 Step 2: Extracting and syncing API references..."
if ! ./scripts/sync-apis.sh; then
    echo "❌ Step 2 failed - aborting update"
    exit 1
fi

# Step 3: Generate embeddings for all content
echo ""
echo "🔨 Step 3: Generating embeddings..."
if ! ./scripts/generate-embeddings.sh; then
    echo "❌ Step 3 failed - aborting update"
    exit 1
fi

# Step 4: Generate LSH hash signatures for content gates
echo ""
echo "🔍 Step 4: Generating hash signatures..."
if ! ./scripts/generate-hashes.sh; then
    echo "❌ Step 4 failed - aborting update"
    exit 1
fi

# Step 5: Generate similarities and relationships
echo ""
echo "🔍 Step 5: Generating similarities..."
if ! ./scripts/generate-similarities.sh; then
    echo "❌ Step 5 failed - aborting update"
    exit 1
fi

# Step 6: Sync similarities to topic-spec.md files
echo ""
echo "🔄 Step 6: Syncing similarities to topic specifications..."
if ! ./scripts/sync-similarities.sh; then
    echo "❌ Step 6 failed - aborting update"
    exit 1
fi

# Step 7: Calculate and sync authority scores
echo ""
echo "🎯 Step 7: Calculating authority scores..."
if ! ./scripts/sync-authority.sh; then
    echo "❌ Step 7 failed - aborting update"
    exit 1
fi

# Step 8: Generate index files for all topics
echo ""
echo "📋 Step 8: Generating indexes..."
if ! ./scripts/generate-indexes.sh; then
    echo "❌ Step 8 failed - aborting update"
    exit 1
fi

# Success summary
echo ""
echo "================================================================="
echo "✅ Knowledge graph update completed successfully!"
echo ""
echo "📊 Summary:"
echo "  - Keywords extracted and synced to topic-spec.md files"
echo "  - API references extracted and synced to topic-spec.md files"
echo "  - Embeddings generated for all docs/ content"
echo "  - LSH hash signatures generated for content gates"
echo "  - Similarity analysis completed across docs/"
echo "  - Similarities synced to topic-spec.md files"
echo "  - Authority scores calculated and synced"
echo "  - Index files generated for all docs/ topics"
echo ""
echo "🎯 Ready for content generation pipeline"
