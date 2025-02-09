import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// リポジトリの作成日と最終更新日を表示するウィジェット
class DetailRepositoryDates extends StatelessWidget {
  const DetailRepositoryDates({
    required this.createdAt,
    required this.updatedAt,
    Key? key,
  }) : super(key: key);
  final String createdAt;
  final String updatedAt;

  /// 日付をフォーマットする
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy年 MM月 dd日').format(date);
    } catch (_) {
      return '----年 --月 --日';
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 8),
              Text(
                'Created: ${_formatDate(createdAt)}',
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
                'Updated: ${_formatDate(updatedAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      );
}
