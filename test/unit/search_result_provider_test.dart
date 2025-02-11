import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/github_repository.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/search_result_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/github_repository_fixtures.dart';
import '../shared/test_widget.dart';

/// GitHubRepositoryのモック
class MockGitHubRepository extends Mock implements GitHubRepository {}

/// 検索結果プロバイダーのテスト
void main() {
  late MockGitHubRepository mockRepository;

  setUpAll(() {
    /// 環境変数の初期化
    FlutterConfig.loadValueForTesting({'GITHUB_TOKEN': 'test_token'});
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockRepository = MockGitHubRepository();
  });

  group('SearchResultProviderのテスト', () {
    /// 初期状態のテスト
    test('初期状態が空であること', () {
      final container = ProviderContainer(
        overrides: [
          searchResultProvider.overrideWith(
            (ref) => SearchNotifier(repository: mockRepository),
          ),
        ],
      );
      addTearDown(container.dispose);

      final state = container.read(searchResultProvider);
      // 初期状態の検証
      expect(state.searchResults, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, null);
      expect(state.currentPage, 1);
      expect(state.lastSearchText, '');
      expect(state.isNextLoading, false);
    });

    /// SearchState copyWithメソッドの動作テスト
    test('SearchState copyWithメソッドが正しく動作すること', () {
      final initialState = SearchState();
      // fixturesからテスト用のリポジトリモデルを使用
      final repository = GitHubRepositoryFixtures.testRepositoryModel;

      // 新しい状態を作成して検証
      final newState = initialState.copyWith(
        searchResults: [repository],
        isLoading: true,
        error: 'Test error',
        currentPage: 2,
        lastSearchText: 'test',
        isNextLoading: true,
      );

      expect(newState.searchResults.length, 1);
      expect(newState.searchResults.first.fullName, repository.fullName);
      expect(newState.isLoading, true);
      expect(newState.error, 'Test error');
      expect(newState.currentPage, 2);
      expect(newState.lastSearchText, 'test');
      expect(newState.isNextLoading, true);
    });

    /// copyWithメソッドが変更されていない値を維持することを確認するテスト
    test('SearchState copyWithが変更されていない値を維持すること', () {
      // fixturesからテスト用の初期状態を設定
      final searchResult = GitHubRepositoryFixtures.testRepositoryModel;

      final initialState = SearchState(
        searchResults: [searchResult],
        isLoading: true,
        error: 'Initial error',
        currentPage: 2,
        lastSearchText: 'test',
        isNextLoading: true,
      );

      // isLoadingのみを変更
      final newState = initialState.copyWith(
        isLoading: false,
      );

      // 他の値が維持されていることを確認
      expect(newState.searchResults, equals(initialState.searchResults));
      expect(newState.isLoading, false);
      expect(newState.currentPage, equals(initialState.currentPage));
      expect(newState.lastSearchText, equals(initialState.lastSearchText));
      expect(newState.isNextLoading, equals(initialState.isNextLoading));
      // エラーが初期化されていることを確認
      expect(newState.error, isNot(equals(initialState.error)));
    });

    /// 検索結果のクリア機能テスト
    test('SearchNotifierのclearResultsが状態をリセットすること', () {
      final container = ProviderContainer(
        overrides: [
          searchResultProvider.overrideWith(
            (ref) => SearchNotifier(repository: mockRepository),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(searchResultProvider.notifier);
      // 検索結果をクリア
      notifier.clearResults();

      // 状態がリセットされたことを確認
      final state = container.read(searchResultProvider);
      expect(state.searchResults, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, null);
      expect(state.currentPage, 1);
      expect(state.lastSearchText, '');
      expect(state.isNextLoading, false);
    });

    /// ページネーション関連のテスト
    group('ページネーションのテスト', () {
      testWidgets('初期ページネーション状態が正しいこと', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchResultProvider.overrideWith(
                (ref) => SearchNotifier(repository: mockRepository),
              ),
            ],
            child: buildTestApp(Container()),
          ),
        );

        final container =
            ProviderScope.containerOf(tester.element(find.byType(Container)));
        final state = container.read(searchResultProvider);
        expect(state.currentPage, 1);
        expect(state.isNextLoading, false);
        expect(state.lastSearchText, '');
      });

      testWidgets('次のページの読み込みが状態を正しく更新すること', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchResultProvider.overrideWith(
                (ref) => SearchNotifier(repository: mockRepository),
              ),
            ],
            child: buildTestApp(Container()),
          ),
        );

        final container =
            ProviderScope.containerOf(tester.element(find.byType(Container)));
        final notifier = container.read(searchResultProvider.notifier);
        final state = container.read(searchResultProvider);

        // 初期状態の確認
        expect(state.currentPage, 1);
        expect(state.isNextLoading, false);

        // 次のページの読み込みを試行（lastSearchTextが空のため、読み込みは行われないはず）
        await notifier.loadNextPage(tester.element(find.byType(Container)));

        final updatedState = container.read(searchResultProvider);
        expect(updatedState.currentPage, 1); // ページが変更されていないことを確認
        expect(updatedState.isNextLoading, false);
      });

      testWidgets('検索がページネーション状態をリセットすること', (tester) async {
        when(() => mockRepository.searchRepositories(
                  searchText: any(named: 'searchText'),
                  sort: any(named: 'sort'),
                  order: any(named: 'order'),
                  page: any(named: 'page'),
                ))
            .thenAnswer(
                (_) async => [GitHubRepositoryFixtures.testRepositoryModel]);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchResultProvider.overrideWith(
                (ref) => SearchNotifier(repository: mockRepository),
              ),
            ],
            child: buildTestApp(Container()),
          ),
        );

        final container =
            ProviderScope.containerOf(tester.element(find.byType(Container)));
        final notifier = container.read(searchResultProvider.notifier);

        // 検索を実行
        await notifier.search('test', tester.element(find.byType(Container)));
        await tester.pump();

        final state = container.read(searchResultProvider);
        expect(state.currentPage, 1);
        expect(state.lastSearchText, 'test');
        expect(state.isNextLoading, false);
      });
    });
  });
}
