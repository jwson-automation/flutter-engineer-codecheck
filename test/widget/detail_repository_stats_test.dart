import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_stats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DetailRepositoryStats', () {
    testWidgets('すべての統計情報が正しく表示されること', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DetailRepositoryStats(
              stars: 1000,
              watchers: 100,
              forks: 500,
              issues: 50,
            ),
          ),
        ),
      );

      expect(find.text('1000'), findsOneWidget); // stars
      expect(find.text('500'), findsOneWidget); // forks
      expect(find.text('100'), findsOneWidget); // watchers
      expect(find.text('50'), findsOneWidget); // issues
    });

    testWidgets('0の値も正しく表示されること', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DetailRepositoryStats(
              stars: 0,
              watchers: 0,
              forks: 0,
              issues: 0,
            ),
          ),
        ),
      );

      expect(find.text('0'), findsNWidgets(4));
    });
  });
}
