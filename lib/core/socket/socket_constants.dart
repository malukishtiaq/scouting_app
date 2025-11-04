/// Socket system constants and configuration values
///
/// These values should be configured based on your WoWonder server settings.
/// Update the values below to match your server configuration.
class SocketConstants {
  // Server URL - Get from your WoWonder server configuration
  // Example: "https://your-domain.com" or "http://localhost:3000"
  static const String serverUrl = "https://your-domain.com";

  // Socket port - HTTPS socket port for SSL connections
  // This is the port where your Socket.IO server is running with SSL
  static const String socketPort = "449";

  // Socket path - Standard Socket.IO path
  static const String socketPath = "/socket.io";

  // Connection timeout - Adjust based on network conditions
  // Increase for slower networks, decrease for faster networks
  static const Duration connectionTimeout = Duration(seconds: 20);

  // Reconnection settings - Adjust for your needs
  static const Duration reconnectionDelay = Duration(seconds: 1);
  static const Duration maxReconnectionDelay = Duration(seconds: 5);
  static const int maxReconnectionAttempts = 10;

  // Transport protocol - Use polling for better compatibility
  // Change to SocketTransport.websocket for better performance if supported
  static const SocketTransport transport = SocketTransport.polling;

  // Heartbeat settings
  static const Duration pingInterval = Duration(seconds: 25);
  static const Duration pongTimeout = Duration(seconds: 5);

  // Message queue settings
  static const int maxQueuedMessages = 100;
  static const Duration messageRetryDelay = Duration(seconds: 2);
  static const int maxMessageRetries = 3;
}

/// Socket transport protocol options
enum SocketTransport {
  /// HTTP long polling - More compatible, works through firewalls
  polling,

  /// WebSocket - Better performance, real-time communication
  websocket,
}

/// Socket connection type options
enum SocketConnectionType {
  /// Use Socket.IO for real-time communication
  socket,

  /// Use REST API for communication
  restApi,
}

/// Socket connection states
enum SocketConnectionState {
  /// Socket is disconnected
  disconnected,

  /// Socket is connecting
  connecting,

  /// Socket is connected and ready
  connected,

  /// Socket is reconnecting after disconnection
  reconnecting,

  /// Socket connection failed
  failed,
}

/// Socket event names used in communication
class SocketEventNames {
  // Connection events
  static const String connect = "connect";
  static const String disconnect = "disconnect";
  static const String error = "error";
  static const String reconnect = "reconnect";
  static const String reconnectAttempt = "reconnect_attempt";
  static const String reconnectFailed = "reconnect_failed";
  static const String reconnectError = "reconnect_error";
  static const String ping = "ping";
  static const String pong = "pong";

  // Authentication events
  static const String join = "join";
  static const String joined = "joined";

  // Chat events - Private messages
  static const String privateMessage = "private_message";
  static const String sendMessage = "private_message";
  static const String messageReceived = "message_received";

  // Chat events - Group messages
  static const String groupMessage = "group_message";
  static const String sendGroupMessage = "group_message";
  static const String groupMessageReceived = "group_message_received";

  // Chat events - Page messages
  static const String pageMessage = "page_message";
  static const String sendPageMessage = "send_page_message";
  static const String pageMessageReceived = "page_message_received";

  // File message events
  static const String sendMessageFile = "send_message_file";
  static const String sendGroupMessageFile = "send_group_message_file";
  static const String sendPageMessageFile = "send_page_message_file";

  // Typing events
  static const String typing = "typing";
  static const String stopTyping = "stop_typing";
  static const String typingEvent = "typing_event";
  static const String stopTypingEvent = "stop_typing_event";

  // Recording events
  static const String recording = "recording";
  static const String stopRecording = "stop_recording";
  static const String recordingEvent = "recording_event";
  static const String stopRecordingEvent = "stop_recording_event";

  // Message status events
  static const String messageSeen = "message_seen";
  static const String sendSeenMessages = "send_seen_messages";
  static const String seenMessages = "seen_messages";

