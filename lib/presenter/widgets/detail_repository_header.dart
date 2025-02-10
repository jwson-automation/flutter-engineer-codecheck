import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';

/// リポジトリヘッダーを表示するウィジェット（アバター、リポジトリ名、戻るボタンを含む）
class DetailRepositoryHeader extends StatelessWidget {
  const DetailRepositoryHeader({
    required this.avatarUrl,
    required this.fullName,
    super.key,
  });

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
                style: AppFontStyle.repositoryName,
              ),
            ),
          ],
        ),
      );
}

/// リポジトリのアバターを表示するウィジェット
class DetailRepositoryAvatar extends StatelessWidget {
  const DetailRepositoryAvatar({
    required this.avatarUrl,
    super.key,
  });

  final String avatarUrl;

  @override
  Widget build(BuildContext context) => ClipOval(
        child: SizedBox(
          width: 32,
          height: 32,
          child: StreamBuilder<ImageChunkEvent?>(
            stream: Stream.value(null),
            builder: (context, snapshot) => Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Theme.of(context).primaryColor,
                  highlightColor: Theme.of(context).primaryColorLight,
                  child: Container(
                    width: 32,
                    height: 32,
                    color: Colors.white,
                  ),
                ),
                Image.network(
                  avatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.error,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
