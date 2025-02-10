import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:flutter_engineer_codecheck/presenter/detail_screen.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/search_result_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list_item.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索結果リストウィジェット
class SearchResultList extends ConsumerWidget {
  /// 検索結果のリポジトリリストを表示します。
  /// ローディング状態、エラー状態、空の結果状態を適切に処理します。
  const SearchResultList({super.key});

  void _handleRepositoryTap(
    BuildContext context,
    SearchResultModel searchResult,
  ) {
    // リポジトリ詳細画面に遷移
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => DetailScreen(searchResult: searchResult),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult = ref.watch(searchResultProvider);

    if (searchResult.isLoading) {
      return Image.asset(
        'assets/yumemi_logo.gif',
        width: 300,
        height: 300,
      );
    }

    if (searchResult.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: context.colorScheme.error),
              const SizedBox(height: 16),
              Text(
                searchResult.error!,
                style: AppFontStyle.errorMessage,
              ),
            ],
          ),
        ),
      );
    }

    if (searchResult.searchResults.isEmpty) {
      return Center(
        child: Text(
          context.localizations.noResults,
          style: AppFontStyle.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: searchResult.searchResults.length,
      itemBuilder: (context, index) {
        final repository = searchResult.searchResults[index];
        return SearchResultListItem(
          searchResult: repository,
          onTap: () =>
              _handleRepositoryTap(context, searchResult.searchResults[index]),
        );
      },
    );
  }
}
