import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/core/net/create_model_interceptor/create_model.interceptor.dart';

/// This class is singleton and used to get models from json responses
class ModelsFactory {
  static const FROM_JSON = "FROM_JSON";
  static const CREATE_MODEL_INTERCEPTOR = "CREATE_MODEL_INTERCEPTOR";

  static final _instance = ModelsFactory._();

  factory ModelsFactory() {
    return _instance;
  }
  ModelsFactory._();

  /// Mapping each model name with the actual value using fromJson factory method and createModelInterceptor.
  /// Map structure
  /// "model_name":{
  /// "FROM_JSON": fromJson factoryMethod (dynamic Function(dynamic),
  /// "CREATE_MODEL_INTERCEPTOR": CreateModelInterceptor
  /// }
  ///
  final Map<String, dynamic> _modelsMap = {};

  /// Register the model in the map.
  void registerModel(
    String modelName,
    dynamic Function(dynamic) modelCreator,
    String createModelInterceptorName,
    CreateModelInterceptor createModelInterceptor,
    bool isList,
  ) {
    final Map<String, dynamic> modelInfo = {};
    modelInfo[FROM_JSON] =
        modelCreator; // Direct assignment instead of putIfAbsent
    modelInfo[CREATE_MODEL_INTERCEPTOR] =
        createModelInterceptor; // Direct assignment

    // Use direct assignment to allow updates on hot reload
    _modelsMap[getModelName(modelName, isList)] = modelInfo;
  }

  /// Generate the desired T model.
  T createModel<T extends BaseModel>(json, bool isList) {
    final modelName = getModelName(T.toString(), isList);
    final modelInfo = _modelsMap[modelName];
    final fromJson = modelInfo[FROM_JSON];
    final createModelInterceptor = modelInfo[CREATE_MODEL_INTERCEPTOR];
    final model = createModelInterceptor.getModel(fromJson, json);
    return model;
  }

  /// Generate list of T model.
  // List<T?> createModelsList<T extends BaseModel>(json) {
  //   return (json as List)
  //       .map((m) => m == null ? null : createModel<T>(m))
  //       .toList();
  // }
  String getModelName(String modelName, bool isList) {
    return "$modelName${isList ? "List" : ""}";
  }
}
