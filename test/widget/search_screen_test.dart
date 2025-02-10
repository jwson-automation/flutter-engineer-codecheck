import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/presenter/search_screen.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/custom_search_bar.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// テストを実行するためのエントリーポイント
void main() {
  FlutterConfig.loadValueForTesting({
    'GITHUB_API_TOKEN': 'test_token',
  });

  group('SearchScreen Widget Tests', () {
    Widget createWidgetUnderTest() {
      return const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ko'),
            Locale('en'),
            Locale('ja'),
          ],
          home: SearchScreen(),
        ),
      );
    }

    testWidgets('SearchScreen renders correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // AppBarのタイトルが正しくレンダリングされているか確認
      final context = tester.element(find.byType(SearchScreen));
      expect(find.text(context.localizations.appTitle), findsOneWidget);

      // CustomSearchBarが存在するか確認
      expect(find.byType(CustomSearchBar), findsOneWidget);

      // SearchResultListが存在するか確認
      expect(find.byType(SearchResultList), findsOneWidget);
    });

    testWidgets('SearchScreen layout structure is correct', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

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
