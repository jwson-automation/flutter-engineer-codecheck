import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/detail_repository_header.dart';
import 'package:flutter_test/flutter_test.dart';
import '../fixtures/github_repository_fixtures.dart';

void main() {
  group('DetailRepositoryHeader', () {
    testWidgets('アバターとリポジトリ名が正常に表示されること', (tester) async {
      final testData = GitHubRepositoryFixtures.testRepositoryJson;
      final avatarUrl = testData['owner']['avatar_url'] as String;
      final fullName = testData['full_name'] as String;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DetailRepositoryHeader(
              avatarUrl: avatarUrl,
              fullName: fullName,
            ),
          ),
        ),
      );

      expect(find.text(fullName), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
    });

    testWidgets('無効な画像URLが与えられた場合でもウィジェットが正常に表示されること', (tester) async {
      const invalidAvatarUrl = 'https://invalid-url.com/invalid.png';
      final fullName = GitHubRepositoryFixtures.testRepositoryJson['full_name'] as String;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DetailRepositoryHeader(
              avatarUrl: invalidAvatarUrl,
              fullName: fullName,
            ),
          ),
        ),
      );

      // 이미지 로딩 에러 발생 시 CircleAvatar의 fallback이 표시되는지 확인
      await tester.pumpAndSettle(); // 이미지 로딩 실패를 기다림
      
      expect(find.text(fullName), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
    });
  });
} 