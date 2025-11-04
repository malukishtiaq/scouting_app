# 🎬 Video Debugging Guide

## 📋 Overview

This guide helps you debug video playback issues in the newsfeed. The video system has been enhanced with comprehensive logging to help identify and fix problems.

## 🔍 Debugging Steps

### 1. **Check Video Initialization Logs**

Look for these log patterns in your console:

```
🔍 VideoPostWidget: Initializing video for post [POST_ID]
📊 VideoPostWidget: Post data analysis:
   - postFile: [URL or null]
   - postYoutube: [ID or null]
   - postVimeo: [ID or null]
   - postFacebook: [URL or null]
   - postInstagram: [URL or null]
```

**What to look for:**
- ✅ **Success**: All video fields are logged with actual values
- ❌ **Problem**: All fields are null or empty
- ⚠️ **Warning**: Invalid URLs detected

### 2. **Check Video Source Detection**

Look for these logs:

```
🔍 VideoSourceDetector: Detecting source for URL: [URL]
📺 VideoSourceDetector: Detected YouTube video
🏭 VideoPlayerFactory: Creating player for video item
✅ VideoPlayerFactory: Creating WebView YouTube player for video ID: [ID]
```

**What to look for:**
- ✅ **Success**: Correct source detected and appropriate player created
- ❌ **Problem**: Wrong source detected or fallback to WebView player

### 3. **Check Player Initialization**

Look for these logs:

```
🎬 VideoFeedItem: Initializing video for [VIDEO_ID]
🎬 VideoFeedItem: Video details:
   - URL: [URL]
   - Source: [SOURCE_TYPE]
   - Player type: [PLAYER_CLASS]
✅ VideoFeedItem: Player initialized successfully
```

**What to look for:**
- ✅ **Success**: Player initialized without errors
- ❌ **Problem**: Initialization errors or timeouts

### 4. **Check YouTube WebView Player**

For YouTube videos, look for:

```
🎬 YouTubeWebViewPlayer: Initializing with video ID: [ID]
🎬 YouTubeWebViewPlayer: Video ID validation: true
🌐 YouTubeWebViewPlayer: Page loading started: [URL]
✅ YouTubeWebViewPlayer: Page loading finished: [URL]
🔧 YouTubeWebViewPlayer: Injecting custom JavaScript...
```

**What to look for:**
- ✅ **Success**: Page loads and JavaScript injection works
- ❌ **Problem**: Web resource errors or JavaScript failures

### 5. **Check Direct Video Player**

For direct video files, look for:

```
🎬 DirectVideoPlayer: Initializing with URL: [URL]
🎬 DirectVideoPlayer: URL validation: true
✅ DirectVideoPlayer: Controller initialized successfully
⏱️ DirectVideoPlayer: Duration: [SECONDS]s
```

**What to look for:**
- ✅ **Success**: Controller initializes and duration is detected
- ❌ **Problem**: Network errors or unsupported formats

### 6. **Check WebView Video Player**

For external video sources, look for:

```
🎬 WebViewVideoPlayer: Initializing with URL: [URL]
🌐 WebViewVideoPlayer: Page loading started: [URL]
✅ WebViewVideoPlayer: Page loading finished: [URL]
🔧 WebViewVideoPlayer: Injecting video detection JavaScript...
```

**What to look for:**
- ✅ **Success**: Page loads and video element is found
- ❌ **Problem**: Page fails to load or no video element found

## 🚨 Common Issues and Solutions

### Issue 1: "No video source found in post data"

**Symptoms:**
```
⚠️ VideoPostWidget: No video source found in post data
⚠️ VideoPostWidget: Available video fields:
   - postFile: null
   - postYoutube: null
   - postVimeo: null
```

**Solutions:**
1. Check if the post actually contains video data
2. Verify the API response includes video fields
3. Check if video fields are being parsed correctly from JSON

### Issue 2: "Invalid video URL detected"

**Symptoms:**
```
❌ VideoPostWidget: Invalid video URL detected: [URL]
```

**Solutions:**
1. Check if the URL is properly formatted
2. Verify the URL is accessible
3. Check if the video platform is supported

### Issue 3: "YouTube video ID validation: false"

**Symptoms:**
```
🎬 YouTubeWebViewPlayer: Video ID validation: false
```

**Solutions:**
1. Check if the YouTube ID is 11 characters long
2. Verify the ID contains only valid characters (a-z, A-Z, 0-9, _, -)
3. Check if the ID is extracted correctly from the URL

### Issue 4: "Web resource error"

**Symptoms:**
```
❌ YouTubeWebViewPlayer: Web resource error: [ERROR]
❌ YouTubeWebViewPlayer: Error code: [CODE]
```

**Solutions:**
1. Check internet connection
2. Verify the YouTube video is not private or restricted
3. Check if the video ID is correct
4. Try a different video to test

### Issue 5: "Player not ready after reinitialization"

