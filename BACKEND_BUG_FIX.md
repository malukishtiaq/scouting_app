# 🐛 Backend Bug: `/api/me` Endpoint Failure

## 📋 Problem Summary

The `/api/me` endpoint (GET request) is returning a **500 Internal Server Error** with the message:

```
"message": "Call to a member function toArray() on null"
```

### Error Details

- **File**: `/home/webuser/projects/scouting/app/Core/Helper.php`
- **Line**: 10
- **Function**: `isUserProfileCompleted`
- **Called From**: `/home/webuser/projects/scouting/app/Http/Resources/UserResource.php` (line 31)

## 🔍 Root Cause

The `Helper::isUserProfileCompleted()` function is trying to call `toArray()` on a null object. This happens when a newly registered user doesn't have a complete player profile relationship.

### Example Scenario

1. User registers: `gbailey2@example.net2`
2. Login succeeds ✅
3. User has minimal data (name, email, avatar, etc.)
4. User's player profile relationship is **NULL** ❌
5. When `/api/me` is called, `UserResource` tries to serialize the user
6. `UserResource` calls `Helper::isUserProfileCompleted()`
7. `Helper::isUserProfileCompleted()` tries to access `$user->playerProfile->toArray()`
8. **CRASH** because `$user->playerProfile` is null

## 🛠️ Backend Fix Required

### File 1: `app/Core/Helper.php`

**Current Code (Line ~10):**
```php
public static function isUserProfileCompleted($user) {
    $playerProfile = $user->playerProfile;
    return $playerProfile->toArray(); // ❌ CRASHES if $playerProfile is null
}
```

**Fixed Code:**
```php
public static function isUserProfileCompleted($user) {
    $playerProfile = $user->playerProfile;
    
    // ✅ Check if playerProfile exists before calling toArray()
    if ($playerProfile === null) {
        return false; // Or return an empty array: []
    }
    
    return $playerProfile->toArray();
}
```

### File 2: `app/Http/Resources/UserResource.php` (Line ~31)

**Current Code:**
```php
public function toArray($request) {
    return [
        'user_id' => $this->id,
        'name' => $this->name,
        'email' => $this->email,
        // ... other fields
        'profile_complete' => Helper::isUserProfileCompleted($this), // ❌ May crash
    ];
}
```

**Fixed Code:**
```php
public function toArray($request) {
    return [
        'user_id' => $this->id,
        'name' => $this->name,
        'email' => $this->email,
        // ... other fields
        'profile_complete' => $this->playerProfile !== null 
            ? Helper::isUserProfileCompleted($this) 
            : false, // ✅ Safe fallback
    ];
}
```

## ✅ Alternative Solution

If `isUserProfileCompleted()` is meant to check multiple fields, you might want to refactor it:

```php
// app/Core/Helper.php
public static function isUserProfileCompleted($user) {
    // Check if player profile exists
    if ($user->playerProfile === null) {
        return false;
    }
    
    $profile = $user->playerProfile;
    
    // Check if all required fields are filled
    return !empty($profile->age) 
        && !empty($profile->weight) 
        && !empty($profile->height) 
        && !empty($profile->primary_position) 
        && !empty($profile->preferred_foot);
}
```

## 🧪 Testing the Fix

### Test Case 1: New User (Incomplete Profile)
```bash
curl -X GET "https://scouting.terveys.io/api/me" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

**Expected Response:**
```json
{
  "success": true,
  "data": {
    "user_id": "123",
    "name": null,
    "email": "gbailey2@example.net2",
    "email_verified": false,
    "registration_date": "2025-11-06T18:21:02.000000Z",
    "avatar": "https://scouting.terveys.io/images/default-avatar.png",
    "age": null,
    "weight": null,
    "height": null,
    "primary_position": null,
    "preferred_foot": null,
    "profile_complete": false  // ✅ Should be false, not crash
  }
}
```

### Test Case 2: Existing User (Complete Profile)
Should return `profile_complete: true` if all fields are filled.

## 📱 Client-Side Workaround (Already Implemented)

While you fix the backend, the Flutter app has been updated to **skip the `/api/me` call** and use the user data from the login response instead. This allows users to log in successfully.

### What Was Changed:
- File: `lib/core/services/auth_service.dart`
- Function: `_fetchAndStoreUserProfile()`
- Change: Disabled the `/api/me` call temporarily

### When Backend is Fixed:
1. Test the `/api/me` endpoint with new users
2. Uncomment the code in `lib/core/services/auth_service.dart`
3. Remove the workaround comment

## 🚨 Impact

### Before Fix:
- ❌ New users cannot log in (500 error after login success)
- ❌ Users with incomplete profiles crash the app
- ❌ Background services fail to initialize

### After Fix:
- ✅ New users can log in successfully
- ✅ Users with incomplete profiles see `profile_complete: false`
- ✅ App prompts users to complete their profile
- ✅ Background services initialize properly

## 📊 Priority: CRITICAL

This bug prevents **ALL NEW USERS** from using the app after registration. It must be fixed immediately.

## 🔗 Related Files

### Backend Files to Fix:
1. `app/Core/Helper.php` (line 10)
2. `app/Http/Resources/UserResource.php` (line 31)

### Frontend Files (Workaround Applied):
1. `lib/core/services/auth_service.dart` (line 198)

## 📝 Commit Message Suggestion

```
fix: Handle null playerProfile in Helper::isUserProfileCompleted()

- Add null check before calling toArray() on playerProfile
- Return false for users without a complete player profile
- Prevents 500 error on /api/me endpoint for new users
- Fixes issue where newly registered users couldn't log in

Closes #XXX
```

## 💡 Prevention

To prevent similar issues in the future:

1. **Add Null Checks**: Always check for null before accessing relationships
2. **Use Optional Chaining**: Use `$user->playerProfile?->toArray()` (PHP 8.0+)
3. **Database Seeding**: Ensure all test users have complete profiles
4. **Integration Tests**: Add tests for endpoints with new/incomplete user data
5. **Error Handling**: Add try-catch blocks around serialization code

---

**Last Updated**: November 6, 2025  
**Status**: 🔴 Awaiting Backend Fix  
**Workaround**: ✅ Client-side workaround applied  
**Estimated Fix Time**: 5 minutes

