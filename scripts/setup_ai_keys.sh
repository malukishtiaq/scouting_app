#!/bin/bash

# AI Keys Setup Script
# This script helps set up AI API keys for the AI content feature

echo "🤖 Setting up AI keys for AI Content Feature"
echo "============================================="

# Check if ai_keys.dart already exists
if [ -f "lib/feature_ai_content/core/config/ai_keys.dart" ]; then
    echo "⚠️  ai_keys.dart already exists!"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Setup cancelled."
        exit 1
    fi
fi

# Copy template to actual file
echo "📋 Copying template file..."
cp lib/feature_ai_content/core/config/ai_keys.template.dart lib/feature_ai_content/core/config/ai_keys.dart

if [ $? -eq 0 ]; then
    echo "✅ Template copied successfully!"
else
    echo "❌ Failed to copy template file."
    exit 1
fi

# Check if .gitignore contains ai_keys.dart
if grep -q "ai_keys.dart" .gitignore; then
    echo "✅ ai_keys.dart is already in .gitignore"
else
    echo "⚠️  Adding ai_keys.dart to .gitignore..."
    echo "" >> .gitignore
    echo "# AI Keys and Sensitive Configuration" >> .gitignore
    echo "lib/feature_ai_content/core/config/ai_keys.dart" >> .gitignore
    echo "✅ Added to .gitignore"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. Edit lib/feature_ai_content/core/config/ai_keys.dart"
echo "2. Replace placeholder values with your actual API keys:"
echo "   - Hugging Face: https://huggingface.co/settings/tokens"
echo "   - Cohere: https://dashboard.cohere.ai/api-keys"
echo "   - Google AI: https://makersuite.google.com/app/apikey"
echo "   - Anthropic: https://console.anthropic.com/keys"
echo "   - Replicate: https://replicate.com/account/api-tokens"
echo "   - Stability AI: https://platform.stability.ai/account/keys"
echo "3. Save the file"
echo ""
echo "🔒 Remember: Never commit ai_keys.dart to version control!"
echo ""
echo "💡 Tip: You only need to configure one service to get started!"
echo "   Recommended: Start with Cohere (free tier, good quality)"
