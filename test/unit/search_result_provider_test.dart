import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/search_result_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../fixtures/github_repository_fixtures.dart';

/// 検索結果プロバイダーのテスト
void main() {
  setUpAll(() {
    /// 環境変数の初期化
    FlutterConfig.loadValueForTesting({'GITHUB_TOKEN': 'test_token'});
  });

  group('SearchResultProvider Tests', () {
    /// 初期状態のテスト
    test('Initial state is empty', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(searchResultProvider);
      // 初期状態の検証
      expect(state.searchResults, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, null);
    });

    /// SearchState copyWithメソッドの動作テスト
    test('SearchState copyWith method works correctly', () {
      final initialState = SearchState();
      // fixturesからテスト用のリポジトリモデルを使用
      final repository = GitHubRepositoryFixtures.testRepositoryModel;

      // 新しい状態を作成して検証
      final newState = initialState.copyWith(
        searchResults: [repository],
        isLoading: true,
        error: 'Test error',
      );

      expect(newState.searchResults.length, 1);
      expect(newState.searchResults.first.fullName, repository.fullName);
      expect(newState.isLoading, true);
      expect(newState.error, 'Test error');
    });

    /// copyWithメソッドが変更されていない値を維持することを確認するテスト
    test('SearchState copyWith maintains unchanged values', () {
      // fixturesからテスト用の初期状態を設定
      final repository = GitHubRepositoryFixtures.testRepositoryModel;

      final initialState = SearchState(
        searchResults: [repository],
        isLoading: true,
        error: 'Initial error',
      );

      // isLoadingのみを変更
      final newState = initialState.copyWith(
        isLoading: false,
      );

      // 他の値が維持されていることを確認
      expect(newState.searchResults, equals(initialState.searchResults));
      expect(newState.isLoading, false);
      expect(newState.error, equals(initialState.error));
    });

    /// 検索結果のクリア機能テスト
    test('SearchNotifier clearResults resets state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(searchResultProvider.notifier);
      // 検索結果をクリア
      notifier.clearResults();

      // 状態がリセットされたことを確認
      final state = container.read(searchResultProvider);
      expect(state.searchResults, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, null);
    });
  });
}
