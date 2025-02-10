import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_header.dart';
import 'package:flutter_test/flutter_test.dart';
import '../shared/github_repository_fixtures.dart';
import '../shared/test_widget.dart';

void main() {
  group('DetailRepositoryHeader', () {
    testWidgets('アバターとリポジトリ名が正常に表示されること', (tester) async {
      const testData = GitHubRepositoryFixtures.testRepositoryJson;
      final avatarUrl = testData['owner']['avatar_url'] as String;
      final fullName = testData['full_name'] as String;

      await tester.pumpWidget(
        buildTestApp(
          DetailRepositoryHeader(
            avatarUrl: avatarUrl,
            fullName: fullName,
          ),
        ),
      );

      expect(find.text(fullName), findsOneWidget);
      expect(find.byType(DetailRepositoryAvatar), findsOneWidget);
    });

    testWidgets('無効な画像URLが与えられた場合でもウィジェットが正常に表示されること', (tester) async {
      const invalidAvatarUrl = 'https://invalid-url.com/invalid.png';
      final fullName =
          GitHubRepositoryFixtures.testRepositoryJson['full_name'] as String;

      await tester.pumpWidget(
        buildTestApp(
          DetailRepositoryHeader(
            avatarUrl: invalidAvatarUrl,
            fullName: fullName,
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 1));

      expect(find.text(fullName), findsOneWidget);
      expect(find.byType(DetailRepositoryAvatar), findsOneWidget);
    });
  });
}
