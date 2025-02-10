import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/github_repository_fixtures.dart';

void main() {
  group('DetailScreen', () {
    testWidgets('すべての情報がある場合、すべてのウィジェットが表示されること', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ja'),
            Locale('ko'),
          ],
          home: DetailScreen(
            searchResult: GitHubRepositoryFixtures.testRepositoryModel,
          ),
        ),
      );

      expect(find.text('flutter/flutter'), findsOneWidget);
      expect(find.text('Dart'), findsOneWidget);
      expect(
        find.text('Flutter makes it easy and fast to build beautiful apps'),
        findsOneWidget,
      );
      expect(find.text('1000'), findsOneWidget); // stars
      expect(find.text('500'), findsOneWidget); // forks
      expect(find.text('100'), findsOneWidget); // watchers
      expect(find.text('50'), findsOneWidget); // issues
    });

    testWidgets('オプションフィールドがない場合でも正常に表示されること', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ja'),
            Locale('ko'),
          ],
          home: DetailScreen(
            searchResult:
                GitHubRepositoryFixtures.testRepositoryModelWithMissingFields,
          ),
        ),
      );

      expect(find.text('flutter/flutter'), findsOneWidget);
      expect(find.text('Dart'), findsNothing);
      expect(
        find.text('Flutter makes it easy and fast to build beautiful apps'),
        findsNothing,
      );
      expect(find.text('1000'), findsOneWidget);
      expect(find.text('500'), findsOneWidget);
      expect(find.text('100'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
    });
  });
}
