import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../account/domain/usecase/list_members_usecase.dart';
import '../../../account/data/request/param/list_members_param.dart';
import '../../../account/domain/entity/member_response_entity.dart';
import 'explore_state.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  final ListMembersUsecase _listMembersUsecase;

  ExploreCubit(this._listMembersUsecase) : super(const ExploreState.initial());

  List<MemberDataEntity> _allMembers = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  String _searchQuery = '';

  /// Load initial members list
  Future<void> loadMembers() async {
    if (state is ExploreLoading) return;

    emit(const ExploreState.loading());

    try {
      final param = ListMembersParam(page: 1);
      final result = await _listMembersUsecase(param);

      result.pick(
        onData: (data) {
          _allMembers = data.data;
          _currentPage = 1;
          _hasMore = data.data.length >= 16; // Assuming 16 items per page

          emit(ExploreState.loaded(
            members: _allMembers,
            currentPage: _currentPage,
            hasMore: _hasMore,
          ));
        },
        onError: (error) {
          emit(ExploreState.error(
            message: error.message ?? 'Failed to load members',
            retry: loadMembers,
          ));
        },
      );
    } catch (e) {
      emit(ExploreState.error(
        message: 'An unexpected error occurred',
        retry: loadMembers,
      ));
    }
  }

  /// Load more members (pagination)
  Future<void> loadMoreMembers() async {
    final currentState = state;
    if (currentState is! ExploreLoaded) return;
    if (!currentState.hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = _currentPage + 1;
      final param = ListMembersParam(page: nextPage);
      final result = await _listMembersUsecase(param);

      result.pick(
        onData: (data) {
          _allMembers.addAll(data.data);
          _currentPage = nextPage;
          _hasMore = data.data.length >= 16;
          _isLoadingMore = false;

          emit(ExploreState.loaded(
            members: _allMembers,
            currentPage: _currentPage,
            hasMore: _hasMore,
            isLoadingMore: false,
          ));
        },
        onError: (error) {
          _isLoadingMore = false;
          emit(currentState.copyWith(isLoadingMore: false));
        },
      );
    } catch (e) {
      _isLoadingMore = false;
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  /// Refresh members list
  Future<void> refreshMembers() async {
    _allMembers.clear();
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
    _searchQuery = '';
    await loadMembers();
  }

  /// Search members by name, email, or position
  void searchMembers(String query) {
    _searchQuery = query.toLowerCase().trim();
    
    if (_searchQuery.isEmpty) {
      // Show all members
      emit(ExploreState.loaded(
        members: _allMembers,
        currentPage: _currentPage,
        hasMore: _hasMore,
        isLoadingMore: false,
      ));
      return;
    }

    // Filter members locally
    final filteredMembers = _allMembers.where((member) {
      final name = member.name.toLowerCase();
      final email = member.email.toLowerCase();
      final position = (member.primaryPosition ?? '').toLowerCase();
      
      return name.contains(_searchQuery) ||
          email.contains(_searchQuery) ||
          position.contains(_searchQuery);
    }).toList();

    emit(ExploreState.loaded(
      members: filteredMembers,
      currentPage: _currentPage,
      hasMore: false, // No pagination for search results
      isLoadingMore: false,
    ));
  }
}

