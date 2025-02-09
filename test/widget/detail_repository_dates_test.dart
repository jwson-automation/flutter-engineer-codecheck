import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_dates.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DetailRepositoryDates', () {
    testWidgets('作成日と更新日が正しく表示されること', (tester) async {
      const createdAt = '2023-03-15T00:00:00Z';
      const updatedAt = '2024-01-28T00:00:00Z';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DetailRepositoryDates(
              createdAt: createdAt,
              updatedAt: updatedAt,
            ),
          ),
        ),
      );

      expect(find.text('Created: 2023年 03月 15日'), findsOneWidget);
      expect(find.text('Updated: 2024年 01月 28日'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.byIcon(Icons.update), findsOneWidget);
    });

    testWidgets('無効な日付形式が与えられた場合、デフォルト値が表示されること', (tester) async {
      const invalidDate = 'invalid-date';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DetailRepositoryDates(
              createdAt: invalidDate,
              updatedAt: invalidDate,
            ),
          ),
        ),
      );

      expect(find.text('Created: ----年 --月 --日'), findsOneWidget);
      expect(find.text('Updated: ----年 --月 --日'), findsOneWidget);
    });
  });
}
