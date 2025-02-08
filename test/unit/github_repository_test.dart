import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/github_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

/// HTTPクライアントのモッククラス
/// HTTP 클라이언트 목 클래스
class MockHttpClient extends Mock implements http.Client {}

/// GitHubリポジトリのテストスイート
/// GitHub 저장소 테스트 스위트
void main() {
  late GitHubRepository repository;
  late MockHttpClient mockClient;

  setUpAll(() {
    /// Uri型のフォールバック値を登録
    /// Uri 타입의 폴백 값 등록
    registerFallbackValue(Uri());
  });

  setUp(() {
    /// テスト用の環境設定とモックオブジェクトの初期化
    /// 테스트용 환경 설정과 목 객체 초기화
    FlutterConfig.loadValueForTesting({'GITHUB_TOKEN': 'test_token'});
    mockClient = MockHttpClient();
    repository = GitHubRepository(client: mockClient);
  });

  group('GitHubRepository Tests', () {
    /// リポジトリ検索の成功ケースをテスト
    /// 저장소 검색 성공 케이스 테스트
    test('searchRepositories returns list of repositories on success',
        () async {
      const searchQuery = 'flutter';
      // 模擬レスポンスJSONデータ
      // 모의 응답 JSON 데이터
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

      /// HTTP GETリクエストのモックレスポンスを設定
      /// HTTP GET 요청의 목 응답 설정
      when(() => mockClient.get(
            Uri.parse(
                'https://api.github.com/search/repositories?q=$searchQuery&per_page=30&page=1'),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response(responseJson, 200));

      final results = await repository.searchRepositories(searchText: searchQuery);

      /// レスポンス結果の検証
      /// 응답 결과 검증
      expect(results.length, 1);
      expect(results[0].fullName, 'flutter/flutter');
      expect(results[0].stargazersCount, 1000);
    });

    /// エラー発生時の例外処理テスト
    /// 에러 발생 시 예외 처리 테스트
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
    /// 정렬과 순서 매개변수를 포함한 검색 테스트
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
    /// 유효하지 않은 정렬 옵션의 예외 처리 테스트
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
    /// 유효하지 않은 순서 옵션의 예외 처리 테스트
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
