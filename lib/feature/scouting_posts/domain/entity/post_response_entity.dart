import '../../../../core/entities/base_entity.dart';

/// Posts List Response Entity with pagination
class PostsListResponseEntity extends BaseEntity {
  final List<PostItemEntity> data;
  final PaginationLinksEntity links;
  final PaginationMetaEntity meta;

  PostsListResponseEntity({
    required this.data,
    required this.links,
    required this.meta,
  });

  @override
  List<Object?> get props => [data, links, meta];
}

/// Individual Post Item Entity
class PostItemEntity extends BaseEntity {
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

  PostItemEntity({
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

/// Single Post Response Entity
class PostResponseEntity extends BaseEntity {
  final PostItemEntity data;

  PostResponseEntity({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

/// Pagination Links Entity
class PaginationLinksEntity extends BaseEntity {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  PaginationLinksEntity({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  @override
  List<Object?> get props => [first, last, prev, next];
}

/// Pagination Meta Entity
class PaginationMetaEntity extends BaseEntity {
  final int currentPage;
  final int? from;
  final int lastPage;
  final List<PaginationLinkItemEntity> links;
  final String path;
  final int perPage;
  final int? to;
  final int total;

  PaginationMetaEntity({
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

/// Individual pagination link item entity
class PaginationLinkItemEntity extends BaseEntity {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  PaginationLinkItemEntity({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  @override
  List<Object?> get props => [url, label, page, active];
}

