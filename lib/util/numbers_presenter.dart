extension NumbersPresenter on num {
  String get humanReadable {
    if (this is int) {
      return '$this';
    }
    final asInt = toInt();
    if (this == asInt) {
      return '$asInt';
    }
    return '$this';
  }
}
