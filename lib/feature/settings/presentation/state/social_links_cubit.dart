import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/social_link_entity.dart';

/// States for Social Links feature
abstract class SocialLinksState extends Equatable {
  const SocialLinksState();

  @override
  List<Object?> get props => [];
}

class SocialLinksInitial extends SocialLinksState {
  const SocialLinksInitial();
}

class SocialLinksLoading extends SocialLinksState {
  const SocialLinksLoading();
}

class SocialLinksLoaded extends SocialLinksState {
  final List<SocialLinkEntity> links;

  const SocialLinksLoaded({required this.links});

  @override
  List<Object?> get props => [links];
}

class SocialLinksSaving extends SocialLinksState {
  const SocialLinksSaving();
}

class SocialLinksSaved extends SocialLinksState {
  final List<SocialLinkEntity> links;

  const SocialLinksSaved({required this.links});

  @override
  List<Object?> get props => [links];
}

class SocialLinksError extends SocialLinksState {
  final String message;

  const SocialLinksError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Cubit for managing Social Links state
class SocialLinksCubit extends Cubit<SocialLinksState> {
  SocialLinksCubit() : super(const SocialLinksInitial());

  /// Load social links
  void loadLinks() {
    emit(const SocialLinksLoading());

    // TODO: Implement actual links loading from repository
    try {
      // This would typically call a repository method
      // final links = await _socialLinksRepository.getLinks();

      // Mock links for now
      final mockLinks = <SocialLinkEntity>[
        SocialLinkEntity(
          id: '1',
          type: SocialLinkType.website,
          url: 'https://example.com',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          updatedAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
        SocialLinkEntity(
          id: '2',
          type: SocialLinkType.twitter,
          url: 'https://twitter.com/example',
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
          updatedAt: DateTime.now().subtract(const Duration(days: 15)),
        ),
      ];

      emit(SocialLinksLoaded(links: mockLinks));
    } catch (e) {
      emit(SocialLinksError(message: 'Failed to load social links: $e'));
    }
  }

  /// Add a new social link
  void addLink(SocialLinkEntity link) {
    final currentState = state;
    if (currentState is SocialLinksLoaded) {
      emit(const SocialLinksSaving());

      try {
        // TODO: Implement actual link saving to repository
        // await _socialLinksRepository.addLink(link);

        final updatedLinks = List<SocialLinkEntity>.from(currentState.links)
          ..add(link);

        // Simulate API call delay
        Future.delayed(const Duration(seconds: 1), () {
          emit(SocialLinksSaved(links: updatedLinks));
        });
      } catch (e) {
        emit(SocialLinksError(message: 'Failed to add social link: $e'));
      }
    }
  }

  /// Update an existing social link
  void updateLink(SocialLinkEntity updatedLink) {
    final currentState = state;
    if (currentState is SocialLinksLoaded) {
      emit(const SocialLinksSaving());

      try {
        // TODO: Implement actual link updating to repository
        // await _socialLinksRepository.updateLink(updatedLink);

        final updatedLinks = currentState.links.map((link) {
          return link.id == updatedLink.id ? updatedLink : link;
        }).toList();

        // Simulate API call delay
        Future.delayed(const Duration(seconds: 1), () {
          emit(SocialLinksSaved(links: updatedLinks));
        });
      } catch (e) {
        emit(SocialLinksError(message: 'Failed to update social link: $e'));
      }
    }
  }

  /// Delete a social link
  void deleteLink(String linkId) {
    final currentState = state;
    if (currentState is SocialLinksLoaded) {
      emit(const SocialLinksSaving());

      try {
        // TODO: Implement actual link deletion from repository
        // await _socialLinksRepository.deleteLink(linkId);

        final updatedLinks =
            currentState.links.where((link) => link.id != linkId).toList();

        // Simulate API call delay
        Future.delayed(const Duration(seconds: 1), () {
          emit(SocialLinksSaved(links: updatedLinks));
        });
      } catch (e) {
        emit(SocialLinksError(message: 'Failed to delete social link: $e'));
      }
    }
  }

  /// Toggle link active status
  void toggleLinkStatus(String linkId) {
    final currentState = state;
    if (currentState is SocialLinksLoaded) {
      emit(const SocialLinksSaving());

      try {
        final updatedLinks = currentState.links.map((link) {
          if (link.id == linkId) {
            return link.copyWith(
              isActive: !link.isActive,
              updatedAt: DateTime.now(),
            );
          }
          return link;
        }).toList();

        // Simulate API call delay
        Future.delayed(const Duration(seconds: 1), () {
          emit(SocialLinksSaved(links: updatedLinks));
        });
      } catch (e) {
        emit(SocialLinksError(message: 'Failed to toggle link status: $e'));
      }
    }
  }

  /// Reset to initial state
  void reset() {
    emit(const SocialLinksInitial());
  }
}
