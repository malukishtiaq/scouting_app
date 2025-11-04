import 'dart:convert';

import 'create_model.interceptor.dart';

class PrimitiveCreateModelInterceptor extends CreateModelInterceptor {
  const PrimitiveCreateModelInterceptor();
  @override
  T getModel<T>(dynamic Function(dynamic p1) modelCreator, dynamic json) {
    return modelCreator(jsonDecode(jsonEncode(json)));
  }
}
