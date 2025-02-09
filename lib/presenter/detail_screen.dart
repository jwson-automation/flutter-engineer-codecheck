import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/github_repository_model.dart';

/// GitHubリポジトリの詳細画面を表示するウィジェット
class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.searchResult,
  });

  /// 表示するGitHubリポジトリ情報
  final GitHubRepositoryModel searchResult;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              RepositoryHeader(
                avatarUrl: searchResult.ownerAvatarUrl,
                fullName: searchResult.fullName,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RepositoryStats(
                          stars: searchResult.stargazersCount,
                          forks: searchResult.forksCount,
                          watchers: searchResult.watchersCount,
                          issues: searchResult.openIssuesCount,
                        ),
                        const SizedBox(height: 24),
                        if (searchResult.language != null)
                          RepositoryLanguage(language: searchResult.language!),
                        const SizedBox(height: 16),
                        if (searchResult.description != null)
                          RepositoryDescription(
                              description: searchResult.description!),
                        const SizedBox(height: 16),
                        const RepositoryDates(
                          createdAt: 'March 15, 2023',
                          updatedAt: 'January 28, 2024',
                        ),
                        const SizedBox(height: 24),
                        const RepositoryLink(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

/// リポジトリヘッダーを表示するウィジェット（アバター、リポジトリ名、戻るボタンを含む）
class RepositoryHeader extends StatelessWidget {
  const RepositoryHeader({
    Key? key,
    required this.avatarUrl,
    required this.fullName,
  }) : super(key: key);

  /// リポジトリ所有者のアバターURL
  final String avatarUrl;

  /// リポジトリのフルネーム（所有者/リポジトリ名）
  final String fullName;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
              radius: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                fullName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      );
}

/// リポジトリの統計情報を表示するウィジェット（スター、フォーク、ウォッチャー、イシュー）
class RepositoryStats extends StatelessWidget {
  const RepositoryStats({
    super.key,
    required this.stars,
    required this.forks,
    required this.watchers,
    required this.issues,
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
          StatCard(
            icon: Icons.star,
            value: stars.toString(),
            label: 'Stars',
          ),
          StatCard(
            icon: Icons.fork_right,
            value: forks.toString(),
            label: 'Forks',
          ),
          StatCard(
            icon: Icons.remove_red_eye,
            value: watchers.toString(),
            label: 'Watchers',
          ),
          StatCard(
            icon: Icons.error_outline,
            value: issues.toString(),
            label: 'Issues',
          ),
        ],
      );
}

/// 統計情報カードを表示するウィジェット
class StatCard extends StatelessWidget {
  const StatCard({
    Key? key,
    required this.icon,
    required this.value,
    required this.label,
  }) : super(key: key);

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
              Icon(icon, size: 28),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
}

/// リポジトリで使用されているプログラミング言語を表示するウィジェット
class RepositoryLanguage extends StatelessWidget {
  const RepositoryLanguage({
    super.key,
    required this.language,
  });

  final String language;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Icon(Icons.circle, size: 12),
          const SizedBox(width: 8),
          Text(
            language,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
}

/// リポジトリの説明を表示するウィジェット
class RepositoryDescription extends StatelessWidget {
  const RepositoryDescription({
    Key? key,
    required this.description,
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) => Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium,
      );
}

/// リポジトリの作成日と最終更新日を表示するウィジェット
class RepositoryDates extends StatelessWidget {
  const RepositoryDates({
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

/// リポジトリリンクボタンを表示するウィジェット
class RepositoryLink extends StatelessWidget {
  const RepositoryLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.open_in_new),
          label: const Text('Go to Repository'),
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
