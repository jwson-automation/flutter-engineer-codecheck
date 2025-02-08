import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/github_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import '../fixtures/github_repository_fixtures.dart';

/// HTTPクライアントのモッククラス
class MockHttpClient extends Mock implements http.Client {}

/// GitHubリポジトリのテストスイート
void main() {
  late GitHubRepository repository;
  late MockHttpClient mockClient;

  setUpAll(() {
    /// Uri型のフォールバック値を登録
    registerFallbackValue(Uri());
  });

  setUp(() {
    /// テスト用の環境設定とモックオブジェクトの初期化
    FlutterConfig.loadValueForTesting({'GITHUB_TOKEN': 'test_token'});
    mockClient = MockHttpClient();
    repository = GitHubRepository(client: mockClient);
  });

  group('GitHubRepository Tests', () {
    /// リポジトリ検索の成功ケースをテスト
    test('searchRepositories returns list of repositories on success',
        () async {
      const searchQuery = 'flutter';
      // 模擬レスポンスJSONデータの生成
      final responseJson = jsonEncode({
        'items': [GitHubRepositoryFixtures.testRepositoryJson]
      });

      /// HTTP GETリクエストのモックレスポンスを設定
      when(() => mockClient.get(
            Uri.parse(
                'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1'),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response(responseJson, 200));

      final results = await repository.searchRepositories(searchText: searchQuery);

      /// レスポンス結果の検証
      expect(results.length, 1);
      expect(results[0].fullName, GitHubRepositoryFixtures.testRepositoryModel.fullName);
      expect(results[0].stargazersCount, GitHubRepositoryFixtures.testRepositoryModel.stargazersCount);
    });

    /// エラー発生時の例外処理テスト
    test('searchRepositories throws exception on error', () async {
      const searchQuery = 'flutter';

      when(() => mockClient.get(
                Uri.parse(
                    'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1'),
                headers: any(named: 'headers'),
              ))
          .thenAnswer((_) async => http.Response('{"message": "Error"}', 400));

      expect(
        () => repository.searchRepositories(searchText: searchQuery),
        throwsException,
      );
    });

    /// ソートと順序パラメータを含む検索テスト
    test('searchRepositories with sort and order parameters', () async {
      const searchQuery = 'flutter';
      const sort = 'stars';
      const order = 'desc';

      when(() => mockClient.get(
            Uri.parse(
                'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1&sort=$sort&order=$order'),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('{"items": []}', 200));

      final results = await repository.searchRepositories(
        searchText: searchQuery,
        sort: sort,
        order: order,
      );

      expect(results, isEmpty);
    });

    /// 無効なソートオプションの例外処理テスト
    test('searchRepositories throws ArgumentError for invalid sort option', () {
      expect(
        () => repository.searchRepositories(
          searchText: 'flutter',
          sort: 'invalid_sort',
        ),
        throwsArgumentError,
      );
    });

    /// 無効な順序オプションの例外処理テスト
    test('searchRepositories throws ArgumentError for invalid order option',
        () {
      expect(
        () => repository.searchRepositories(
          searchText: 'flutter',
          order: 'invalid_order',
        ),
        throwsArgumentError,
      );
    });
  });
}
