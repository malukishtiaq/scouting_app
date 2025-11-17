import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../account/domain/entity/member_response_entity.dart';

part 'explore_state.freezed.dart';

@freezed
class ExploreState with _$ExploreState {
  const factory ExploreState.initial() = ExploreInitial;

  const factory ExploreState.loading() = ExploreLoading;

  const factory ExploreState.loaded({
    required List<MemberDataEntity> members,
    @Default(false) bool isLoadingMore,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
  }) = ExploreLoaded;

  const factory ExploreState.error({
    required String message,
    required VoidCallback retry,
  }) = ExploreError;
}
