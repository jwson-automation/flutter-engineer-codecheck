import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/presenter/search_screen.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/custom_search_bar.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// テストを実行するためのエントリーポイント
void main() {
  FlutterConfig.loadValueForTesting({
    'GITHUB_API_TOKEN': 'test_token',
  });

  group('SearchScreen Widget Tests', () {
    testWidgets('SearchScreen renders correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SearchScreen(),
          ),
        ),
      );

      // AppBarが正しくレンダリングされているか確認
      expect(find.text('GitHubリポジトリ検索'), findsOneWidget);

      // CustomSearchBarが存在するか確認
      expect(find.byType(CustomSearchBar), findsOneWidget);

      // SearchResultListが存在するか確認
      expect(find.byType(SearchResultList), findsOneWidget);
    });

    testWidgets('SearchScreen layout structure is correct', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SearchScreen(),
          ),
        ),
      );

      // Scaffoldが存在するか確認
      expect(find.byType(Scaffold), findsOneWidget);

      // Columnが存在するか確認
      expect(find.byType(Column), findsOneWidget);

      // ExpandedウィジェットがSearchResultListを囲んでいるか確認
      final expandedFinder = find.ancestor(
        of: find.byType(SearchResultList),
        matching: find.byType(Expanded),
      );
      expect(expandedFinder, findsOneWidget);
    });
  });
}
