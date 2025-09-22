#!/bin/bash
# Validate Q&A pairs for parsing issues

set -e

# Check if qa-test-generator exists in PATH
QA_TOOL=$(command -v qa-test-generator)
if [ -z "$QA_TOOL" ]; then
    echo "❌ qa-test-generator not found in PATH" >&2
    echo "Ensure qa-test-generator is built and available in your PATH" >&2
    echo "Run: cd ../dotnet-docs-llm-tools && ./build.sh && export PATH=\$PATH:\$(pwd)/_tools" >&2
    exit 1
fi

echo "✅ Validating Q&A pairs..."

# Validate docs directory only
qa-test-generator validate --input-repo docs

echo "✅ Q&A validation completed"