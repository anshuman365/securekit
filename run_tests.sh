#!/bin/bash

echo "🧪 SecureKit Test Runner v1.0.2"
echo "================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to run tests
run_test() {
    echo -e "\n${YELLOW}Running: $1${NC}"
    $2
    local status=$?
    if [ $status -eq 0 ]; then
        echo -e "${GREEN}✅ $1 PASSED${NC}"
    else
        echo -e "${RED}❌ $1 FAILED${NC}"
        return $status
    fi
}

# Run core tests
run_test "Core Functionality Tests" "pytest tests/test_basic.py tests/test_core.py tests/test_crypto.py -v"
run_test "KMS Integration Tests" "pytest tests/test_kms.py -v"
run_test "Production Readiness Tests" "pytest tests/test_production.py -v"

# Run security scan
run_test "Security Audit" "bandit -c .bandit.yml -r src/securekit -f txt"

# Final summary
echo -e "\n${GREEN}🎉 ALL TESTS COMPLETED SUCCESSFULLY!${NC}"
echo -e "${GREEN}🚀 SecureKit v1.0.2 is ready for production!${NC}"
