import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_description.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DetailRepositoryDescription', () {
    testWidgets('説明が正しく表示されること', (tester) async {
      const description =
          'Flutter makes it easy and fast to build beautiful apps';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DetailRepositoryDescription(
              description: description,
            ),
          ),
        ),
      );

      expect(find.text(description), findsOneWidget);
    });

    testWidgets('長い説明も正しく表示されること', (tester) async {
      final longDescription = 'A' * 300; // 300文字の長い説明

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DetailRepositoryDescription(
              description: longDescription,
            ),
          ),
        ),
      );

      expect(find.text(longDescription), findsOneWidget);
    });
  });
}
