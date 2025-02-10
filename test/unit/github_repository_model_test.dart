import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../shared/github_repository_fixtures.dart';

/// GitHub リポジトリモデルのテストクラス
void main() {
  group('GitHubRepositoryModel Tests', () {
    /// 正常なJSONデータからモデルを作成するテスト
    test('fromJson creates correct model with valid data', () {
      // JSONからモデルを生成
      final model = SearchResultModel.fromJson(
        GitHubRepositoryFixtures.testRepositoryJson,
      );

      // 各フィールドが正しく設定されているか検証
      expect(model.fullName, 'flutter/flutter');
      expect(
        model.ownerAvatarUrl,
        'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
      );
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
      final model = SearchResultModel.fromJson(
        GitHubRepositoryFixtures.testRepositoryJsonWithMissingFields,
      );

      // オプションフィールドがnullとして処理されることを確認
      expect(model.description, null);
      expect(model.language, null);
    });

    /// モデルからJSONへの変換テスト
    test('toJson converts model to correct json format', () {
      // テスト用のモデルインスタンスを使用
      final model = GitHubRepositoryFixtures.testRepositoryModel;

      // モデルをJSONに変換
      final json = model.toJson();

      // 変換されたJSONの各フィールドを検証
      expect(json['full_name'], 'flutter/flutter');
      expect(
        json['owner']['avatar_url'],
        'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
      );
      expect(
        json['description'],
        'Flutter makes it easy and fast to build beautiful apps',
      );
      expect(json['language'], 'Dart');
      expect(json['stargazers_count'], 1000);
      expect(json['watchers_count'], 100);
      expect(json['forks_count'], 500);
      expect(json['open_issues_count'], 50);
    });

    /// 往復Serializationテスト
    test('fromJson -> toJson', () {
      // JSONからモデルを生成
      final model = SearchResultModel.fromJson(
        GitHubRepositoryFixtures.testRepositoryJson,
      );

      // モデルをJSONに変換
      final newJson = model.toJson();

      // モデルから生成したJSONと元のJSONが同じか確認
      expect(newJson, GitHubRepositoryFixtures.testRepositoryJson);
    });
  });
}
