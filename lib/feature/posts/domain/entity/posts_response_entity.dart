import '../../../../core/entities/base_entity.dart';

/// Posts API Response Entity - domain layer representation
class PostsResponseEntity extends BaseEntity {
  final List<PostEntity> data;
  final PaginationLinks links;
  final PaginationMeta meta;

  PostsResponseEntity({
    required this.data,
    required this.links,
    required this.meta,
  });

  @override
  List<Object?> get props => [data, links, meta];
}

/// Individual Post Entity
class PostEntity extends BaseEntity {
  final int id;
  final String title;
  final String description;
  final String mediaUrl;
  final String mediaType;
  final String user;
  final int userId;
  final String userAvatar;
  final int likes;
  final int shares;
  final int comments;

  PostEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.mediaType,
    required this.user,
    required this.userId,
    required this.userAvatar,
    required this.likes,
    required this.shares,
    required this.comments,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        mediaUrl,
        mediaType,
        user,
        userId,
        userAvatar,
        likes,
        shares,
        comments,
      ];
}

/// Pagination Links Entity
class PaginationLinks extends BaseEntity {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  PaginationLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  @override
  List<Object?> get props => [first, last, prev, next];
}

/// Pagination Meta Entity
class PaginationMeta extends BaseEntity {
  final int currentPage;
  final int? from;
  final int lastPage;
  final List<PaginationLinkItem> links;
  final String path;
  final int perPage;
  final int? to;
  final int total;

  PaginationMeta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    this.to,
    required this.total,
  });

  @override
  List<Object?> get props => [
        currentPage,
        from,
        lastPage,
        links,
        path,
        perPage,
        to,
        total,
      ];

  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
}

/// Individual pagination link item
class PaginationLinkItem extends BaseEntity {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  PaginationLinkItem({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  @override
  List<Object?> get props => [url, label, page, active];
}
