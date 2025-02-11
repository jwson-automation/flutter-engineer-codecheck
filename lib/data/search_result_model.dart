import 'package:flutter_engineer_codecheck/shared/json_validation_extension.dart';

/// GitHub リポジトリのモデル
class SearchResultModel {
  /// コンストラクタ
  SearchResultModel({
    required this.fullName,
    required this.ownerAvatarUrl,
    required this.language,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
    required this.createdAt,
    required this.updatedAt,
    required this.htmlUrl,
    this.description,
  });

  /// JSONからGitHubRepositoryModelを生成するファクトリメソッド
  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        fullName: json['full_name'] ?? '',
        ownerAvatarUrl: json.validateUrl(json['owner']?['avatar_url']),
        description: json['description'],
        language: json['language'],
        stargazersCount:
            json.parseCount(json['stargazers_count'], 'stargazers_count'),
        watchersCount:
            json.parseCount(json['watchers_count'], 'watchers_count'),
        forksCount: json.parseCount(json['forks_count'], 'forks_count'),
        openIssuesCount:
            json.parseCount(json['open_issues_count'], 'open_issues_count'),
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        htmlUrl: json['html_url'],
      );

  /// リポジトリ名
  final String fullName;

  /// オーナーのアバターURL
  final String ownerAvatarUrl;

  /// リポジトリの説明
  final String? description;

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

  /// 作成日時
  final String? createdAt;

  /// 更新日時
  final String? updatedAt;

  /// リポジトリのURL
  final String? htmlUrl;

  /// JSONに変換するメソッド
  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'owner': {'avatar_url': ownerAvatarUrl},
        'description': description,
        'language': language,
        'stargazers_count': stargazersCount,
        'watchers_count': watchersCount,
        'forks_count': forksCount,
        'open_issues_count': openIssuesCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'html_url': htmlUrl,
      };
}
