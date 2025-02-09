import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/github_repository_model.dart';

/// GitHub リポジトリの検索結果を表示するリストアイテムウィジェット
class SearchResultListItem extends StatelessWidget {
  const SearchResultListItem({
    required this.searchResult,
    super.key,
    this.onTap,
  });

  /// リポジトリ情報
  final GitHubRepositoryModel searchResult;

  /// タップ時のコールバック
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // リポジトリアイコン
                  const Icon(Icons.book, size: 20),
                  const SizedBox(width: 8),

                  // リポジトリ名
                  Expanded(
                    child: Text(
                      searchResult.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              // リポジトリの説明がある場合は表示
              if (searchResult.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  searchResult.description!,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),

          // サブタイトル
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                // スター数
                Row(
                  children: [
                    const Icon(Icons.star_border, size: 16),
                    const SizedBox(width: 4),
                    Text('${searchResult.stargazersCount}'),
                  ],
                ),
                const SizedBox(width: 16),

                // フォーク数
                Row(
                  children: [
                    const Icon(Icons.fork_right, size: 16),
                    const SizedBox(width: 4),
                    Text('${searchResult.forksCount}'),
                  ],
                ),

                // 言語
                const SizedBox(width: 16),
                if (searchResult.language != null)
                  Row(
                    children: [
                      const Icon(Icons.code, size: 16),
                      const SizedBox(width: 4),
                      Text(searchResult.language!),
                    ],
                  ),
              ],
            ),
          ),
          onTap: onTap,
        ),
      );
}
