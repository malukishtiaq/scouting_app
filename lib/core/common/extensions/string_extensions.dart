extension StringExtensions on String? {
  bool get isEmptyOrNull {
    return this == null || this!.isEmpty;
  }

  bool get isNotEmptyNorNull {
    return this != null && this!.isNotEmpty;
  }

  String get captilized {
    if (this == null || this!.isEmpty) return "";
    return this![0].toUpperCase() + this!.substring(1);
  }

  String get capitalizeWords {
    if (this == null || this!.isEmpty) return "";
    List<String> words = this!.split(' ');
    List<String> capitalizedWords =
        words.map((word) => word.captilized).toList();
    return capitalizedWords.join(' ');
  }
}
