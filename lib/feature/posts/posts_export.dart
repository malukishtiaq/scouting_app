/// Posts Feature Export File
/// This file exports all public APIs for the Posts feature

// Data Layer
export 'data/datasources/iposts_remote_datasource.dart';
export 'data/datasources/posts_remote_datasource.dart';
export 'data/request/model/posts_response_model.dart';
export 'data/request/param/get_posts_param.dart';

// Domain Layer
export 'domain/entity/posts_response_entity.dart';
export 'domain/repositories/iposts_repository.dart';
export 'domain/repositories/posts_repository.dart';
export 'domain/usecase/get_posts_usecase.dart';
export 'domain/usecase/get_post_by_id_usecase.dart';

// Presentation Layer
export 'presentation/cubit/posts_cubit.dart';
export 'presentation/cubit/posts_state.dart';
export 'presentation/screen/posts_screen.dart';
export 'presentation/widgets/post_detail_widget.dart';
