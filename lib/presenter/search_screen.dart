import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/theme_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/custom_search_bar.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list.dart';
import 'package:flutter_engineer_codecheck/shared/app_font_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// GitHubリポジトリの検索画面
///
/// ユーザーがGitHubリポジトリを検索し、結果を表示する画面です。
/// 検索バーと検索結果リストで構成されています。
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: SearchScreenAppBar(),
        body: Column(
          children: [
            CustomSearchBar(),
            Expanded(
              child: SearchResultList(),
            ),
          ],
        ),
      );
}

/// 検索画面のAppBarウィジェット
class SearchScreenAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SearchScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeModeNotifier = ref.watch(themeProvider.notifier);

    return AppBar(
      title: Text(
        'GitHubリポジトリ検索',
        style: AppFontStyle.appBarText,
      ),
      actions: [
        IconButton(
          icon: Icon(
            themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: themeModeNotifier.toggleTheme,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
