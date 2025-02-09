import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:flutter_engineer_codecheck/presenter/detail_screen.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/search_result_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索結果リストウィジェット
class SearchResultList extends ConsumerWidget {
  /// 検索結果のリポジトリリストを表示します。
  /// ローディング状態、エラー状態、空の結果状態を適切に処理します。
  const SearchResultList({super.key});

  void _handleRepositoryTap(
      BuildContext context, SearchResultModel searchResult) {
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
      return const Center(child: CircularProgressIndicator());
    }

    if (searchResult.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(searchResult.error!,
                style: const TextStyle(color: Colors.red)),
          ],
        ),
      );
    }

    if (searchResult.searchResults.isEmpty) {
      return const Center(
        child: Text('検索結果がありません'),
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
