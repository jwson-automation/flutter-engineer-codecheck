import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/search_result_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/search_text_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// カスタム検索バーウィジェット
class CustomSearchBar extends ConsumerWidget {
  /// リポジトリ検索用のテキスト入力フィールドを提供します。
  /// 検索アイコン、クリアボタン、検索実行機能を含みます。
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchTextProvider);
    final searchTextNotifier = ref.read(searchTextProvider.notifier);

    final searchResultNotifier = ref.read(searchResultProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: TextEditingController(text: searchText)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: searchText.length),
          ),
        decoration: InputDecoration(
          hintText: 'リポジトリを検索...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchText.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchTextNotifier.state = '';
                    searchResultNotifier.clearResults();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onSubmitted: (value) {
          if (value.trim().isNotEmpty) {
            searchResultNotifier.search(value.trim(), context);
          }
        },
        onChanged: (value) {
          searchTextNotifier.state = value;
        },
      ),
    );
  }
}
