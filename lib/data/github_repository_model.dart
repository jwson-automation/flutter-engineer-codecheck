/// GitHub リポジトリのモデル
class GitHubRepositoryModel {
  /// コンストラクタ
  GitHubRepositoryModel({
    required this.fullName,
    required this.ownerAvatarUrl,
    required this.language,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
  });

  /// リポジトリ名
  final String fullName;

  /// オーナーのアバターURL
  final String ownerAvatarUrl;

  /// プロジェクトの主要言語
  final String? language;

  /// スター数
  final int stargazersCount;

  /// ウォッチャー数
  final int watchersCount;

  /// フォーク数
  final int forksCount;

  /// Issue数
  final int openIssuesCount;

  /// JSONからGitHubRepositoryModelを生成するファクトリメソッド
  factory GitHubRepositoryModel.fromJson(Map<String, dynamic> json) =>
      GitHubRepositoryModel(
        fullName: json['full_name'] ?? '',
        ownerAvatarUrl: json['owner']?['avatar_url'] ?? '',
        language: json['language'],
        stargazersCount: json['stargazers_count'] ?? 0,
        watchersCount: json['watchers_count'] ?? 0,
        forksCount: json['forks_count'] ?? 0,
        openIssuesCount: json['open_issues_count'] ?? 0,
      );

  /// JSONに変換するメソッド
  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'owner': {'avatar_url': ownerAvatarUrl},
        'language': language,
        'stargazers_count': stargazersCount,
        'watchers_count': watchersCount,
        'forks_count': forksCount,
        'open_issues_count': openIssuesCount,
      };
}
