import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../services/smart_image_cache_service.dart';
import '../services/image_retry_service.dart';
import '../services/network_quality_service.dart';
import '../services/memory_pressure_service.dart';
import '../services/image_priority_queue_service.dart';

/// Optimized cached image with all performance enhancements
class OptimizedCachedImage extends StatefulWidget {
  final String imageUrl;
  final ImageContext context;
  final ImagePriority priority;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorBuilder;
  final bool enableProgressive;
  final String? blurHash; // Optional BlurHash for instant placeholder

  const OptimizedCachedImage({
    super.key,
    required this.imageUrl,
    this.context = ImageContext.feedImage,
    this.priority = ImagePriority.medium,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorBuilder,
    this.enableProgressive = true,
    this.blurHash,
  });

  @override
  State<OptimizedCachedImage> createState() => _OptimizedCachedImageState();
}

class _OptimizedCachedImageState extends State<OptimizedCachedImage> {
  final _cacheService = SmartImageCacheService();
  final _retryService = ImageRetryService();
  final _networkService = NetworkQualityService();
  final _memoryService = MemoryPressureService();

  ImageErrorType? _errorType;
  int _retryAttempt = 0;

  @override
  Widget build(BuildContext context) {
    // Check if URL failed recently
    if (_cacheService.hasFailedRecently(widget.imageUrl)) {
      return _buildErrorWidget(ImageErrorType.notFound);
    }

    // Get dimensions based on context and memory pressure
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
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) {
        _handleError(error);
        return _buildErrorWidget(_errorType ?? ImageErrorType.unknown);
      },
      imageBuilder: (context, imageProvider) {
        _cacheService.recordSuccess(widget.imageUrl);
        return _buildImageWithProgressive(imageProvider);
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
    );
  }

  /// Get adaptive dimensions based on context and conditions
  CacheDimensions _getAdaptiveDimensions() {
    var dimensions = _cacheService.getDimensionsForContext(widget.context);

    // Reduce dimensions based on memory pressure
    final memoryMultiplier = _memoryService.getCacheSizeMultiplier();
    if (memoryMultiplier < 1.0) {
      dimensions = CacheDimensions(
        width: (dimensions.width * memoryMultiplier).toInt(),
        height: (dimensions.height * memoryMultiplier).toInt(),
      );
    }

    // Reduce dimensions for poor network
    if (_networkService.currentQuality == NetworkQuality.poor) {
      dimensions = CacheDimensions(
        width: (dimensions.width * 0.7).toInt(),
        height: (dimensions.height * 0.7).toInt(),
      );
    }

    return dimensions;
  }

  /// Build placeholder with progressive loading
  Widget _buildPlaceholder() {
    if (widget.placeholder != null) {
      return widget.placeholder!;
    }

    // Use shimmer effect for instant preview
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[300],
        child: Center(child: _buildLoadingIndicator()),
      ),
    );
  }

  /// Build loading indicator based on network quality
  Widget _buildLoadingIndicator() {
    final quality = _networkService.currentQuality;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                quality == NetworkQuality.poor
                    ? Colors.orange
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
          if (quality == NetworkQuality.poor) ...[
            const SizedBox(height: 8),
            Text(
              'Slow connection',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Build image with progressive loading effect
  Widget _buildImageWithProgressive(ImageProvider imageProvider) {
    if (!widget.enableProgressive) {
      return Image(
        image: imageProvider,
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Image(
        key: ValueKey(widget.imageUrl),
        image: imageProvider,
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
      ),
    );
  }

  /// Handle image load error
  void _handleError(dynamic error) {
    _errorType = _retryService.classifyError(error);
    _cacheService.recordFailure(widget.imageUrl);

    // Attempt retry if error is retryable
    if (_retryService.isRetryable(_errorType!) && _retryAttempt < 3) {
      _retryAttempt++;
      Future.delayed(Duration(seconds: _retryAttempt), () {
        if (mounted) {
          setState(() {
            // Trigger rebuild to retry
          });
        }
      });
    }
  }

  /// Build error widget with retry option
  Widget _buildErrorWidget(ImageErrorType errorType) {
    if (widget.errorBuilder != null) {
      return widget.errorBuilder!(context, widget.imageUrl, errorType);
    }

    final message = _retryService.getErrorMessage(errorType);
    final canRetry = _retryService.isRetryable(errorType);

    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getErrorIcon(errorType),
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          if (canRetry && _retryAttempt < 3) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                setState(() {
                  _retryAttempt = 0;
                  _errorType = null;
                });
              },
              child: const Text('Retry', style: TextStyle(fontSize: 12)),
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
