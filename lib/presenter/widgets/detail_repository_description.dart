import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';

/// リポジトリの説明を表示するウィジェット
class DetailRepositoryDescription extends StatelessWidget {
  const DetailRepositoryDescription({
    required this.description,
    super.key,
  });
  final String description;

  @override
  Widget build(BuildContext context) => Text(
        description,
        style: AppFontStyle.repositoryDescription,
      );
}
