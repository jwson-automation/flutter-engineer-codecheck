import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_dates.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import '../shared/test_widget.dart';

void main() {
  group('DetailRepositoryDates', () {
    testWidgets('作成日と更新日が正しく表示されること', (tester) async {
      const createdAt = '2023-03-15T00:00:00Z';
      const updatedAt = '2024-01-28T00:00:00Z';

      await tester.pumpWidget(
        buildTestApp(
          const DetailRepositoryDates(
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
        ),
      );

      await tester.pumpAndSettle();
      final context = tester.element(find.byType(DetailRepositoryDates));
      final dateFormat = DateFormat(context.localizations.dateFormat);

      final createdDate = dateFormat.format(DateTime.parse(createdAt));
      final updatedDate = dateFormat.format(DateTime.parse(updatedAt));

      expect(
        find.text(context.localizations.createdDate(createdDate)),
        findsOneWidget,
      );
      expect(
        find.text(context.localizations.updatedDate(updatedDate)),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.byIcon(Icons.update), findsOneWidget);
    });

    testWidgets('無効な日付形式が与えられた場合、デフォルト値が表示されること', (tester) async {
      const invalidDate = 'invalid-date';

      await tester.pumpWidget(
        buildTestApp(
          const DetailRepositoryDates(
            createdAt: invalidDate,
            updatedAt: invalidDate,
          ),
        ),
      );

      await tester.pumpAndSettle();
      final context = tester.element(find.byType(DetailRepositoryDates));

      expect(
        find.text(context.localizations
            .createdDate(context.localizations.invalidDate)),
        findsOneWidget,
      );
      expect(
        find.text(context.localizations
            .updatedDate(context.localizations.invalidDate)),
        findsOneWidget,
      );
    });
  });
}
