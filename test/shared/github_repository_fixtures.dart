import 'package:flutter_engineer_codecheck/data/search_result_model.dart';

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
    'created_at': '2023-03-15T00:00:00Z',
    'updated_at': '2024-01-28T00:00:00Z',
  };

  /// オプションフィールドのないテストJSONデータ
  static final Map<String, dynamic> testRepositoryJsonWithMissingFields =
      Map<String, dynamic>.from(testRepositoryJson)
        ..remove('description')
        ..remove('language');

  /// 基本テストモデルインスタンス
  static final SearchResultModel testRepositoryModel =
      SearchResultModel.fromJson(testRepositoryJson);

  /// オプションフィールドのないテストモデルインスタンス
  static final SearchResultModel testRepositoryModelWithMissingFields =
      SearchResultModel.fromJson(testRepositoryJsonWithMissingFields);
}
