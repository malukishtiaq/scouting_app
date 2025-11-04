import 'package:equatable/equatable.dart';

class VideoItem extends Equatable {
  final String id;
  final String url;
  final String? thumbnailUrl;
  final String? title;
  final VideoSource source;
  final Map<String, dynamic>? metadata;

  const VideoItem({
    required this.id,
    required this.url,
    this.thumbnailUrl,
    this.title,
    required this.source,
    this.metadata,
  });

  @override
  List<Object?> get props => [id, url, thumbnailUrl, title, source, metadata];

  VideoItem copyWith({
    String? id,
    String? url,
    String? thumbnailUrl,
    String? title,
    VideoSource? source,
    Map<String, dynamic>? metadata,
  }) {
    return VideoItem(
      id: id ?? this.id,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      title: title ?? this.title,
      source: source ?? this.source,
      metadata: metadata ?? this.metadata,
    );
  }
}

enum VideoSource {
  youtube,
  vimeo,
  direct,
  facebook,
  instagram,
  other,
}
