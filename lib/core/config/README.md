# API Configuration Setup

This directory contains configuration files for API keys and sensitive data.

## 🔐 Security Notice

**NEVER commit actual API keys to version control!**

## 📁 Files

- `api_keys.dart` - **DO NOT COMMIT** - Contains actual API keys
- `api_keys.template.dart` - **SAFE TO COMMIT** - Template showing structure
- `README.md` - This file with setup instructions

## 🚀 Setup Instructions

### 1. Copy the Template

```bash
cp lib/core/config/api_keys.template.dart lib/core/config/api_keys.dart
```

### 2. Update with Your API Keys

Edit `lib/core/config/api_keys.dart` and replace the placeholder values:

```dart
class ApiKeys {
  // Replace with your actual WoWonder server key
  static const String woWonderServerKey = 'your_actual_server_key_here';
  
  // Replace with your actual API base URL
  static const String woWonderBaseUrl = 'https://your-domain.com/api/';
  
  // ... other configurations
}
```

### 3. Verify .gitignore

Ensure `api_keys.dart` is in your `.gitignore` file:

```gitignore
# API Keys and Sensitive Configuration
lib/core/config/api_keys.dart
```

### 4. Test Configuration

The `ApiKeys` class includes validation:

```dart
// This will throw an exception if keys are not configured
ApiKeys.validateConfiguration();
```

## 🔧 Configuration Options

### API Endpoints
- `getGeneralDataEndpoint` - General notifications data
- `getActivitiesEndpoint` - User activities
- `getFriendsBirthdayEndpoint` - Friends' birthdays

### API Settings
- `apiTimeoutSeconds` - Request timeout (default: 30s)
- `maxRetryAttempts` - Retry attempts (default: 3)
- `retryDelay` - Delay between retries (default: 2s)

### Pagination
- `defaultPageSize` - Default items per page (default: 25)
- `maxPageSize` - Maximum items per page (default: 100)

### Cache Settings
- `cacheTimeout` - How long to cache data (default: 15 minutes)
- `staleDataThreshold` - When to consider data stale (default: 1 hour)

## 🛡️ Security Best Practices

1. **Never commit `api_keys.dart`** to version control
2. **Use environment variables** for production deployments
3. **Rotate API keys** regularly
4. **Use different keys** for development and production
5. **Monitor API usage** for suspicious activity

## 🚨 Troubleshooting

### "API keys not configured" Error

This means `api_keys.dart` either doesn't exist or contains placeholder values.

**Solution:**
1. Copy the template file
2. Update with your actual API keys
3. Ensure the file is not in `.gitignore` (it should be ignored)

### Build Errors

If you get build errors related to missing `api_keys.dart`:

1. Make sure the file exists
2. Check that it's properly formatted
3. Verify all required constants are defined

## 📝 Example Usage

```dart
import 'package:scouting_app/core/config/api_keys.dart';

// Validate configuration on app startup
void main() {
  ApiKeys.validateConfiguration();
  runApp(MyApp());
}

// Use in your API calls
final serverKey = ApiKeys.woWonderServerKey;
final baseUrl = ApiKeys.woWonderBaseUrl;
```

## 🔄 Updating Configuration

When you need to update API keys:

1. Edit `api_keys.dart` with new values
2. Test the configuration
3. Deploy to your environment
4. **Never commit the changes to git**

---

**Remember: Keep your API keys secure and never share them publicly!** 🔒
