import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/github_repository.dart';
import 'package:flutter_engineer_codecheck/data/github_repository_model.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/custom_search_bar.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list.dart';

/// GitHubリポジトリの検索画面
///
/// ユーザーがGitHubリポジトリを検索し、結果を表示する画面です。
/// 検索バーと検索結果リストで構成されています。
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  /// 検索テキストを管理するコントローラー
  final TextEditingController _searchTextController = TextEditingController();

  /// GitHubリポジトリのAPI操作を行うインスタンス
  final GitHubRepository _repository = GitHubRepository();

  /// ローディング状態を管理するフラグ
  bool _isLoading = false;

  /// 検索結果のリポジトリリスト
  List<GitHubRepositoryModel> _searchResults = [];

  /// エラーメッセージを保持する変数
  String? _error;

  @override
  void dispose() {
    // テキストコントローラーの解放
    _searchTextController.dispose();
    super.dispose();
  }

  /// リポジトリを検索する非同期メソッド
  Future<void> _searchRepositories() async {
    if (_searchTextController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await _repository.searchRepositories(
        searchText: _searchTextController.text.trim(),
        sort: 'stars',
        order: 'desc',
      );
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  /// 検索をクリアするメソッド
  void _clearSearch() {
    setState(() {
      _searchTextController.text = '';
      _searchResults = [];
      _error = null;
    });
  }

  /// リポジトリがタップされた時の処理
  void _handleRepositoryTap(GitHubRepositoryModel repository) {
    // TODO: リポジトリ詳細画面への遷移機能の実装
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('GitHubリポジトリ検索'),
        ),
        body: Column(
          children: [
            CustomSearchBar(
              controller: _searchTextController,
              onSearch: _searchRepositories,
              onClear: _clearSearch,
            ),
            Expanded(
              child: SearchResultList(
                isLoading: _isLoading,
                error: _error,
                searchResults: _searchResults,
                onRepositoryTap: _handleRepositoryTap,
              ),
            ),
          ],
        ),
      );
}
