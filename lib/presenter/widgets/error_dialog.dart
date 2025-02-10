import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';

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
  Widget build(BuildContext context) => AlertDialog(
      backgroundColor: context.theme.dialogTheme.backgroundColor,
      elevation: context.theme.dialogTheme.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: context.colorScheme.error),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppFontStyle.dialogTitle.copyWith(
                    color: context.colorScheme.error,
                  ),
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
              context.localizations.errorDialogProblem,
              style: AppFontStyle.dialogMessage.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppFontStyle.dialogMessage,
            ),
            const SizedBox(height: 16),
            Text(
              context.localizations.errorDialogSolution,
              style: AppFontStyle.dialogMessage.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              solution,
              style: AppFontStyle.dialogMessage,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            context.localizations.errorDialogClose,
            style: AppFontStyle.dialogMessage.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
}
