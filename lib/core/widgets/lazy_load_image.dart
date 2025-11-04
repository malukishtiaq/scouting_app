import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'smart_cached_image.dart';

/// Lazy loading image that only loads when visible
/// Prevents UI thread blocking from off-screen images
class LazyLoadImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Widget? placeholder;

  const LazyLoadImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.memCacheWidth,
    this.memCacheHeight,
    this.placeholder,
  });

  @override
  State<LazyLoadImage> createState() => _LazyLoadImageState();
}

class _LazyLoadImageState extends State<LazyLoadImage> {
  bool _shouldLoad = false;
  bool _hasBeenVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('lazy_${widget.imageUrl}'),
      onVisibilityChanged: (info) {
        // Load when at least 10% visible
        if (info.visibleFraction > 0.1 && !_hasBeenVisible) {
          setState(() {
            _shouldLoad = true;
            _hasBeenVisible = true;
          });
        }
      },
      child: _shouldLoad
          ? SmartCachedImage(
              imageUrl: widget.imageUrl,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              memCacheWidth: widget.memCacheWidth,
              memCacheHeight: widget.memCacheHeight,
              placeholder: widget.placeholder != null
                  ? (context, url) => widget.placeholder!
                  : null,
            )
          : widget.placeholder ??
              Container(
                width: widget.width,
                height: widget.height,
                color: Colors.grey[200],
              ),
    );
  }
}
