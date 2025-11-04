import 'package:flutter/material.dart';
import '../../../../core/errors/app_errors.dart';
import '../../domain/entity/reels_response_entity.dart';

abstract class ReelsState {
  const ReelsState();
}

class ReelsInitial extends ReelsState {
  const ReelsInitial();
}

class ReelsLoading extends ReelsState {
  const ReelsLoading();
}

class ReelsLoaded extends ReelsState {
  final List<PostDataEntity> reels;

  const ReelsLoaded(this.reels);
}

class ReelsError extends ReelsState {
  final AppErrors error;
  final VoidCallback retry;

  const ReelsError(this.error, this.retry);
}
