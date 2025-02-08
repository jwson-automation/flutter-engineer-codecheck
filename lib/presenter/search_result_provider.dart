import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索に関連する状態とロジックを提供するプロバイダー
/// StateNotifierProviderを使用して状態変更通知を購読可能
final searchResultProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});

/// 検索に関連する状態を管理するクラス
/// [searchResults] 検索結果リスト
/// [isLoading] 検索中のローディング状態
/// [error] エラー発生時のエラーメッセージ
class SearchState {
  final List<String> searchResults;
  final bool isLoading;
  final String? error;

  SearchState({
    this.searchResults = const [],
    this.isLoading = false,
    this.error,
  });

  /// 現在の状態をコピーして新しい状態を生成するメソッド
  /// 変更しないフィールドにnullを渡すと既存の値が維持される
  SearchState copyWith({
    List<String>? searchResults,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// 検索に関連するビジネスロジックを処理するStateNotifier
class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState());

  final GitHubRepository _repository = GitHubRepository();

  /// 検索を実行するメソッド
  /// [searchText] 検索クエリ
  Future<void> search(String searchText) async {
    try {
      // 検索開始時にローディング状態に変更し、前回のエラーをリセット
      state = state.copyWith(isLoading: true, error: null);
      
      final results = await _repository.searchRepositories(
        searchText: searchText,
        sort: 'stars',
        order: 'desc',
      );
      
      // 検索結果を状態に反映し、ローディング状態を解除
      state = state.copyWith(
        searchResults: results,
        isLoading: false,
      );
    } catch (e) {
      // エラー発生時にエラーメッセージを状態に反映し、ローディング状態を解除
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// 検索結果を初期化するメソッド
  void clearResults() {
    state = SearchState();
  }
}