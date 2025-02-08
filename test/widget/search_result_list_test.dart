import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/github_repository_model.dart';
import 'package:flutter_engineer_codecheck/presenter/search_result_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'GITHUB_API_TOKEN': 'test_token',
  });

  group('SearchResultList Widget Tests', () {
    testWidgets('Shows loading indicator when loading', (tester) async {
      // ローディング状態のためのProviderコンテナを設定
      final container = ProviderContainer(
        overrides: [
          searchResultProvider.overrideWith(
            (ref) => SearchNotifier()..state = SearchState(isLoading: true),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(
              body: SearchResultList(),
            ),
          ),
        ),
      );

      // ローディングインジケーターが表示されているか確認
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows error message when error occurs', (tester) async {
      // エラー状態のためのProviderコンテナを設定
      final container = ProviderContainer(
        overrides: [
          searchResultProvider.overrideWith(
            (ref) => SearchNotifier()..state = SearchState(error: 'エラーが発生しました'),
          ),
        ],
      );

      // コンテナの破棄を追加
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(
              body: SearchResultList(),
            ),
          ),
        ),
      );

      // エラーメッセージとアイコンが表示されているか確認
      expect(find.text('エラーが発生しました'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('Shows empty message when no results', (tester) async {
      // 空の結果状態のためのProviderコンテナを設定
      final container = ProviderContainer(
        overrides: [
          searchResultProvider.overrideWith(
            (ref) => SearchNotifier()..state = SearchState(),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(
              body: SearchResultList(),
            ),
          ),
        ),
      );

      // 検索結果が無いメッセージが表示されているか確認
      expect(find.text('検索結果がありません'), findsOneWidget);
    });

    testWidgets('Shows list of repositories when results exist',
        (tester) async {
      // テスト用リポジトリデータを作成
      final repositories = [
        GitHubRepositoryModel(
          fullName: 'flutter/flutter',
          ownerAvatarUrl:
              'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
          description: 'Flutter framework',
          language: 'Dart',
          stargazersCount: 1000,
          watchersCount: 100,
          forksCount: 500,
          openIssuesCount: 50,
        ),
        GitHubRepositoryModel(
          fullName: 'dart-lang/dart-sdk',
          ownerAvatarUrl:
              'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
          description: 'Dart SDK',
          language: 'Dart',
          stargazersCount: 800,
          watchersCount: 80,
          forksCount: 400,
          openIssuesCount: 40,
        ),
      ];

      // 検索結果がある状態のためのProviderコンテナを設定
      final container = ProviderContainer(
        overrides: [
          searchResultProvider.overrideWith(
            (ref) => SearchNotifier()
              ..state = SearchState(searchResults: repositories),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(
              body: SearchResultList(),
            ),
          ),
        ),
      );

      // リポジトリ項目が表示されているか確認
      expect(find.text('flutter/flutter'), findsOneWidget);
      expect(find.text('dart-lang/dart-sdk'), findsOneWidget);
      expect(find.text('Flutter framework'), findsOneWidget);
      expect(find.text('Dart SDK'), findsOneWidget);

      // スター、フォークアイコンが表示されているか確認
      expect(find.byIcon(Icons.star_border), findsNWidgets(2));
      expect(find.byIcon(Icons.fork_right), findsNWidgets(2));

      // 数字が表示されているか確認
      expect(find.text('1000'), findsOneWidget);
      expect(find.text('500'), findsOneWidget);

      // リストタイルが2つ表示されているか確認
      expect(find.byType(ListTile), findsNWidgets(2));
    });
  });
}
