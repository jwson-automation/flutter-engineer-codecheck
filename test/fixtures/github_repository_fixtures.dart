import 'package:flutter_engineer_codecheck/data/github_repository_model.dart';

/// GitHubリポジトリテストのための共通テストデータ
mixin GitHubRepositoryFixtures {
  /// 基本テストJSONデータ
  static const Map<String, dynamic> testRepositoryJson = {
    'full_name': 'flutter/flutter',
    'owner': {
      'avatar_url':
          'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
    },
    'description': 'Flutter makes it easy and fast to build beautiful apps',
    'language': 'Dart',
    'stargazers_count': 1000,
    'watchers_count': 100,
    'forks_count': 500,
    'open_issues_count': 50,
  };

  /// オプションフィールドのないテストJSONデータ
  static final Map<String, dynamic> testRepositoryJsonWithMissingFields =
      Map<String, dynamic>.from(testRepositoryJson)
        ..remove('description')
        ..remove('language');

  /// 基本テストモデルインスタンス
  static final GitHubRepositoryModel testRepositoryModel =
      GitHubRepositoryModel.fromJson(testRepositoryJson);

  /// オプションフィールドのないテストモデルインスタンス
  static final GitHubRepositoryModel testRepositoryModelWithMissingFields =
      GitHubRepositoryModel.fromJson(testRepositoryJsonWithMissingFields);
}
