import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../services/smart_image_cache_service.dart';
import '../services/image_retry_service.dart';
import '../services/network_quality_service.dart';
import '../services/memory_pressure_service.dart';

/// Drop-in replacement for CachedNetworkImage with automatic optimizations
/// API-compatible with CachedNetworkImage but smarter
class SmartCachedImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final ImageWidgetBuilder? imageBuilder;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final Duration? fadeInDuration;
  final Duration? fadeOutDuration;
  final Duration? placeholderFadeInDuration;

  const SmartCachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.imageBuilder,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.fadeInDuration,
    this.fadeOutDuration,
    this.placeholderFadeInDuration,
  });

  @override
  State<SmartCachedImage> createState() => _SmartCachedImageState();
}

class _SmartCachedImageState extends State<SmartCachedImage> {
  final _cacheService = SmartImageCacheService();
  final _retryService = ImageRetryService();
  final _networkService = NetworkQualityService();
  final _memoryService = MemoryPressureService();

  int _retryAttempt = 0;
  ImageErrorType? _lastError;

  @override
  Widget build(BuildContext context) {
    // Check if URL failed recently
    if (_cacheService.hasFailedRecently(widget.imageUrl)) {
      final failureCount = _cacheService.getFailureCount(widget.imageUrl);
      if (failureCount >= 3) {
        // Permanently failed, show error immediately
        return _buildErrorWidget(ImageErrorType.notFound);
      }
    }

    // Get adaptive cache dimensions
    final dimensions = _getAdaptiveDimensions();

    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      memCacheWidth: dimensions.width,
      memCacheHeight: dimensions.height,
      maxWidthDiskCache: dimensions.width,
      maxHeightDiskCache: dimensions.height,
      placeholder: _buildSmartPlaceholder,
      errorWidget: (context, url, error) {
        _handleError(error);
        if (widget.errorWidget != null) {
          return widget.errorWidget!(context, url, error);
        }
        return _buildErrorWidget(_lastError ?? ImageErrorType.unknown);
      },
      imageBuilder: (context, imageProvider) {
        _cacheService.recordSuccess(widget.imageUrl);
        if (widget.imageBuilder != null) {
          return widget.imageBuilder!(context, imageProvider);
        }
        return Image(
          image: imageProvider,
          fit: widget.fit,
          width: widget.width,
          height: widget.height,
        );
      },
      fadeInDuration:
          widget.fadeInDuration ?? const Duration(milliseconds: 300),
      fadeOutDuration:
          widget.fadeOutDuration ?? const Duration(milliseconds: 100),
    );
  }

  /// Get adaptive dimensions based on memory and network
  CacheDimensions _getAdaptiveDimensions() {
    // Start with provided dimensions or defaults
    int baseWidth = widget.memCacheWidth ?? 800;
    int baseHeight = widget.memCacheHeight ?? 600;

    // Apply memory pressure reduction
    final memoryMultiplier = _memoryService.getCacheSizeMultiplier();
    baseWidth = (baseWidth * memoryMultiplier).toInt();
    baseHeight = (baseHeight * memoryMultiplier).toInt();

    // Apply network quality reduction
    if (_networkService.currentQuality == NetworkQuality.poor) {
      baseWidth = (baseWidth * 0.6).toInt();
      baseHeight = (baseHeight * 0.6).toInt();
    } else if (_networkService.currentQuality == NetworkQuality.good) {
      baseWidth = (baseWidth * 0.8).toInt();
      baseHeight = (baseHeight * 0.8).toInt();
    }

    return CacheDimensions(
      width: baseWidth.clamp(100, 2000),
      height: baseHeight.clamp(100, 2000),
    );
  }

  /// Build smart placeholder with network awareness
  Widget _buildSmartPlaceholder(BuildContext context, String url) {
    if (widget.placeholder != null) {
      return widget.placeholder!(context, url);
    }

    // Use shimmer for better UX
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[300],
        child: _buildNetworkIndicator(),
      ),
    );
  }

  /// Build network quality indicator
  Widget _buildNetworkIndicator() {
    final quality = _networkService.currentQuality;

    if (quality == NetworkQuality.poor || quality == NetworkQuality.offline) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  quality == NetworkQuality.offline
                      ? Colors.red.shade400
                      : Colors.orange.shade400,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              quality == NetworkQuality.offline ? 'Offline' : 'Slow',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  /// Handle error and classify
  void _handleError(dynamic error) {
    _lastError = _retryService.classifyError(error);
    _cacheService.recordFailure(widget.imageUrl);

    // Auto-retry for retryable errors
    if (_retryService.isRetryable(_lastError!) && _retryAttempt < 3) {
      _retryAttempt++;
      final delay = Duration(seconds: _retryAttempt);
      Future.delayed(delay, () {
        if (mounted) {
          setState(() {}); // Trigger rebuild to retry
        }
      });
    }
  }

  /// Build error widget with helpful message
  Widget _buildErrorWidget(ImageErrorType errorType) {
    final message = _retryService.getErrorMessage(errorType);
    final canRetry = _retryService.isRetryable(errorType) && _retryAttempt < 3;

    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getErrorIcon(errorType),
            size: 24,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          if (canRetry) ...[
            const SizedBox(height: 4),
            TextButton(
              onPressed: () {
                setState(() {
                  _retryAttempt = 0;
                  _lastError = null;
                });
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Retry', style: TextStyle(fontSize: 11)),
            ),
          ],
        ],
      ),
    );
  }

  /// Get icon for error type
  IconData _getErrorIcon(ImageErrorType errorType) {
    switch (errorType) {
      case ImageErrorType.network:
        return Icons.wifi_off;
      case ImageErrorType.notFound:
        return Icons.image_not_supported;
      case ImageErrorType.timeout:
        return Icons.timer_off;
      case ImageErrorType.serverError:
        return Icons.cloud_off;
      case ImageErrorType.invalidUrl:
        return Icons.link_off;
      case ImageErrorType.unknown:
        return Icons.error_outline;
    }
  }
}
