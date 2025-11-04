import '../../../../../core/models/base_model.dart';
import '../../../domain/entity/posts_response_entity.dart';

/// Posts API Response Model - matches https://scouting.terveys.io/api/posts
class PostsResponseModel extends BaseModel<PostsResponseEntity> {
  final List<PostModel> data;
  final PaginationLinksModel links;
  final PaginationMetaModel meta;

  PostsResponseModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory PostsResponseModel.fromJson(Map<String, dynamic> json) {
    return PostsResponseModel(
      data: json['data'] != null
          ? List<PostModel>.from(json['data'].map((x) => PostModel.fromJson(x)))
          : [],
      links: PaginationLinksModel.fromJson(json['links'] ?? {}),
      meta: PaginationMetaModel.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((x) => x.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
    };
  }

  @override
  PostsResponseEntity toEntity() {
    return PostsResponseEntity(
      data: data.map((x) => x.toEntity()).toList(),
      links: links.toEntity(),
      meta: meta.toEntity(),
    );
  }
}

/// Individual Post Model
class PostModel extends BaseModel<PostEntity> {
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

  PostModel({
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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      mediaUrl: json['media_url'] ?? '',
      mediaType: json['media_type'] ?? '',
      user: json['user'] ?? '',
      userId: json['user_id'] ?? 0,
      userAvatar: json['user_avatar'] ?? '',
      likes: json['likes'] ?? 0,
      shares: json['shares'] ?? 0,
      comments: json['comments'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'media_url': mediaUrl,
      'media_type': mediaType,
      'user': user,
      'user_id': userId,
      'user_avatar': userAvatar,
      'likes': likes,
      'shares': shares,
      'comments': comments,
    };
  }

  @override
  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      description: description,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
      user: user,
      userId: userId,
      userAvatar: userAvatar,
      likes: likes,
      shares: shares,
      comments: comments,
    );
  }
}

/// Pagination Links Model
class PaginationLinksModel extends BaseModel<PaginationLinks> {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  PaginationLinksModel({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory PaginationLinksModel.fromJson(Map<String, dynamic> json) {
    return PaginationLinksModel(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }

  @override
  PaginationLinks toEntity() {
    return PaginationLinks(
      first: first,
      last: last,
      prev: prev,
      next: next,
    );
  }
}

/// Pagination Meta Model
class PaginationMetaModel extends BaseModel<PaginationMeta> {
  final int currentPage;
  final int? from;
  final int lastPage;
  final List<PaginationLinkItemModel> links;
  final String path;
  final int perPage;
  final int? to;
  final int total;

  PaginationMetaModel({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    this.to,
    required this.total,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      currentPage: json['current_page'] ?? 1,
      from: json['from'],
      lastPage: json['last_page'] ?? 1,
      links: json['links'] != null
          ? List<PaginationLinkItemModel>.from(
              json['links'].map((x) => PaginationLinkItemModel.fromJson(x)))
          : [],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 10,
      to: json['to'],
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links.map((x) => x.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }

  @override
  PaginationMeta toEntity() {
    return PaginationMeta(
      currentPage: currentPage,
      from: from,
      lastPage: lastPage,
      links: links.map((x) => x.toEntity()).toList(),
      path: path,
      perPage: perPage,
      to: to,
      total: total,
    );
  }
}

/// Individual pagination link item
class PaginationLinkItemModel extends BaseModel<PaginationLinkItem> {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  PaginationLinkItemModel({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  factory PaginationLinkItemModel.fromJson(Map<String, dynamic> json) {
    return PaginationLinkItemModel(
      url: json['url'],
      label: json['label'] ?? '',
      page: json['page'],
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'page': page,
      'active': active,
    };
  }

  @override
  PaginationLinkItem toEntity() {
    return PaginationLinkItem(
      url: url,
      label: label,
      page: page,
      active: active,
    );
  }
}
