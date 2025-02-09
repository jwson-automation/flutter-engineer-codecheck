import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_dates.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_description.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_header.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_language.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_link.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_stats.dart';

/// GitHubリポジトリの詳細画面を表示するウィジェット
class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.searchResult,
  });

  /// 表示するGitHubリポジトリ情報
  final SearchResultModel searchResult;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              DetailRepositoryHeader(
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
                        DetailRepositoryStats(
                          stars: searchResult.stargazersCount,
                          forks: searchResult.forksCount,
                          watchers: searchResult.watchersCount,
                          issues: searchResult.openIssuesCount,
                        ),
                        const SizedBox(height: 24),
                        if (searchResult.language != null)
                          DetailRepositoryLanguage(
                              language: searchResult.language!),
                        const SizedBox(height: 16),
                        if (searchResult.description != null)
                          DetailRepositoryDescription(
                              description: searchResult.description!),
                        const SizedBox(height: 16),
                        const DetailRepositoryDates(
                          createdAt: 'March 15, 2023',
                          updatedAt: 'January 28, 2024',
                        ),
                        const SizedBox(height: 24),
                        const DetailRepositoryLink(),
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
