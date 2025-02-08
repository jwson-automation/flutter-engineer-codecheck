import 'package:flutter_engineer_codecheck/data/github_repository_model.dart';
import 'package:flutter_test/flutter_test.dart';

/// GitHub リポジトリモデルのテストクラス
void main() {
  group('GitHubRepositoryModel Tests', () {
    /// 正常なJSONデータからモデルを作成するテスト
    test('fromJson creates correct model with valid data', () {
      // テスト用の有効なJSONデータを準備
      final json = {
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

      // JSONからモデルを生成
      final model = GitHubRepositoryModel.fromJson(json);

      // 各フィールドが正しく設定されているか検証
      expect(model.fullName, 'flutter/flutter');
      expect(model.ownerAvatarUrl,
          'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png');
      expect(
        model.description,
        'Flutter makes it easy and fast to build beautiful apps',
      );
      expect(model.language, 'Dart');
      expect(model.stargazersCount, 1000);
      expect(model.watchersCount, 100);
      expect(model.forksCount, 500);
      expect(model.openIssuesCount, 50);
    });

    /// オプションフィールドが欠落しているJSONデータの処理テスト
    test('fromJson handles missing optional fields', () {
      // 説明と言語フィールドが欠落したJSONデータ
      final json = {
        'full_name': 'flutter/flutter',
        'owner': {
          'avatar_url':
              'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
        },
        'stargazers_count': 1000,
        'watchers_count': 100,
        'forks_count': 500,
        'open_issues_count': 50,
      };

      final model = GitHubRepositoryModel.fromJson(json);

      // オプションフィールドがnullとして処理されることを確認
      expect(model.description, null);
      expect(model.language, null);
    });

    /// モデルからJSONへの変換テスト
    test('toJson converts model to correct json format', () {
      // テスト用のモデルインスタンスを作成
      final model = GitHubRepositoryModel(
        fullName: 'flutter/flutter',
        ownerAvatarUrl:
            'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
        description: 'Flutter makes it easy and fast to build beautiful apps',
        language: 'Dart',
        stargazersCount: 1000,
        watchersCount: 100,
        forksCount: 500,
        openIssuesCount: 50,
      );

      // モデルをJSONに変換
      final json = model.toJson();

      // 変換されたJSONの各フィールドを検証
      expect(json['full_name'], 'flutter/flutter');
      expect(json['owner']['avatar_url'],
          'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png');
      expect(json['description'],
          'Flutter makes it easy and fast to build beautiful apps');
      expect(json['language'], 'Dart');
      expect(json['stargazers_count'], 1000);
      expect(json['watchers_count'], 100);
      expect(json['forks_count'], 500);
      expect(json['open_issues_count'], 50);
    });
  });
}
