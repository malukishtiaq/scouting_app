import 'package:injectable/injectable.dart';

import 'package:logger/logger.dart';

/// Registering Logger as a Singleton
@module
abstract class LoggerModule {
  @lazySingleton
  Logger get logger => Logger();
}
