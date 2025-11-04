import 'base_params.dart';

class NoParams extends BaseParams {
  NoParams({super.cancelToken});

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