**Symptoms:**
```
⚠️ VideoErrorRecovery: Player not ready after reinitialization
```

**Solutions:**
1. Check network connectivity
2. Verify the video URL is still valid
3. Check if the video format is supported
4. Try refreshing the page

### Issue 6: "User gesture required"

**Symptoms:**
```
⚠️ YouTubeWebViewPlayer: Playback failed - waiting for user gesture
⚠️ YouTubeWebViewPlayer: User needs to tap the video to start playback
```

**Solutions:**
1. This is normal behavior - user must tap the video to start
2. Check if the video controls are visible
3. Verify the video area is tappable

## 🔧 Debugging Commands

### Enable Verbose Logging

Add this to your main.dart to enable more detailed logging:

```dart
import 'dart:developer' as developer;

void main() {
  developer.log('Video debugging enabled', name: 'VideoDebug');
  runApp(MyApp());
}
```

### Check Video Player State

Add this to your video widget to check player state:

```dart
void _checkPlayerState() {
  print('🎮 Player State Check:');
  print('   - Is Ready: ${_player.isReady}');
  print('   - Is Playing: ${_player.isPlaying}');
  print('   - Is Muted: ${_player.isMuted}');
  print('   - Position: ${_player.position.inSeconds}s');
  print('   - Duration: ${_player.duration.inSeconds}s');
}
```

### Test Video URLs

Use this function to test if a video URL is valid:

```dart
Future<bool> testVideoUrl(String url) async {
  try {
    final response = await http.head(Uri.parse(url));
    print('🔗 URL Test: ${url} - Status: ${response.statusCode}');
    return response.statusCode == 200;
  } catch (e) {
    print('❌ URL Test Failed: ${url} - Error: $e');
    return false;
  }
}
```

## 📊 Performance Monitoring

### Memory Usage

Monitor memory usage during video playback:

```dart
void _monitorMemory() {
  print('💾 Memory Usage:');
  print('   - Video players active: ${_activePlayers.length}');
  print('   - Memory pressure: ${PlatformDispatcher.instance.memoryPressure}');
}
```

### Network Monitoring

Monitor network requests:

```dart
void _monitorNetwork() {
  print('🌐 Network Status:');
  print('   - Connection type: ${_connectionType}');
  print('   - Data usage: ${_dataUsage}');
}
```

## 🎯 Testing Checklist

- [ ] **Video Initialization**: All video fields are detected correctly
- [ ] **Source Detection**: Correct video source is identified
- [ ] **Player Creation**: Appropriate player is created for each source
- [ ] **Player Initialization**: Player initializes without errors
- [ ] **Video Loading**: Video loads and displays thumbnail
- [ ] **Playback**: Video plays when user taps play button
- [ ] **Controls**: Play/pause, mute, fullscreen controls work
- [ ] **Visibility**: Video pauses when scrolled out of view
- [ ] **Error Handling**: Errors are caught and logged properly
- [ ] **Recovery**: Failed videos attempt recovery automatically

## 🚀 Quick Fixes

### For YouTube Videos Not Playing:
1. Check if video ID is valid (11 characters)
2. Verify video is not private/restricted
3. Ensure user taps the video to start playback
4. Check internet connection

### For Direct Video Files Not Loading:
1. Verify URL is accessible
2. Check if video format is supported (.mp4, .webm, etc.)
3. Ensure proper network permissions
4. Check if video file exists

### For External Video Sources:
1. Verify the URL loads in a browser
2. Check if the site allows embedding
3. Ensure JavaScript is enabled
4. Check for CORS issues

## 📱 Platform-Specific Issues

### Android:
- Check if hardware acceleration is enabled
- Verify video codec support
- Check for ExoPlayer issues

### iOS:
- Check if AVPlayer is working
- Verify video format compatibility
- Check for WebKit issues

## 🔄 Recovery System

The video system includes automatic error recovery:

1. **Network Errors**: Automatic retry with exponential backoff
2. **Initialization Errors**: Player reinitialization
3. **Playback Errors**: Automatic retry up to 3 times
4. **User Gesture Required**: Clear indication to user

## 📞 Support

If you're still experiencing issues after following this guide:

1. **Collect Logs**: Copy all video-related logs from console
2. **Test Different Videos**: Try various video sources and formats
3. **Check Network**: Verify internet connection and speed
4. **Platform Testing**: Test on both Android and iOS
5. **Video URLs**: Test the problematic video URLs in a browser

## 🎉 Success Indicators

You'll know the video system is working correctly when you see:

- ✅ All video fields detected and logged
- ✅ Correct video source identified
- ✅ Appropriate player created
- ✅ Player initializes successfully
- ✅ Video loads and shows thumbnail
- ✅ Playback works with user interaction
- ✅ Controls respond properly
- ✅ Error recovery works automatically

Remember: The most common issue is that **YouTube videos require user interaction** to start playback due to browser security policies. This is normal behavior, not a bug!
