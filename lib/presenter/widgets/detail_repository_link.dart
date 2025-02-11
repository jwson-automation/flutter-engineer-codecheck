import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
import 'package:url_launcher/url_launcher.dart';

/// リポジトリリンクボタンを表示するウィジェット
class DetailRepositoryLink extends StatelessWidget {
  final String repositoryUrl;

  const DetailRepositoryLink({
    super.key,
    required this.repositoryUrl,
  });

  Future<void> _launchUrl() async {
    final uri = Uri.parse(repositoryUrl);
    print(uri);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.open_in_new),
          label: Text(
            context.localizations.goToRepository,
            style: AppFontStyle.button,
          ),
          onPressed: _launchUrl,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
}
