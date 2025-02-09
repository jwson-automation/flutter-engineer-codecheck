import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DetailRepositoryLanguage', () {
    testWidgets('プログラミング言語が正しく表示されること', (tester) async {
      const language = 'Dart';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DetailRepositoryLanguage(
              language: language,
            ),
          ),
        ),
      );

      expect(find.text(language), findsOneWidget);
    });
  });
}
