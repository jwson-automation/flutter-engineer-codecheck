/// 基本 GitHub 例外クラス
abstract class GitHubException implements Exception {
  GitHubException(this.message);
  final String message;
}

/// ネットワーク関連の例外
class GitHubNetworkException extends GitHubException {
  GitHubNetworkException(super.message);
}

/// パース関連の例外
class GitHubParsingException extends GitHubException {
  GitHubParsingException(super.message);
}

/// 入力値検証失敗の例外
class GitHubValidationException extends GitHubException {
  GitHubValidationException(super.message);
}

/// 不明なエラーの例外
class GitHubUnknownException extends GitHubException {
  GitHubUnknownException(super.message);
}

/// 変更なしの例外
class GitHubNotModifiedException extends GitHubException {
  GitHubNotModifiedException(super.message);
}

/// サービス利用不可の例外
class GitHubServiceUnavailableException extends GitHubException {
  GitHubServiceUnavailableException(super.message);
}
