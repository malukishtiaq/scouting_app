extension ListExtensions on List? {
  bool get isEmptyOrNull {
    return this == null || this!.isEmpty;
  }

  bool get isNotEmptyNorNull {
    return this != null && this!.isNotEmpty;
  }

  T? itemOrNull<T>(int index) {
    if (isEmptyOrNull) return null;
    if (index >= this!.length) return null;
    return this![index];
  }

  T? firstWhereOrNull<T>(bool Function(T element) test) {
    if (this == null) return null;
    for (int i = 0; i < this!.length; i++) {
      if (test.call(this![i])) {
        return this![i];
      }
    }
    return null;
  }
}
