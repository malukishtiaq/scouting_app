import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/scouting_posts/domain/entity/post_response_entity.dart';

/// Posts List Response Model with pagination
class PostsListResponseModel extends BaseModel<PostsListResponseEntity> {
  final List<PostItemModel> data;
  final PaginationLinksModel links;
  final PaginationMetaModel meta;

  PostsListResponseModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory PostsListResponseModel.fromJson(Map<String, dynamic> json) {
    return PostsListResponseModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => PostItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      links: PaginationLinksModel.fromJson(json['links'] ?? {}),
      meta: PaginationMetaModel.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
    };
  }

  @override
  PostsListResponseEntity toEntity() {
    return PostsListResponseEntity(
      data: data.map((e) => e.toEntity()).toList(),
      links: links.toEntity(),
      meta: meta.toEntity(),
    );
  }
}

/// Individual Post Item Model
class PostItemModel extends BaseModel<PostItemEntity> {
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

  PostItemModel({
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

  factory PostItemModel.fromJson(Map<String, dynamic> json) {
    return PostItemModel(
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
  PostItemEntity toEntity() {
    return PostItemEntity(
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

/// Single Post Response Model
class PostResponseModel extends BaseModel<PostResponseEntity> {
  final PostItemModel data;

  PostResponseModel({
    required this.data,
  });

  factory PostResponseModel.fromJson(Map<String, dynamic> json) {
    return PostResponseModel(
      data: PostItemModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }

  @override
  PostResponseEntity toEntity() {
    return PostResponseEntity(
      data: data.toEntity(),
    );
  }
}

/// Pagination Links Model
class PaginationLinksModel extends BaseModel<PaginationLinksEntity> {
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
      if (first != null) 'first': first,
      if (last != null) 'last': last,
      if (prev != null) 'prev': prev,
      if (next != null) 'next': next,
    };
  }

  @override
  PaginationLinksEntity toEntity() {
    return PaginationLinksEntity(
      first: first,
      last: last,
      prev: prev,
      next: next,
    );
  }
}

/// Pagination Meta Model
class PaginationMetaModel extends BaseModel<PaginationMetaEntity> {
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
      links: (json['links'] as List<dynamic>?)
              ?.map((e) =>
                  PaginationLinkItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 10,
      to: json['to'],
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      if (from != null) 'from': from,
      'last_page': lastPage,
      'links': links.map((e) => e.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      if (to != null) 'to': to,
      'total': total,
    };
  }

  @override
  PaginationMetaEntity toEntity() {
    return PaginationMetaEntity(
      currentPage: currentPage,
      from: from,
      lastPage: lastPage,
      links: links.map((e) => e.toEntity()).toList(),
      path: path,
      perPage: perPage,
      to: to,
      total: total,
    );
  }
}

/// Individual pagination link item model
class PaginationLinkItemModel extends BaseModel<PaginationLinkItemEntity> {
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
      if (url != null) 'url': url,
      'label': label,
      if (page != null) 'page': page,
      'active': active,
    };
  }

  @override
  PaginationLinkItemEntity toEntity() {
    return PaginationLinkItemEntity(
      url: url,
      label: label,
      page: page,
      active: active,
    );
  }
}

