import 'package:get_it/get_it.dart';
import 'i_video_player_service.dart';
import '../impl/video_player_service_impl.dart';

class VideoPlayerServiceProvider {
  static IVideoPlayerService get service {
    return GetIt.instance<IVideoPlayerService>();
  }

  static void register() {
    GetIt.instance.registerSingleton<IVideoPlayerService>(
      VideoPlayerServiceImpl(),
    );
  }
}
