import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class CustomImage {
  CustomImage._();

  static Widget network(
    String imageUrl, {
    String? placeholderAssetImage,
    Widget Function(BuildContext, String)? placeholderBuilder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    bool showError = false,
    bool showProgressIndicator = false,
    double? height,
    double? width,
    BoxFit? fit,
    Alignment alignment = Alignment.center,
    Color? color,
    FilterQuality filterQuality = FilterQuality.low,
    BlendMode? colorBlendMode,
    Key? key,
    Map<String, String>? headers,
  }) {
    // Handle SVG files with a placeholder since we don't have flutter_svg
    if (imageUrl.toLowerCase().endsWith(".svg")) {
      return Container(
        key: key,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            Icons.image,
            size: 48,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    // Use standard Image.network for regular images
    return Image.network(
      imageUrl,
      key: key,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      alignment: alignment,
      color: color,
      colorBlendMode: colorBlendMode,
      filterQuality: filterQuality,
      headers: headers,
      loadingBuilder: showProgressIndicator
          ? (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: height,
                width: width,
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            }
          : null,
      errorBuilder: errorBuilder ??
          (context, error, stackTrace) {
            if (showError) {
              print('Error loading image: $error');
            }
            return Container(
              height: height,
              width: width,
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.broken_image,
                    size: 48,
                    color: Colors.grey[600],
                  ),
                  if (placeholderAssetImage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CustomImage.asset(
                        placeholderAssetImage,
                        width: width,
                        height: height,
                        fit: fit,
                      ),
                    ),
                ],
              ),
            );
          },
    );
  }

  static Widget asset(
    String imagePath, {
    Key? key,
    double? scale,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
  }) {
    final isSvg = imagePath.endsWith('svg');
    if (isSvg) {
      // SVG placeholder since we don't have flutter_svg
      return Container(
        key: key,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            Icons.image,
            size: 48,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return Image.asset(
      imagePath,
      key: key,
      scale: scale,
      width: width,
      height: height,
      color: color,
      fit: fit,
      alignment: alignment,
      colorBlendMode: colorBlendMode,
      repeat: repeat,
    );
  }

  static Widget memory(
    dynamic image, {
    Key? key,
    double scale = 1.0,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    Widget? placeholder,
    String? placeholderAsset,
  }) {
    try {
      Uint8List? bytes;
      if (image is String) {
        // Check if it's base64 encoded by matching typical base64 patterns
        final isBase64 = image.startsWith('data:image') ||
            RegExp(r'^[A-Za-z0-9+/]+={0,2}$').hasMatch(image);

        if (isBase64) {
          bytes = base64Decode(image);
          return Image.memory(
            bytes,
            key: key ?? UniqueKey(),
            scale: scale,
            width: width,
            height: height,
            color: color ?? Colors.transparent,
            fit: fit ?? BoxFit.contain,
            alignment: alignment,
            colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
          );
        } else {
          // Treat as file path
          return Image.file(
            File(image),
            key: key ?? UniqueKey(),
            scale: scale,
            width: width,
            height: height,
            color: color,
            fit: fit ?? BoxFit.contain,
            alignment: alignment,
            colorBlendMode: colorBlendMode,
          );
        }
      } else if (image is Uint8List) {
        // Directly use Uint8List
        return Image.memory(
          image,
          key: key ?? UniqueKey(),
          scale: scale,
          width: width,
          height: height,
          color: color ?? Colors.transparent,
          fit: fit ?? BoxFit.contain,
          alignment: alignment,
          colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
        );
      } else if (image is File) {
        // If File, use Image.file
        return Image.file(
          image,
          key: key ?? UniqueKey(),
          scale: scale,
          width: width,
          height: height,
          color: color,
          fit: fit ?? BoxFit.contain,
          alignment: alignment,
          colorBlendMode: colorBlendMode,
        );
      } else {
        // Placeholder in case of unsupported type
        return placeholder ??
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey[300],
              child: Icon(
                Icons.image,
                size: 48,
                color: Colors.grey[600],
              ),
            );
      }
    } catch (e) {
      print('Error loading image from memory: $e');
      return placeholder ??
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.grey[300],
            child: Icon(
              Icons.image,
              size: 48,
              color: Colors.grey[600],
            ),
          );
    }
  }
}
