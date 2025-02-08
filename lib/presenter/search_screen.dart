import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/custom_search_bar.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list.dart';

/// GitHubリポジトリの検索画面
///
/// ユーザーがGitHubリポジトリを検索し、結果を表示する画面です。
/// 検索バーと検索結果リストで構成されています。
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('GitHubリポジトリ検索'),
        ),
        body: const Column(
          children: [
            CustomSearchBar(),
            Expanded(
              child: SearchResultList(),
            ),
          ],
        ),
      );
}
