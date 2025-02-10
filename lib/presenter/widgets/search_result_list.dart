import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:flutter_engineer_codecheck/presenter/detail_screen.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/search_result_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list_item.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索結果リストウィジェット
class SearchResultList extends ConsumerStatefulWidget {
  /// 検索結果のリポジトリリストを表示します。
  /// ローディング状態、エラー状態、空の結果状態を適切に処理します。
  const SearchResultList({super.key});

  @override
  ConsumerState<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends ConsumerState<SearchResultList> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });

      // TODO: 追加データの読み込みロジックを実装する
      await Future.delayed(const Duration(seconds: 1)); // 一時的な遅延

      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _handleRepositoryTap(
    BuildContext context,
    SearchResultModel searchResult,
  ) {
    // リポジトリ詳細画面に遷移
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => DetailScreen(searchResult: searchResult),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchResult = ref.watch(searchResultProvider);

    if (searchResult.isLoading) {
      return Image.asset(
        'assets/yumemi_logo.gif',
        width: 300,
        height: 300,
      );
    }

    if (searchResult.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: context.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                searchResult.error!,
                style: AppFontStyle.errorMessage,
              ),
            ],
          ),
        ),
      );
    }

    if (searchResult.searchResults.isEmpty) {
      return Center(
        child: Text(
          context.localizations.noResults,
          style: AppFontStyle.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      itemCount: searchResult.searchResults.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == searchResult.searchResults.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final selectedRepo = searchResult.searchResults[index];
        return SearchResultListItem(
          searchResult: selectedRepo,
          onTap: () => _handleRepositoryTap(context, selectedRepo),
        );
      },
    );
  }
}