  // Message reaction events
  static const String messageReaction = "message_reaction";
  static const String sendMessageReaction = "send_message_reaction";
  static const String messageReactionReceived = "message_reaction_received";

  // User status events
  static const String userStatus = "user_status";
  static const String userStatusChange = "user_status_change";
  static const String userOnline = "user_online";
  static const String userOffline = "user_offline";

  // Video call events
  static const String videoCall = "video_call";
  static const String newVideoCall = "new_video_call";
  static const String createCall = "create_call";
  static const String callEvent = "call_event";

  // Login/Logout events
  static const String userLogin = "user_login";
  static const String userLogout = "user_logout";
  static const String loggedIn = "logged_in";
  static const String loggedOut = "logged_out";

  // Notification events
  static const String messageNotification = "message_notification";
  static const String notification = "notification";
  static const String commentNotification = "comment_notification";

  // Last seen events
  static const String lastSeen = "last_seen";
  static const String pingLastSeen = "ping_last_seen";
}

/// Socket message types
enum SocketMessageType {
  /// Text message
  text,

  /// Image message
  image,

  /// Video message
  video,

  /// Audio message
  audio,

  /// File message
  file,

  /// Location message
  location,

  /// Sticker message
  sticker,

  /// GIF message
  gif,

  /// Contact message
  contact,

  /// Voice message
  voice,
}

/// Socket error types
enum SocketErrorType {
  /// Connection timeout
  connectionTimeout,

  /// Connection refused
  connectionRefused,

  /// Authentication failed
  authenticationFailed,

  /// Network error
  networkError,

  /// Server error
  serverError,

  /// Unknown error
  unknown,
}

/// Socket configuration class
class SocketConfig {
  final String serverUrl;
  final String port;
  final String path;
  final Duration connectionTimeout;
  final Duration reconnectionDelay;
  final Duration maxReconnectionDelay;
  final int maxReconnectionAttempts;
  final SocketTransport transport;
  final Duration pingInterval;
  final Duration pongTimeout;
  final int maxQueuedMessages;
  final Duration messageRetryDelay;
  final int maxMessageRetries;
  final Map<String, String> extraHeaders;

  const SocketConfig({
    required this.serverUrl,
    required this.port,
    required this.path,
    required this.connectionTimeout,
    required this.reconnectionDelay,
    required this.maxReconnectionDelay,
    required this.maxReconnectionAttempts,
    required this.transport,
    required this.pingInterval,
    required this.pongTimeout,
    required this.maxQueuedMessages,
    required this.messageRetryDelay,
    required this.maxMessageRetries,
    this.extraHeaders = const {},
  });

  /// Create default configuration using constants
  factory SocketConfig.defaultConfig() {
    return SocketConfig(
      serverUrl: SocketConstants.serverUrl,
      port: SocketConstants.socketPort,
      path: SocketConstants.socketPath,
      connectionTimeout: SocketConstants.connectionTimeout,
      reconnectionDelay: SocketConstants.reconnectionDelay,
      maxReconnectionDelay: SocketConstants.maxReconnectionDelay,
      maxReconnectionAttempts: SocketConstants.maxReconnectionAttempts,
      transport: SocketConstants.transport,
      pingInterval: SocketConstants.pingInterval,
      pongTimeout: SocketConstants.pongTimeout,
      maxQueuedMessages: SocketConstants.maxQueuedMessages,
      messageRetryDelay: SocketConstants.messageRetryDelay,
      maxMessageRetries: SocketConstants.maxMessageRetries,
      extraHeaders: {
        'user-agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18363',
      },
    );
  }

  /// Get full socket URL
  String get fullUrl {
    final cleanUrl = serverUrl.endsWith('/')
        ? serverUrl.substring(0, serverUrl.length - 1)
        : serverUrl;
    return '$cleanUrl:$port$path';
  }

  /// Get transport string for Socket.IO
  String get transportString {
    switch (transport) {
      case SocketTransport.polling:
        return 'polling';
      case SocketTransport.websocket:
        return 'websocket';
    }
  }
}
