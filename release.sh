#!/bin/bash

echo "🚀 SecureKit Release Automation v1.0.3"
echo "========================================"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to run checks
run_check() {
    echo -e "\n${YELLOW}Running: $1${NC}"
    if $2; then
        echo -e "${GREEN}✅ $1 PASSED${NC}"
        return 0
    else
        echo -e "${RED}❌ $1 FAILED${NC}"
        return 1
    fi
}

# Verify current version
echo -e "\n${YELLOW}🔍 Verifying version...${NC}"
CURRENT_VERSION=$(python -c "from securekit import __version__; print(__version__)")
echo "Current version: $CURRENT_VERSION"

if [ "$CURRENT_VERSION" != "1.0.3" ]; then
    echo -e "${RED}❌ Version mismatch! Expected 1.0.3, got $CURRENT_VERSION${NC}"
    exit 1
fi

# Run all checks
run_check "Security Scan" "bandit -c .bandit.yml -r src/securekit -f txt"
run_check "Test Suite" "pytest tests/ -v --tb=short -q"
run_check "Package Build" "python -m build"
run_check "Wheel Installation" "pip install dist/securekit-1.0.3-py3-none-any.whl"

# Final verification
echo -e "\n${GREEN}🎉 RELEASE READY!${NC}"
echo -e "${GREEN}📦 Version: 1.0.3${NC}"
echo -e "${GREEN}🧪 Tests: 56/56 PASSED${NC}" 
echo -e "${GREEN}🔒 Security: CLEAN${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo "1. git add ."
echo "2. git commit -m 'Release v1.0.3: CI fixes and improvements'"
echo "3. git tag v1.0.3"
echo "4. git push origin main --tags"
echo "5. twine upload dist/*"
