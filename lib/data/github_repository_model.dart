import 'package:flutter_engineer_codecheck/shared/json_validation_extension.dart';

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
        ownerAvatarUrl: json.validateUrl(json['owner']?['avatar_url']),
        language: json['language'],
        stargazersCount:
            json.parseCount(json['stargazers_count'], 'stargazers_count'),
        watchersCount:
            json.parseCount(json['watchers_count'], 'watchers_count'),
        forksCount: json.parseCount(json['forks_count'], 'forks_count'),
        openIssuesCount:
            json.parseCount(json['open_issues_count'], 'open_issues_count'),
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
