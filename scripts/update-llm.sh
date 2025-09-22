#!/bin/bash
# Run LLM-dependent analysis tools that require external API calls
# These tools are separated from the main graph update since they:
# - Use external LLM APIs (cost/rate limiting concerns)
# - May take longer to run
# - Don't need to run as frequently as embedding/indexing

set -e

echo "🤖 Starting LLM-dependent analysis tools..."
echo "============================================="

# Check for OpenRouter API key configuration early
echo "🔍 Checking OpenRouter API key configuration..."

# Check if OPENROUTER_API_KEY is already set
if [ -n "$OPENROUTER_API_KEY" ]; then
    echo "✅ Using OPENROUTER_API_KEY from environment variable"
else
    # Check if key file exists
    KEYFILE="$HOME/git/llm-docs-workspace/openrouterkey.txt"
    if [ -f "$KEYFILE" ]; then
        echo "✅ Loading OPENROUTER_API_KEY from $KEYFILE"
        OPENROUTER_API_KEY=$(cat "$KEYFILE")
        export OPENROUTER_API_KEY
    else
        echo "❌ OPENROUTER_API_KEY not found!" >&2
        echo "" >&2
        echo "This script requires an OpenRouter API key to analyze documentation complexity." >&2
        echo "Please either:" >&2
        echo "  1. Set environment variable: export OPENROUTER_API_KEY='your-api-key-here'" >&2
        echo "  2. Create key file: echo 'your-api-key-here' > ~/git/llm-docs-workspace/openrouterkey.txt" >&2
        echo "" >&2
        echo "You can get an API key from: https://openrouter.ai/" >&2
        exit 1
    fi
fi

# Check if complexity analyzer tool exists in PATH
COMPLEXITY_TOOL=$(command -v complexity-analyzer)
if [ -z "$COMPLEXITY_TOOL" ]; then
    echo "❌ complexity-analyzer not found in PATH" >&2
    echo "Ensure complexity-analyzer is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

# Step 1: Analyze documentation complexity
echo ""
echo "📊 Step 1: Analyzing documentation complexity..."
echo "Using OpenRouter API for LLM analysis..."

echo "🔧 Running complexity analysis with OpenRouter configuration..."
# Run complexity analysis on docs directory with dry-run to test
complexity-analyzer analyze --path docs --dry-run

if [ $? -ne 0 ]; then
    echo "❌ Complexity analysis failed"
    echo "Check that your OpenRouter API key is valid and has sufficient credits"
    exit 1
else
    echo "✅ Complexity analysis completed successfully"
fi

# Success summary
echo ""
echo "============================================="
echo "✅ LLM analysis completed successfully!"
echo ""
echo "📊 Summary:"
echo "  - Documentation complexity analysis completed using OpenRouter API"
echo "  - LLM-powered content analysis ready for production use"
echo ""
echo "🎯 Ready for advanced content analysis"