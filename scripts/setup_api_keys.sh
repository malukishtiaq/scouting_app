#!/bin/bash

# API Keys Setup Script
# This script helps set up API keys for the notifications feature

echo "🔐 Setting up API keys for Notifications Feature"
echo "================================================"

# Check if api_keys.dart already exists
if [ -f "lib/core/config/api_keys.dart" ]; then
    echo "⚠️  api_keys.dart already exists!"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Setup cancelled."
        exit 1
    fi
fi

# Copy template to actual file
echo "📋 Copying template file..."
cp lib/core/config/api_keys.template.dart lib/core/config/api_keys.dart

if [ $? -eq 0 ]; then
    echo "✅ Template copied successfully!"
else
    echo "❌ Failed to copy template file."
    exit 1
fi

# Check if .gitignore contains api_keys.dart
if grep -q "api_keys.dart" .gitignore; then
    echo "✅ api_keys.dart is already in .gitignore"
else
    echo "⚠️  Adding api_keys.dart to .gitignore..."
    echo "" >> .gitignore
    echo "# API Keys and Sensitive Configuration" >> .gitignore
    echo "lib/core/config/api_keys.dart" >> .gitignore
    echo "✅ Added to .gitignore"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. Edit lib/core/config/api_keys.dart"
echo "2. Replace 'YOUR_WOWONDER_SERVER_KEY_HERE' with your actual server key"
echo "3. Replace 'https://your-domain.com/api/' with your actual API URL"
echo "4. Save the file"
echo ""
echo "🔒 Remember: Never commit api_keys.dart to version control!"
echo ""
echo "📖 For more details, see lib/core/config/README.md"
