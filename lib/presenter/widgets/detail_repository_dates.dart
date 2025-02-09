import 'package:flutter/material.dart';

/// リポジトリの作成日と最終更新日を表示するウィジェット
class DetailRepositoryDates extends StatelessWidget {
  const DetailRepositoryDates({
    Key? key,
    required this.createdAt,
    required this.updatedAt,
  }) : super(key: key);
  final String createdAt;
  final String updatedAt;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 8),
              Text(
                'Created: $createdAt',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.update, size: 16),
              const SizedBox(width: 8),
              Text(
                'Last updated: $updatedAt',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      );
}
