import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_link.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/test_widget.dart';

void main() {
  group('DetailRepositoryLink', () {
    testWidgets('URLが存在する場合のみボタンが表示される', (tester) async {
      // URLが存在する場合
      await tester.pumpWidget(
        buildTestApp(
          const DetailRepositoryLink(
            repositoryUrl: 'https://github.com/test/repository',
          ),
        ),
      );

      final context = tester.element(find.byType(DetailRepositoryLink));
      expect(find.byIcon(Icons.open_in_new), findsOneWidget);
      expect(find.text(context.localizations.goToRepository), findsOneWidget);
    });
  });
}
