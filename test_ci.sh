#!/bin/bash
echo "🔍 Testing CI configuration..."

echo "📋 Testing bandit configuration..."
bandit -c .bandit.yml -r src/securekit -f txt

echo "📋 Validating YAML files..."
python3 -c "
import yaml
try:
    yaml.safe_load(open('.bandit.yml'))
    print('✅ .bandit.yml valid')
except Exception as e:
    print('❌ .bandit.yml invalid:', e)

try:
    yaml.safe_load(open('.github/workflows/ci.yml'))  
    print('✅ ci.yml valid')
except Exception as e:
    print('❌ ci.yml invalid:', e)

try:
    yaml.safe_load(open('.github/workflows/security.yml'))
    print('✅ security.yml valid')
except Exception as e:
    print('❌ security.yml invalid:', e)
"

echo "🧪 Running quick test..."
python3 -m pytest tests/test_basic.py -v --tb=short -q

echo "✅ All checks completed!"
