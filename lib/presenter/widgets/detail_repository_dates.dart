import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';

/// リポジトリの作成日と最終更新日を表示するウィジェット
class DetailRepositoryDates extends StatelessWidget {
  const DetailRepositoryDates({
    required this.createdAt,
    required this.updatedAt,
    super.key,
  });
  final String createdAt;
  final String updatedAt;

  /// 日付をフォーマットする
  String _formatDate(BuildContext context, String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat(context.localizations.dateFormat).format(date);
    } catch (_) {
      return context.localizations.invalidDate;
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
                context.localizations.createdDate(
                  _formatDate(context, createdAt),
                ),
                style: AppFontStyle.metaInfo,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.update, size: 16),
              const SizedBox(width: 8),
              Text(
                context.localizations.updatedDate(
                  _formatDate(context, updatedAt),
                ),
                style: AppFontStyle.metaInfo,
              ),
            ],
          ),
        ],
      );
}
