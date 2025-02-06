/// Jsonからの値取得時のバリデーションを行う拡張メソッド
extension JsonValidationExtension on Map<String, dynamic> {
  /// カウンターのバリデーションを行う
  int parseCount(dynamic value, String field) {
    if (value == null) return 0;
    if (value is! int) {
      throw FormatException('Invalid $field: $value');
    }
    return value;
  }

  /// URLのバリデーションを行う
  String validateUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (!url.startsWith('http')) {
      throw FormatException('Invalid URL format: $url');
    }
    return url;
  }
}
