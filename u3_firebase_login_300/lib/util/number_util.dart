class NumberUtil {
  static bool isInteger(String valor) {
    return int.tryParse(valor) != null;
  }
}
