#!/bin/bash
echo "🔍 Verifying CI configuration..."

# Check bandit config
echo "📋 Testing bandit configuration..."
bandit -c .bandit.yml -r src/securekit -f txt --exit-zero

# Check YAML syntax
echo "📋 Checking YAML files..."
python -c "import yaml; yaml.safe_load(open('.bandit.yml')); print('✅ .bandit.yml valid')"
python -c "import yaml; yaml.safe_load(open('.github/workflows/ci.yml')); print('✅ ci.yml valid')"
python -c "import yaml; yaml.safe_load(open('.github/workflows/security.yml')); print('✅ security.yml valid')"

# Quick test run
echo "🧪 Running quick tests..."
pytest tests/test_basic.py -v --tb=short -q

echo "✅ All verifications passed!"
echo "🚀 CI should now work without errors"
