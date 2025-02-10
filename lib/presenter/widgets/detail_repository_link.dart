import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';

/// リポジトリリンクボタンを表示するウィジェット
class DetailRepositoryLink extends StatelessWidget {
  const DetailRepositoryLink({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.open_in_new),
          label: Text(
            'Go to Repository',
            style: AppFontStyle.button,
          ),
          onPressed: () {
            // TODO: リポジトリリンクを開く機能の実装
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
}
