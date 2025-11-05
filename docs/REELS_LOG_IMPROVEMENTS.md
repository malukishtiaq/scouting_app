# Reels Video Logging Improvements

## Overview
Reduced excessive verbose logs and added meaningful error logs to help debug video playback issues.

## Changes Made

### 1. **Reduced Verbose Logs**

**Before:** Logs on every operation
```dart
print('🎬 Playing regular video: ${_videoUrl}');
print('⚡ Using cached video controller: ${_videoUrl}');
print('🎬 Preloading 50 reels videos');
print('✅ VideoCacheManager: Finished preloading 50 reels videos');
print('🎯 VideoCacheManager: Intelligent preloading from index 5');
print('🎬 VideoCacheManager: Preloading 5 upcoming videos');
```

**After:** Only log meaningful events
```dart
// Removed verbose success logs
// Only log errors and important state changes
```

### 2. **Added Meaningful Error Logs**

**Timeout Errors:**
```dart
❌ TIMEOUT ERROR: Video took >5s to initialize | Post ID: 12345
```

**Initialization Failures:**
```dart
❌ INIT FAILED: Network error | Post ID: 12345 | URL: https://example.com/video.mp4...
```

**Critical Errors:**
```dart
❌ CRITICAL ERROR: Video initialization exception | Post ID: 12345 | Error: Exception message
```

**No Video Source:**
```dart
❌ NO VIDEO SOURCE: Post has no video URL | Post ID: 12345 | Has YouTube: false | Has File: false
```

**Video Playback Errors:**
```dart
❌ VIDEO ERROR: NetworkError: Request failed | Post ID: 12345 | Playing: false | Buffering: true
```

**Cannot Play:**
```dart
❌ CANNOT PLAY: Video not initialized | URL: https://example.com/video.mp4...
```

**YouTube Errors:**
```dart
❌ YOUTUBE ERROR: Failed to initialize YouTube player | Video ID: abc123 | Error: Exception
```

**Preload Errors:**
```dart
❌ PRELOAD ERROR: Failed to preload videos | Error: Exception
```

**Manual Refresh:**
```dart
🔄 MANUAL REFRESH: User double-tapped video
```

**Successful Init:**
```dart
✅ VIDEO READY: Post 12345 initialized successfully
```

**Filtered Posts:**
```dart
⚠️ FILTERED REELS: 5 removed (45 valid) | Reasons: NoID=1, NoVideo=2, Deleted=1, Processing=1, NoAccess=0
```

### 3. **Improved Error UI Messages**

**Error Titles:**
- "Video Playback Error" - When controller has error
- "No Video Source" - When URL is null
- "YouTube Error" - For YouTube videos
- "Video Failed to Load" - Generic failure

**Error Messages:**
- Shows actual error description from controller
- Guides user to check console logs
- Explains what went wrong

### 4. **Log Categories**

| Category | Symbol | Purpose |
|----------|--------|---------|
| Success | ✅ | Video ready to play |
| Error | ❌ | Something went wrong |
| Warning | ⚠️ | Non-critical issue |
| Manual Action | 🔄 | User triggered refresh |

## Benefits

1. **Less Noise:** Console no longer flooded with "Playing video" messages
2. **Better Debugging:** Errors include:
   - Post ID
   - URL snippet
   - Exact error message
   - Current state (playing, buffering, etc.)
3. **Actionable:** Each error log tells you WHAT went wrong and WHERE
4. **Performance:** Fewer print statements = better performance
5. **User-Friendly:** Error UI shows helpful messages instead of generic text

## Debugging Workflow

### When Video Won't Load:

1. **Check console logs** for:
   - `❌ NO VIDEO SOURCE` → Post data issue
   - `❌ TIMEOUT ERROR` → Network too slow
   - `❌ INIT FAILED` → Network or codec issue
   - `❌ VIDEO ERROR` → Playback error with description

2. **Search by Post ID:**
   ```
   Search: "Post ID: 12345"
   ```

3. **Check filtered posts:**
   ```
   Search: "FILTERED REELS"
   ```

### When Videos Load Slowly:

1. Check for:
   - Multiple `❌ INIT FAILED` messages
   - `❌ TIMEOUT ERROR` repeatedly
   - `❌ PRELOAD ERROR` issues

### When Video Shows Black Screen:

1. Look for:
   - `❌ VIDEO ERROR` with error description
   - `❌ CANNOT PLAY: Video not initialized`
   - `✅ VIDEO READY` but no playback

## Files Modified

- `flutter_target/lib/feature/reels/presentation/widget/reel_player_widget.dart`
- `flutter_target/lib/feature/reels/presentation/cubit/reels_cubit.dart`
- `flutter_target/lib/core/video/video_cache_manager.dart`

## Android System Logs (Important!)

### The 10k+ Log Problem

If you're seeing **10,000+ lines of logs** like:
```
D/CCodec  (24924): setup formats input: AMessage...
W/BufferQueueProducer(24924): [MediaCodec.release]...
D/CCodecConfig(24924): c2 config diff is...
I/MediaCodec(24924): setCodecState state(1)...
```

**These are NOT from our app!** They're Android system logs from the MediaCodec video framework. Every video initialization generates 100-200 lines of these codec configuration logs.

### Solution: Filter System Logs

#### Option 1: Android Studio Logcat (Recommended)
1. Open **Logcat** tab
2. Click filter dropdown
3. Add: `package:com.yourapp` (shows only your app)
4. Or add: `-tag:CCodec -tag:BufferQueueProducer -tag:MediaCodec`

#### Option 2: Use Filter Script (Linux/Mac)
```bash
./scripts/filter_logs.sh
```

#### Option 3: Use Filter Script (Windows)
```cmd
scripts\filter_logs.bat
```

#### Option 4: Manual ADB Command
```bash
# Linux/Mac
adb logcat | grep -v -E "(CCodec|BufferQueueProducer|MediaCodec)"

# Windows PowerShell
adb logcat | Select-String -Pattern "CCodec|BufferQueueProducer|MediaCodec" -NotMatch
```

### After Filtering

You should only see our app's meaningful logs:
```
✅ VIDEO READY: Post 12345 initialized successfully
❌ TIMEOUT ERROR: Video took >5s to initialize | Post ID: 67890
⚠️ FILTERED REELS: 5 removed (45 valid) | Reasons: NoVideo=2, Deleted=3
```

## Testing

1. **Apply log filter** (see above)
2. Open reels screen
3. Console should show:
   - `✅ VIDEO READY` for successful videos
   - `❌` errors only when something actually fails
   - `⚠️ FILTERED REELS` if any posts are filtered
4. Verify no more verbose logs like "Playing video" or "Preloading X videos"
5. Trigger errors (bad network, invalid URL) and verify meaningful logs appear

