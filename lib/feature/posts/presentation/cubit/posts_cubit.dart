import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/request/param/get_posts_param.dart';
import '../../domain/entity/posts_response_entity.dart';
import '../../domain/usecase/get_posts_usecase.dart';
import '../../domain/usecase/get_post_by_id_usecase.dart';
import 'posts_state.dart';

@injectable
class PostsCubit extends Cubit<PostsState> {
  final GetPostsUsecase getPostsUsecase;
  final GetPostByIdUsecase getPostByIdUsecase;

  PostsCubit({
    required this.getPostsUsecase,
    required this.getPostByIdUsecase,
  }) : super(const PostsInitial());

  List<PostEntity> _posts = [];
  int _currentPage = 1;
  PaginationMeta? _meta;
  bool _isLoading = false;

  /// Load initial posts (page 1)
  void loadPosts() async {
    if (_isLoading) return;

    emit(const PostsLoading());
    _isLoading = true;
    _currentPage = 1;

    try {
      final param = GetPostsParam(page: _currentPage);
      final result = await getPostsUsecase(param);

      result.pick(
        onData: (data) {
          _posts = data.data;
          _meta = data.meta;
          emit(PostsLoaded(posts: _posts, meta: _meta!));
          _isLoading = false;
        },
        onError: (error) {
          emit(PostsError(error, () => loadPosts()));
          _isLoading = false;
        },
      );
    } catch (e) {
      emit(PostsError(
        _createErrorFromException(e),
        () => loadPosts(),
      ));
      _isLoading = false;
    }
  }

  /// Load more posts (next page)
  void loadMorePosts() async {
    if (_isLoading || _meta == null || !_meta!.hasNextPage) return;

    // Show loading indicator for pagination
    if (state is PostsLoaded) {
      emit((state as PostsLoaded).copyWith(isLoadingMore: true));
    }

    _isLoading = true;
    _currentPage++;

    try {
      final param = GetPostsParam(page: _currentPage);
      final result = await getPostsUsecase(param);

      result.pick(
        onData: (data) {
          _posts.addAll(data.data);
          _meta = data.meta;
          emit(PostsLoaded(posts: _posts, meta: _meta!, isLoadingMore: false));
          _isLoading = false;
        },
        onError: (error) {
          // Revert page number on error
          _currentPage--;
          if (state is PostsLoaded) {
            emit((state as PostsLoaded).copyWith(isLoadingMore: false));
          }
          _isLoading = false;
        },
      );
    } catch (e) {
      _currentPage--;
      if (state is PostsLoaded) {
        emit((state as PostsLoaded).copyWith(isLoadingMore: false));
      }
      _isLoading = false;
    }
  }

  /// Refresh posts (reload from page 1)
  void refreshPosts() async {
    _currentPage = 1;
    _posts.clear();
    loadPosts();
  }

  /// Load a single post by ID
  void loadPostById(int postId) async {
    emit(const PostDetailLoading());

    try {
      final param = GetPostByIdParam(postId: postId);
      final result = await getPostByIdUsecase(param);

      result.pick(
        onData: (post) {
          emit(PostDetailLoaded(post));
        },
        onError: (error) {
          emit(PostDetailError(error, () => loadPostById(postId)));
        },
      );
    } catch (e) {
      emit(PostDetailError(
        _createErrorFromException(e),
        () => loadPostById(postId),
      ));
    }
  }

  /// Helper method to create AppErrors from exceptions
  dynamic _createErrorFromException(Object e) {
    // You may need to import AppErrors or create a proper error
    return e;
  }

  /// Get current posts
  List<PostEntity> get posts => _posts;

  /// Get current page
  int get currentPage => _currentPage;

  /// Check if has more pages
  bool get hasMorePages => _meta?.hasNextPage ?? false;
}
