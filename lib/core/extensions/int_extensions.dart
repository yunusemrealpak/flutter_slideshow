

extension IntExtension on int {
  rawBoolean() {
    if (this == 0)
      return false;
    else if (this == 1) return true;
  }

  bool get isNullOrDefault {
    if (this == 0)
      return true;
    else
      return false;
  }
}
