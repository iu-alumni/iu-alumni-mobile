extension NumFormatter on num {
  String get format {
    if (this is int) {
      return toString();
    }
    final whole = toInt();
    if (whole == this) {
      return whole.toString();
    }
    return toString();
  }
}
