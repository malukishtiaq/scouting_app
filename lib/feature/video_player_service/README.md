# Video Player Service

A comprehensive video player service for Flutter applications that supports multiple video sources including YouTube, Vimeo, direct video files, and social media platforms.

## Features

- **Multi-source support**: YouTube, Vimeo, direct video files, Facebook, Instagram
- **Auto-pause on scroll**: Videos automatically pause when scrolled out of view
- **Lifecycle management**: Proper handling of app lifecycle changes
- **Custom controls**: Minimal, user-friendly video controls
- **Fullscreen support**: Built-in fullscreen functionality
- **Position memory**: Remembers video position across app sessions

## Architecture

The service follows a clean architecture pattern with clear separation of concerns:

- **Models**: `VideoItem` represents video metadata
- **Services**: Interfaces and implementations for video player management
- **Players**: Platform-specific video player implementations
- **UI**: Custom video controls and feed item widgets
- **Factories**: Creates appropriate players based on video source

## Usage

### Basic Setup

```dart
// Register the service
VideoPlayerServiceProvider.register();

// Get the service instance
final videoService = VideoPlayerServiceProvider.service;
```

### Creating Video Items

```dart
final videoItem = VideoItem(
  id: 'unique_id',
  url: 'https://youtube.com/watch?v=VIDEO_ID',
  source: VideoSource.youtube,
  thumbnailUrl: 'https://example.com/thumbnail.jpg',
  title: 'Video Title',
);
```

### Using in UI

```dart
VideoFeedItem(
  item: videoItem,
  service: videoService,
)
```

## Video Sources

- **YouTube**: Automatically extracts video ID from URLs
- **Vimeo**: Supports Vimeo video links
- **Direct**: MP4, AVI, MOV, and other video formats
- **Social Media**: Facebook and Instagram video support
- **Web**: Fallback to WebView for unsupported sources

## Controls

The video player includes minimal, intuitive controls:

- **Play/Pause**: Large, centered button for easy access
- **Mute**: Volume control in bottom-left corner
- **Fullscreen**: Fullscreen toggle in top-right corner
- **Auto-hide**: Controls automatically hide after 3 seconds of inactivity

## Auto-pause Behavior

Videos automatically pause when:
- Scrolled out of view (less than 50% visible)
- App goes to background
- Another video starts playing

## Dependencies

- `youtube_player_flutter`: YouTube video playback
- `video_player`: Direct video file playback
- `webview_flutter`: Web-based video sources
- `visibility_detector`: Scroll-based auto-pause
- `get_it`: Dependency injection

## Future Enhancements

- [ ] Vimeo player implementation
- [ ] Direct video player with custom controls
- [ ] Social media video players
- [ ] Picture-in-picture support
- [ ] Video quality selection
- [ ] Subtitle support
- [ ] Playback speed controls
