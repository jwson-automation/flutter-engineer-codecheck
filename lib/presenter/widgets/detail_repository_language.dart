import 'package:flutter/material.dart';

/// リポジトリで使用されているプログラミング言語を表示するウィジェット
class DetailRepositoryLanguage extends StatelessWidget {
  const DetailRepositoryLanguage({
    required this.language, super.key,
  });

  final String language;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Icon(Icons.circle, size: 12),
          const SizedBox(width: 8),
          Text(
            language,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
}
