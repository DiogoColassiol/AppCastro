class StringUtils {
  static String intToString(int? value) {
    return value?.toString() ?? '';
  }

  static int? stringToInt(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    } else {
      return int.tryParse(value.trim());
    }
  }
}
