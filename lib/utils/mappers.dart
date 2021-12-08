extension Mappers on int {
  bool toBoolean() {
    if (this == 1) {
      return true;
    } else {
      return false;
    }
  }
}
