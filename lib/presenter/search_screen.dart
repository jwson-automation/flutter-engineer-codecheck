import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/github_repository.dart';
import 'package:flutter_engineer_codecheck/data/github_repository_model.dart';
import 'package:flutter_engineer_codecheck/presenter/repository_list_item.dart';

/// GitHub Repository 検索画面
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // テキスト入力を管理するためのコントローラー
  final TextEditingController _searchTextController = TextEditingController();
  final GitHubRepository _repository = GitHubRepository();
  bool _isLoading = false;
  List<GitHubRepositoryModel> _searchResults = [];
  String? _error;

  @override
  void dispose() {
    // コントローラーの解放
    _searchTextController.dispose();
    super.dispose();
  }

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

  void _clearSearch() {
    setState(() {
      _searchTextController.text = '';
      _searchResults = [];
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Repository 検索'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchTextController,
                decoration: InputDecoration(
                  hintText: 'リポジトリを検索...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchTextController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSubmitted: (_) => _searchRepositories(),
                onChanged: (_) => setState(() {}),
              ),
            ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      );

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(_error!, style: const TextStyle(color: Colors.red)),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return const Center(
        child: Text('リポジトリを検索してください'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final repository = _searchResults[index];
        return RepositoryListItem(
          repository: repository,
          onTap: () {
            // TODO: リポジトリ詳細画面への遷移機能の実装
          },
        );
      },
    );
  }
}
