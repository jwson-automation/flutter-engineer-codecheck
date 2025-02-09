import 'package:flutter/material.dart';

/// リポジトリヘッダーを表示するウィジェット（アバター、リポジトリ名、戻るボタンを含む）
class DetailRepositoryHeader extends StatelessWidget {
  const DetailRepositoryHeader({
    Key? key,
    required this.avatarUrl,
    required this.fullName,
  }) : super(key: key);

  /// リポジトリ所有者のアバターURL
  final String avatarUrl;

  /// リポジトリのフルネーム（所有者/リポジトリ名）
  final String fullName;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
              radius: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                fullName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      );
}
