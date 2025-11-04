enum ErrorCodeType {
  Unkown;

  static ErrorCodeType mapToType(int errorCode) {
    switch (errorCode) {
      default:
        return ErrorCodeType.Unkown;
    }
  }
}
