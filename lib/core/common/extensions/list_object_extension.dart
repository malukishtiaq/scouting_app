extension ListObj on List<Object>? {
  /// Whether this collection hasn't `null` value and has at least one element.
  bool get haveValues => this != null && this!.isNotEmpty;
}
