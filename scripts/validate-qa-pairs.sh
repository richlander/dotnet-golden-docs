#!/bin/bash
# Validate Q&A pairs for parsing issues

set -e

# Check if qa-test-generator exists
QA_TOOL="_tools/qa-test-generator"
if [ ! -f "$QA_TOOL" ]; then
    echo "❌ qa-test-generator not found in _tools/"
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh $(pwd)/_tools"
    exit 1
fi

echo "✅ Validating Q&A pairs..."

# Validate docs directory only
"$QA_TOOL" validate --input-repo docs

echo "✅ Q&A validation completed"