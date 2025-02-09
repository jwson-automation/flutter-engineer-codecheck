import 'package:flutter_engineer_codecheck/data/github_repository.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:flutter_engineer_codecheck/data/error/exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索に関連する状態とロジックを提供するプロバイダー
/// StateNotifierProviderを使用して状態変更通知を購読可能
final searchResultProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(),
);

/// 検索に関連する状態を管理するクラス
class SearchState {
  SearchState({
    this.searchResults = const [],
    this.isLoading = false,
    this.error,
  });

  /// [searchResults] 検索結果リスト
  final List<SearchResultModel> searchResults;

  /// [isLoading] 検索中のローディング状態
  final bool isLoading;

  /// [error] エラー発生時のエラーメッセージ
  final String? error;

  /// 現在の状態をコピーして新しい状態を生成するメソッド
  /// 変更しないフィールドにnullを渡すと既存の値が維持される
  SearchState copyWith({
    List<SearchResultModel>? searchResults,
    bool? isLoading,
    String? error,
  }) =>
      SearchState(
        searchResults: searchResults ?? this.searchResults,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
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
      state = state.copyWith(isLoading: true);

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
      final errorMessage = e is GitHubException
          // GitHubExceptionの場合はエラーメッセージを表示
          ? '${e.runtimeType.toString().replaceAll('GitHub', '')}: ${e.message}'
          : e.toString();
      state = state.copyWith(
        error: errorMessage,
        isLoading: false,
      );
    }
  }

  /// 検索結果を初期化するメソッド
  void clearResults() {
    state = SearchState();
  }
}
