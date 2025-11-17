import 'package:equatable/equatable.dart';
import '../../../../posts/domain/entity/posts_response_entity.dart';

abstract class MyProfilePostsState extends Equatable {
  const MyProfilePostsState();

  @override
  List<Object?> get props => [];
}

class MyProfilePostsInitial extends MyProfilePostsState {
  const MyProfilePostsInitial();
}

class MyProfilePostsLoading extends MyProfilePostsState {
  const MyProfilePostsLoading();
}

class MyProfilePostsLoaded extends MyProfilePostsState {
  final List<PostEntity> posts;
  final PaginationMeta meta;
  final bool isLoadingMore;

  const MyProfilePostsLoaded({
    required this.posts,
    required this.meta,
    this.isLoadingMore = false,
  });

  MyProfilePostsLoaded copyWith({
    List<PostEntity>? posts,
    PaginationMeta? meta,
    bool? isLoadingMore,
  }) {
    return MyProfilePostsLoaded(
      posts: posts ?? this.posts,
      meta: meta ?? this.meta,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [posts, meta, isLoadingMore];
}

class MyProfilePostsError extends MyProfilePostsState {
  final String message;

  const MyProfilePostsError(this.message);

  @override
  List<Object?> get props => [message];
}
