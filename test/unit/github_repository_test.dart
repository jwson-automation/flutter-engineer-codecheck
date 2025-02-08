import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/github_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

/// HTTPクライアントのモッククラス
class MockHttpClient extends Mock implements http.Client {}

void main() {
  late GitHubRepository repository;
  late MockHttpClient mockClient;

  setUpAll(() {
    // Uri型のフォールバック値を登録
    registerFallbackValue(Uri());
  });

  setUp(() {
    // テスト用の環境設定とモックオブジェクトの初期化
    FlutterConfig.loadValueForTesting({'GITHUB_TOKEN': 'test_token'});
    mockClient = MockHttpClient();
    repository = GitHubRepository(client: mockClient);
  });

  group('GitHubRepository Tests', () {
    test('searchRepositories returns list of repositories on success',
        () async {
      // リポジトリ検索成功のテスト
      const searchQuery = 'flutter';
      const responseJson = '''
      {
        "items": [
          {
            "full_name": "flutter/flutter",
            "owner": {
              "avatar_url": "https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png"
            },
            "description": "Flutter makes it easy and fast to build beautiful apps",
            "language": "Dart",
            "stargazers_count": 1000,
            "watchers_count": 100,
            "forks_count": 500,
            "open_issues_count": 50
          }
        ]
      }
      ''';

      // HTTP GETリクエストのモックレスポンスを設定
      when(() => mockClient.get(
            Uri.parse(
                'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1'),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response(responseJson, 200));

      final results =
          await repository.searchRepositories(searchText: searchQuery);

      // レスポンス結果の検証
      expect(results.length, 1);
      expect(results[0].fullName, 'flutter/flutter');
      expect(results[0].stargazersCount, 1000);
    });

    test('searchRepositories throws exception on error', () async {
      // エラー発生時の例外処理テスト
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

    test('searchRepositories with sort and order parameters', () async {
      // ソートと順序パラメータを含む検索テスト
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

    test('searchRepositories throws ArgumentError for invalid sort option', () {
      // 無効なソートオプションの例外処理テスト
      expect(
        () => repository.searchRepositories(
          searchText: 'flutter',
          sort: 'invalid_sort',
        ),
        throwsArgumentError,
      );
    });

    test('searchRepositories throws ArgumentError for invalid order option',
        () {
      // 無効な順序オプションの例外処理テスト
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
