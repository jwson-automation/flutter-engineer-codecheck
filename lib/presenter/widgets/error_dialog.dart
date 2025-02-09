import 'package:flutter/material.dart';

/// エラーダイアログを表示するウィジェット
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.title,
    required this.message,
    required this.solution,
  });

  /// タイトル
  final String title;

  /// メッセージ
  final String message;

  /// 解決ガイド
  final String solution;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required String solution,
  }) =>
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (context) => ErrorDialog(
          title: title,
          message: message,
          solution: solution,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AlertDialog(
      backgroundColor: theme.dialogTheme.backgroundColor,
      elevation: theme.dialogTheme.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: theme.colorScheme.error),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '問題',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              '解決方法',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              solution,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            '閉じる',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
