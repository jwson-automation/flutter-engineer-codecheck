import 'package:flutter_engineer_codecheck/data/github_repository.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:flutter_engineer_codecheck/data/error/exceptions.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
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
    this.isNextLoading = false,
    this.error,
    this.currentPage = 1,
    this.lastSearchText = '',
  });

  /// [searchResults] 検索結果リスト
  final List<SearchResultModel> searchResults;

  /// [isLoading] 検索中のローディング状態
  final bool isLoading;

  /// [isNextLoading] 次のページをロード中のローディング状態
  final bool isNextLoading;

  /// [error] エラー発生時のエラーメッセージ
  final String? error;

  /// [currentPage] 現在のページ番号
  final int currentPage;

  /// [lastSearchText] 前回の検索クエリ
  final String lastSearchText;

  /// 現在の状態をコピーして新しい状態を生成するメソッド
  /// 変更しないフィールドにnullを渡すと既存の値が維持される
  SearchState copyWith({
    List<SearchResultModel>? searchResults,
    bool? isLoading,
    bool? isNextLoading,
    String? error,
    int? currentPage,
    String? lastSearchText,
  }) =>
      SearchState(
        searchResults: searchResults ?? this.searchResults,
        isLoading: isLoading ?? this.isLoading,
        isNextLoading: isNextLoading ?? this.isNextLoading,
        error: error,
        currentPage: currentPage ?? this.currentPage,
        lastSearchText: lastSearchText ?? this.lastSearchText,
      );
}

/// 検索に関連するビジネスロジックを処理するStateNotifier
class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState());

  final GitHubRepository _repository = GitHubRepository();

  /// 検索を実行するメソッド
  /// [searchText] 検索クエリ
  /// [context] エラーダイアログ表示用のBuildContext
  Future<void> search(String searchText, BuildContext context) async {
    try {
      // 検索開始時にローディング状態に変更し、前回のエラーをリセット
      state = state.copyWith(
        isLoading: true,
        error: null,
        currentPage: 1,
        lastSearchText: searchText,
      );

      final results = await _repository.searchRepositories(
        searchText: searchText,
        sort: 'stars',
        order: 'desc',
        page: 1,
      );

      // 検索結果を状態に反映し、ローディング状態を解除
      state = state.copyWith(
        searchResults: results,
        isLoading: false,
      );
    } catch (e) {
      final errorMessage = _formatErrorMessage(e);
      state = state.copyWith(
        error: errorMessage,
        isLoading: false,
      );

      if (!context.mounted) return;
      await _showErrorDialog(context, e, errorMessage);
    }
  }

  /// 次のページをロードするメソッド
  Future<void> loadNextPage(BuildContext context) async {
    if (state.isLoading || state.lastSearchText.isEmpty) return;

    try {
      state = state.copyWith(isNextLoading: true);

      final nextPage = state.currentPage + 1;
      final results = await _repository.searchRepositories(
        searchText: state.lastSearchText,
        sort: 'stars',
        order: 'desc',
        page: nextPage,
      );

      state = state.copyWith(
        searchResults: [...state.searchResults, ...results],
        currentPage: nextPage,
        isNextLoading: false,
      );
    } catch (e) {
      final errorMessage = _formatErrorMessage(e);
      state = state.copyWith(
        error: errorMessage,
        isNextLoading: false,
      );

      if (!context.mounted) return;
      await _showErrorDialog(context, e, errorMessage);
    }
  }

  /// 検索結果を初期化するメソッド
  void clearResults() {
    state = SearchState();
  }

  /// エラーメッセージをフォーマットするメソッド
  String _formatErrorMessage(Object e) {
    if (e is GitHubException) {
      final type = e.runtimeType.toString().replaceAll('GitHub', '');
      return '$type: ${e.message}';
    }
    return e.toString();
  }


  /// エラーダイアログを表示するメソッド
  Future<void> _showErrorDialog(
      BuildContext context, Object e, String errorMessage) async {
    var title = context.localizations.errorDialogTitle;
    var solution = '';

    if (e is GitHubServiceUnavailableException) {
      title = context.localizations.apiLimitTitle;
      solution = context.localizations.apiLimitSolution;
    } else if (e is GitHubNotModifiedException) {
      title = context.localizations.searchErrorTitle;
      solution = context.localizations.searchErrorSolution;
    } else if (e is GitHubNetworkException) {
      title = context.localizations.networkErrorTitle;
      solution = context.localizations.networkErrorSolution;
    } else {
      solution = context.localizations.generalErrorSolution;
    }

    await ErrorDialog.show(
      context: context,
      title: title,
      message: errorMessage,
      solution: solution,
    );
  }
}
