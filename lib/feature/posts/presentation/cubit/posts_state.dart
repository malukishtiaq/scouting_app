import 'package:equatable/equatable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../domain/entity/posts_response_entity.dart';

/// Base state for Posts
abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PostsInitial extends PostsState {
  const PostsInitial();
}

/// Loading state
class PostsLoading extends PostsState {
  const PostsLoading();
}

/// Loaded state with posts data
class PostsLoaded extends PostsState {
  final List<PostEntity> posts;
  final PaginationMeta meta;
  final bool isLoadingMore;

  const PostsLoaded({
    required this.posts,
    required this.meta,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [posts, meta, isLoadingMore];

  PostsLoaded copyWith({
    List<PostEntity>? posts,
    PaginationMeta? meta,
    bool? isLoadingMore,
  }) {
    return PostsLoaded(
      posts: posts ?? this.posts,
      meta: meta ?? this.meta,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

/// Error state
class PostsError extends PostsState {
  final AppErrors error;
  final VoidCallback? retry;

  const PostsError(this.error, [this.retry]);

  @override
  List<Object?> get props => [error, retry];
}

/// Single Post Loading state
class PostDetailLoading extends PostsState {
  const PostDetailLoading();
}

/// Single Post Loaded state
class PostDetailLoaded extends PostsState {
  final PostEntity post;

  const PostDetailLoaded(this.post);

  @override
  List<Object?> get props => [post];
}

/// Single Post Error state
class PostDetailError extends PostsState {
  final AppErrors error;
  final VoidCallback? retry;

  const PostDetailError(this.error, [this.retry]);

  @override
  List<Object?> get props => [error, retry];
}

typedef VoidCallback = void Function();
