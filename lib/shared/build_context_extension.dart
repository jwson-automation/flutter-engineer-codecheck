import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/error_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// BuildContextの拡張機能
extension BuildContextExtension on BuildContext {
  /// 多言語対応のための拡張機能
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  /// テーマカラーを取得する拡張機能
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// テーマを取得する拡張機能
  ThemeData get theme => Theme.of(this);

  /// エラーダイアログを表示する拡張機能
  Future<void> showErrorDialog({
    required String title,
    required String message,
    required String solution,
  }) async => showDialog(
      context: this,
      barrierColor: Colors.black54,
      builder: (context) => ErrorDialog(
        title: title,
        message: message,
        solution: solution,
      ),
    );
}
