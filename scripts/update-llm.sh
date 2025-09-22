#!/bin/bash
# Run LLM-dependent analysis tools that require external API calls
# These tools are separated from the main graph update since they:
# - Use external LLM APIs (cost/rate limiting concerns)
# - May take longer to run
# - Don't need to run as frequently as embedding/indexing

set -e

echo "🤖 Starting LLM-dependent analysis tools..."
echo "============================================="

# Check if complexity analyzer tool exists
COMPLEXITY_TOOL="_tools/complexity-analyzer"
if [ ! -f "$COMPLEXITY_TOOL" ]; then
    echo "❌ complexity-analyzer not found in _tools/"
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh $(pwd)/_tools"
    exit 1
fi

# Step 1: Analyze documentation complexity
echo ""
echo "📊 Step 1: Analyzing documentation complexity..."
echo "Note: This requires an LLM API (OpenRouter recommended)"

# Check for required environment variables
if [ -z "$OPENROUTER_API_KEY" ]; then
    echo "❌ OPENROUTER_API_KEY environment variable not set"
    echo "Please set your OpenRouter API key:"
    echo "  export OPENROUTER_API_KEY=your_key_here"
    exit 1
fi

# Configure to use OpenRouter instead of Ollama
export Embedding__BaseUrl="https://openrouter.ai/api"
export Embedding__ModelName="openai/gpt-4o"

# Run complexity analysis on docs directory
"$COMPLEXITY_TOOL" analyze --path docs

if [ $? -ne 0 ]; then
    echo "❌ Complexity analysis failed"
    exit 1
fi

# Success summary
echo ""
echo "============================================="
echo "✅ LLM analysis completed successfully!"
echo ""
echo "📊 Summary:"
echo "  - Documentation complexity analysis completed"
echo "  - Topic specifications updated with complexity scores"
echo ""
echo "🎯 Ready for advanced content analysis"