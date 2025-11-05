# Scouting API Implementation Guide

## ✅ Authentication APIs Implemented

### 1. **Register API** (`POST /api/members/register`)

**Success Response:**
```json
{
    "success": true,
    "message": "Registration successful",
    "data": {
        "user": {
            "name": null,
            "email": "user@example.com",
            "email_verified": false,
            "registration_date": "2025-11-05T12:20:52.000000Z",
            "avatar": "https://scouting.terveys.io/images/default-avatar.png",
            "age": null,
            "weight": null,
            "height": null,
            "primary_position": null,
            "preferred_foot": null,
            "profile_complete": false
        },
        "token_type": "Bearer",
        "token": "5|aDs32MALkfIutzUTwstPLLxUv2CcUzKOc1qjUALc586f1068"
    }
}
```

**Error Response:**
```json
{
    "message": "The email has already been taken.",
    "errors": {
        "email": [
            "The email has already been taken."
        ]
    }
}
```

**Implementation:**
- ✅ Model: `AuthResponseModel` (`lib/feature/account/data/request/model/auth_response_model.dart`)
- ✅ Entity: `AuthResponseEntity` (`lib/feature/account/domain/entity/auth_response_entity.dart`)
- ✅ Remote: `memberRegister()` in `AccountRemoteSource`
- ✅ Repository: `memberRegister()` in `AccountRepository`
- ✅ Use Case: `MemberRegisterUsecase`
- ✅ Validator: `AuthResponseValidator` (handles both WoWonder and Scouting API)

### 2. **Login API** (`POST /api/members/login`)

**Success Response:**
```json
{
    "success": true,
    "message": "Login successful",
    "data": {
        "user": { ... },
        "token_type": "Bearer",
        "token": "5|aDs32MALkfIutzUTwstPLLxUv2CcUzKOc1qjUALc586f1068"
    }
}
```

**Implementation:**
- ✅ Uses same `AuthResponseModel` as Register
- ✅ Remote: `memberLogin()` in `AccountRemoteSource`
- ✅ Repository: `memberLogin()` in `AccountRepository`
- ✅ Use Case: `MemberLoginUsecase`

## 📁 File Structure

```
lib/feature/account/
├── data/
│   ├── datasource/
│   │   ├── iaccount_remote.dart (interface)
│   │   └── account_remote.dart (implementation)
│   └── request/
│       ├── model/
│       │   ├── auth_response_model.dart ✅ NEW
│       │   └── member_response_model.dart
│       └── param/
│           ├── love_loop/
│           │   ├── register_param.dart
│           │   └── login_param.dart
│           └── ...
├── domain/
│   ├── entity/
│   │   ├── auth_response_entity.dart ✅ NEW
│   │   └── member_response_entity.dart
│   ├── repository/
│   │   ├── iaccount_repository.dart
│   │   └── account_repository.dart
│   └── usecase/
│       ├── member_register_usecase.dart ✅
│       └── member_login_usecase.dart ✅
└── ...
```

## 🔧 How to Use

### Registration Example:
```dart
// 1. Create parameter
final param = RegisterParam(
  email: 'user@example.com',
  password: 'password123',
  confirmPassword: 'password123',
);

// 2. Call use case
final result = await memberRegisterUsecase(param);

// 3. Handle result
result.fold(
  (error) {
    // Handle error
    print('Error: ${error.message}');
  },
  (response) {
    // Success! Save token and user data
    final token = response.data.token;
    final user = response.data.user;
    print('Token: $token');
    print('User: ${user.email}');
  },
);
```

### Login Example:
```dart
// 1. Create parameter
final param = LoginParam(
  email: 'user@example.com',
  password: 'password123',
);

// 2. Call use case
final result = await memberLoginUsecase(param);

// 3. Handle result
result.fold(
  (error) {
    // Handle error
    print('Error: ${error.message}');
  },
  (response) {
    // Success! Save token and user data
    final token = response.data.token;
    final user = response.data.user;
    print('Token: $token');
    print('User: ${user.email}');
  },
);
```

## 🎯 Response Structure Breakdown

### AuthResponseModel
```dart
class AuthResponseModel {
  final bool success;           // API success status
  final String message;         // Success/error message
  final AuthDataModel data;     // Contains user + token
}
```

### AuthDataModel
```dart
class AuthDataModel {
  final MemberDataModel user;   // User profile data
  final String tokenType;       // "Bearer"
  final String token;           // Access token
}
```

### MemberDataModel
```dart
class MemberDataModel {
  final String name;
  final String email;
  final bool emailVerified;
  final String? registrationDate;
  final String avatar;
  final int? age;
  final double? weight;
  final double? height;
  final String? primaryPosition;
  final String? preferredFoot;
  final bool profileComplete;
}
```

## ⚙️ Error Handling

The `AuthResponseValidator` handles both API formats:

### WoWonder API Format:
```json
{
  "api_status": "400",
  "errors": {
    "error_text": "Error message"
  }
}
```

### Scouting API Format:
```json
{
  "success": false,
  "message": "Error message",
  "errors": {
    "field": ["Error detail"]
  }
}
```

## 🚀 Next Steps

1. **Update UI to use new APIs:**
   - Update Register screen to call `MemberRegisterUsecase`
   - Update Login screen to call `MemberLoginUsecase`
   - Save token using `SessionData`

2. **Test the integration:**
   ```bash
   flutter run
   ```

3. **Check logs:**
   - Look for `🔍 PostsRemoteSource` logs
   - Verify API base URL is correct
   - Check for successful authentication

## 📝 Notes

- ✅ Both WoWonder and Scouting API login/register are implemented
- ✅ Error handling covers both API formats
- ✅ Clean architecture pattern followed
- ✅ Models inherit from `BaseModel`
- ✅ Entities inherit from `BaseEntity`
- ✅ Repository uses `execute()` helper for error mapping

## 🐛 Current Issue

The app is trying to reach `https://scouting.terveys.io/api/` but getting DNS lookup failure.

**Error:**
```
SocketException: Failed host lookup: 'scouting.terveys.io'
```

**Solution:**
Update the base URL in `lib/core/constants/website_constants.dart` with the correct working URL from your API documentation.

