import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';

/// リポジトリの統計情報を表示するウィジェット（スター、フォーク、ウォッチャー、イシュー）
class DetailRepositoryStats extends StatelessWidget {
  const DetailRepositoryStats({
    required this.stars,
    required this.forks,
    required this.watchers,
    required this.issues,
    super.key,
  });

  final int stars;
  final int forks;
  final int watchers;
  final int issues;

  @override
  Widget build(BuildContext context) => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          DetailStatCard(
            icon: Icons.star,
            value: stars.toString(),
            label: 'Stars',
          ),
          DetailStatCard(
            icon: Icons.fork_right,
            value: forks.toString(),
            label: 'Forks',
          ),
          DetailStatCard(
            icon: Icons.remove_red_eye,
            value: watchers.toString(),
            label: 'Watchers',
          ),
          DetailStatCard(
            icon: Icons.error_outline,
            value: issues.toString(),
            label: 'Issues',
          ),
        ],
      );
}

/// 統計情報カードを表示するウィジェット
class DetailStatCard extends StatelessWidget {
  const DetailStatCard({
    required this.icon,
    required this.value,
    required this.label,
    super.key,
  });

  /// カードに表示するアイコン
  final IconData icon;

  /// 統計値
  final String value;

  /// 統計項目のラベル
  final String label;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(flex: 3, child: Icon(icon, size: 28)),
              const SizedBox(height: 8),
              Flexible(
                flex: 4,
                child: Text(
                  value,
                  style: AppFontStyle.statsValue,
                ),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  label,
                  style: AppFontStyle.statsValue,
                ),
              ),
            ],
          ),
        ),
      );
}
