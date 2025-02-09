import 'dart:convert';
import 'dart:io';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/error/exceptions.dart';
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
    test('リポジトリの検索が成功した場合、リポジトリのリストを返すこと', () async {
      const searchQuery = 'flutter';
      final responseJson = jsonEncode({
        'items': [GitHubRepositoryFixtures.testRepositoryJson],
      });

      when(() => mockClient.get(
            Uri.parse(
                'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1',),
            headers: any(named: 'headers'),
          ),).thenAnswer((_) async => http.Response(responseJson, 200));

      final results =
          await repository.searchRepositories(searchText: searchQuery);

      expect(results.length, 1);
      expect(results[0].fullName,
          GitHubRepositoryFixtures.testRepositoryModel.fullName,);
      expect(results[0].stargazersCount,
          GitHubRepositoryFixtures.testRepositoryModel.stargazersCount,);
    });

    test('空の検索テキストの場合、GitHubValidationExceptionをスローすること', () {
      expect(
        () => repository.searchRepositories(searchText: '  '),
        throwsA(isA<GitHubValidationException>()),
      );
    });

    test('無効なソートオプションの場合、GitHubValidationExceptionをスローすること', () {
      expect(
        () => repository.searchRepositories(
          searchText: 'flutter',
          sort: 'invalid_sort',
        ),
        throwsA(isA<GitHubValidationException>()),
      );
    });

    test('無効な順序オプションの場合、GitHubValidationExceptionをスローすること', () {
      expect(
        () => repository.searchRepositories(
          searchText: 'flutter',
          order: 'invalid_order',
        ),
        throwsA(isA<GitHubValidationException>()),
      );
    });

    test('ネットワークエラーの場合、GitHubNetworkExceptionをスローすること', () async {
      const searchQuery = 'flutter';

      when(() => mockClient.get(
            Uri.parse(
                'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1',),
            headers: any(named: 'headers'),
          ),).thenThrow(const SocketException('ネットワーク接続を確認してください。'));

      expect(
        () => repository.searchRepositories(searchText: searchQuery),
        throwsA(isA<GitHubNetworkException>()),
      );
    });

    test('503エラーの場合、GitHubServiceUnavailableExceptionをスローすること', () async {
      const searchQuery = 'flutter';

      when(() => mockClient.get(
                Uri.parse(
                    'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1',),
                headers: any(named: 'headers'),
              ),)
          .thenAnswer((_) async => http.Response(
              '{"message": "Service Unavailable", "documentation_url": "https://docs.github.com/"}',
              503,),);

      expect(
        () => repository.searchRepositories(searchText: searchQuery),
        throwsA(isA<GitHubServiceUnavailableException>()),
      );
    });

    test('有効なソートと順序パラメータで検索が成功すること', () async {
      const searchQuery = 'flutter';
      const sort = 'stars';
      const order = 'desc';

      when(() => mockClient.get(
            Uri.parse(
                'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1&sort=$sort&order=$order',),
            headers: any(named: 'headers'),
          ),).thenAnswer((_) async => http.Response('{"items": []}', 200));

      final results = await repository.searchRepositories(
        searchText: searchQuery,
        sort: sort,
        order: order,
      );

      expect(results, isEmpty);
    });
  });
}
