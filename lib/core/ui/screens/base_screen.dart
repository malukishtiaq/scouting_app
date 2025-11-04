import 'package:flutter/cupertino.dart';

abstract class BaseScreen<T> extends StatefulWidget {
  final T param;

  const BaseScreen({required this.param, required super.key});

//  Screen create<Screen extends BaseScreen>()
}
