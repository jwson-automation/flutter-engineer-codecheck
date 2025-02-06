import 'package:flutter/material.dart';

/// GitHub リポジトリの検索結果を表示するリストアイテムウィジェット
class RepositoryListItem extends StatelessWidget {
  const RepositoryListItem({
    required this.repository, super.key,
    this.onTap,
  });
  /// リポジトリ情報を含むMap
  final Map<String, dynamic> repository;

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
                      repository['full_name'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              // リポジトリの説明がある場合は表示
              if (repository['description'] != null) ...[
                const SizedBox(height: 8),
                Text(
                  repository['description'],
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
                    Text('${repository['stargazers_count'] ?? 0}'),
                  ],
                ),
                const SizedBox(width: 16),

                // フォーク数
                Row(
                  children: [
                    const Icon(Icons.fork_right, size: 16),
                    const SizedBox(width: 4),
                    Text('${repository['forks_count'] ?? 0}'),
                  ],
                ),

                // 言語
                const SizedBox(width: 16),
                if (repository['language'] != null)
                  Row(
                    children: [
                      const Icon(Icons.code, size: 16),
                      const SizedBox(width: 4),
                      Text(repository['language']),
                    ],
                  ),
              ],
            ),
          ),
          onTap: onTap,
        ),
      );
}
