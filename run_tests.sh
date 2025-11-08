#!/bin/bash

echo "🧪 SecureKit Test Runner v1.0.2"
echo "================================="

# Run core tests
echo "📊 Running core functionality tests..."
pytest tests/ -v --tb=short

# Count results
TEST_RESULT=$?
echo "----------------------------------------"

# Run security scan
echo "🔒 Running security scan..."
bandit -c .bandit.yml -r src/securekit -f txt

SECURITY_RESULT=$?
echo "----------------------------------------"

# Final summary
if [ $TEST_RESULT -eq 0 ] && [ $SECURITY_RESULT -eq 0 ]; then
    echo "🎉 ALL TESTS COMPLETED SUCCESSFULLY!"
    echo "🚀 SecureKit v1.0.2 is ready for production!"
    exit 0
else
    echo "❌ Some tests failed:"
    [ $TEST_RESULT -ne 0 ] && echo "   - Unit tests: FAILED"
    [ $SECURITY_RESULT -ne 0 ] && echo "   - Security scan: FAILED"
    exit 1
fi
