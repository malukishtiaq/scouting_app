import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

/// States for About Me feature
abstract class AboutMeState extends Equatable {
  const AboutMeState();

  @override
  List<Object?> get props => [];
}

class AboutMeInitial extends AboutMeState {
  const AboutMeInitial();
}

class AboutMeLoading extends AboutMeState {
  const AboutMeLoading();
}

class AboutMeLoaded extends AboutMeState {
  final String about;

  const AboutMeLoaded({required this.about});

  @override
  List<Object?> get props => [about];
}

class AboutMeSaving extends AboutMeState {
  const AboutMeSaving();
}

class AboutMeSaved extends AboutMeState {
  final String about;

  const AboutMeSaved({required this.about});

  @override
  List<Object?> get props => [about];
}

class AboutMeError extends AboutMeState {
  final String message;

  const AboutMeError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Cubit for managing About Me state
class AboutMeCubit extends Cubit<AboutMeState> {
  AboutMeCubit() : super(const AboutMeInitial());

  /// Load about text
  void loadAbout() {
    emit(const AboutMeLoading());

    // TODO: Implement actual about loading from repository
    try {
      // This would typically call a repository method
      // final about = await _profileRepository.getAbout();

      // Mock about text for now
      const mockAbout =
          'This is a sample about text. I love technology, music, and traveling. I\'m passionate about learning new things and meeting new people.';

      emit(AboutMeLoaded(about: mockAbout));
    } catch (e) {
      emit(AboutMeError(message: 'Failed to load about text: $e'));
    }
  }

  /// Save about text
  void saveAbout(String about) {
    emit(const AboutMeSaving());

    // TODO: Implement actual about saving to repository
    try {
      // This would typically call a repository method
      // await _profileRepository.updateAbout(about);

      // Simulate API call delay
      Future.delayed(const Duration(seconds: 1), () {
        emit(AboutMeSaved(about: about));
      });
    } catch (e) {
      emit(AboutMeError(message: 'Failed to save about text: $e'));
    }
  }

  /// Reset to initial state
  void reset() {
    emit(const AboutMeInitial());
  }
}
