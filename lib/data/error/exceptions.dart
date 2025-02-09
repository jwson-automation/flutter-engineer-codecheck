/// 基本 GitHub 例外クラス
abstract class GitHubException implements Exception {
  final String message;

  GitHubException(this.message);
}

/// ネットワーク関連の例外
class GitHubNetworkException extends GitHubException {
  GitHubNetworkException(String message) : super(message);
}

/// パース関連の例外
class GitHubParsingException extends GitHubException {
  GitHubParsingException(String message) : super(message);
}

/// 入力値検証失敗の例外
class GitHubValidationException extends GitHubException {
  GitHubValidationException(String message) : super(message);
}

/// 不明なエラーの例外
class GitHubUnknownException extends GitHubException {
  GitHubUnknownException(String message) : super(message);
}

/// 変更なしの例外
class GitHubNotModifiedException extends GitHubException {
  GitHubNotModifiedException(String message) : super(message);
}

/// サービス利用不可の例外
class GitHubServiceUnavailableException extends GitHubException {
  GitHubServiceUnavailableException(String message) : super(message);
}
