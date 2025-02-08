import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/github_repository_model.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/repository_list_item.dart';

/// 検索結果リストウィジェット
/// 検索結果のリポジトリリストを表示します。
/// ローディング状態、エラー状態、空の結果状態を適切に処理します。
class SearchResultList extends StatelessWidget {
  /// ローディング状態を示すフラグ
  final bool isLoading;

  /// エラーメッセージ（エラーがない場合はnull）
  final String? error;

  /// 検索結果のリポジトリリスト
  final List<GitHubRepositoryModel> searchResults;

  /// リポジトリがタップされた時のコールバック
  final Function(GitHubRepositoryModel) onRepositoryTap;

  const SearchResultList({
    super.key,
    required this.isLoading,
    required this.error,
    required this.searchResults,
    required this.onRepositoryTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      );
    }

    if (searchResults.isEmpty) {
      return const Center(
        child: Text('リポジトリを検索してください'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final repository = searchResults[index];
        return RepositoryListItem(
          repository: repository,
          onTap: () => onRepositoryTap(repository),
        );
      },
    );
  }
}
