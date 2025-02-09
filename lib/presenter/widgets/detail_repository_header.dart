import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
            DetailRepositoryAvatar(avatarUrl: avatarUrl),
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

/// リポジトリのアバターを表示するウィジェット
class DetailRepositoryAvatar extends StatelessWidget {
  const DetailRepositoryAvatar({
    super.key,
    required this.avatarUrl,
  });

  final String avatarUrl;

  @override
  Widget build(BuildContext context) => CircleAvatar(
        child: Image.network(
          avatarUrl,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }
          },
        ),
        radius: 16,
      );
}
