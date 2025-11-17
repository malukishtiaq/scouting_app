import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../posts/data/request/param/get_posts_param.dart';
import '../../../../posts/domain/entity/posts_response_entity.dart';
import '../../../../posts/domain/usecase/get_my_posts_usecase.dart';
import 'my_profile_posts_state.dart';

@injectable
class MyProfilePostsCubit extends Cubit<MyProfilePostsState> {
  final GetMyPostsUsecase _getMyPostsUsecase;

  List<PostEntity> _posts = [];
  PaginationMeta? _meta;
  int _currentPage = 1;
  bool _isLoading = false;

  MyProfilePostsCubit({
    required GetMyPostsUsecase getMyPostsUsecase,
  })  : _getMyPostsUsecase = getMyPostsUsecase,
        super(const MyProfilePostsInitial());

  Future<void> loadPosts(
      {bool refresh = false, bool isLoadMore = false}) async {
    if (_isLoading) return;
    _isLoading = true;

    if (refresh || (state is MyProfilePostsInitial && !isLoadMore)) {
      emit(const MyProfilePostsLoading());
      _currentPage = 1;
      _posts = [];
    }

    try {
      final param = GetPostsParam(page: _currentPage);
      final result = await _getMyPostsUsecase(param);

      result.pick(
        onData: (data) {
          if (_currentPage <= 1) {
            _posts = data.data;
          } else {
            _posts = [..._posts, ...data.data];
          }
          _meta = data.meta;
          emit(MyProfilePostsLoaded(
            posts: _posts,
            meta: data.meta,
            isLoadingMore: false,
          ));
        },
        onError: (error) {
          if (isLoadMore) {
            _currentPage--;
            if (state is MyProfilePostsLoaded) {
              emit((state as MyProfilePostsLoaded)
                  .copyWith(isLoadingMore: false));
            } else if (_meta != null) {
              emit(MyProfilePostsLoaded(
                posts: _posts,
                meta: _meta!,
                isLoadingMore: false,
              ));
            }
          } else {
            emit(MyProfilePostsError(
                error.message ?? 'Failed to load profile posts'));
          }
        },
      );
    } catch (e) {
      if (isLoadMore) {
        _currentPage--;
        if (state is MyProfilePostsLoaded) {
          emit((state as MyProfilePostsLoaded).copyWith(isLoadingMore: false));
        }
      } else {
        emit(MyProfilePostsError('Failed to load profile posts: $e'));
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshPosts() async {
    _currentPage = 1;
    await loadPosts(refresh: true);
  }

  Future<void> loadMorePosts() async {
    if (_isLoading) return;
    if (_meta == null || !_meta!.hasNextPage) return;
    if (state is MyProfilePostsLoaded) {
      emit((state as MyProfilePostsLoaded).copyWith(isLoadingMore: true));
    }
    _currentPage++;
    await loadPosts(isLoadMore: true);
  }
}
