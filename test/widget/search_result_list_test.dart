import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/search_result_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/search_result_list.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../shared/test_widget.dart';

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
          child: buildTestApp(
            const SearchResultList(),
          ),
        ),
      );

      // ローディング GIF イメージが表示されているか確認
      final image = find.byType(Image);
      expect(image, findsOneWidget);

      // イメージウィジェットの属性を確認
      final Image imageWidget = tester.widget<Image>(image);
      expect((imageWidget.image as AssetImage).assetName,
          'assets/yumemi_logo.gif');

      // コンテナの破棄
      addTearDown(container.dispose);
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
          child: buildTestApp(
            const SearchResultList(),
          ),
        ),
      );

      // エラーメッセージとアイコンが表示されているか確認
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
          child: buildTestApp(
            const SearchResultList(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(SearchResultList));
      // 検索結果が無いメッセージが表示されているか確認
      expect(find.text(context.localizations.noResults), findsOneWidget);
    });

    testWidgets('Shows list of repositories when results exist',
        (tester) async {
      // テスト用リポジトリデータを作成
      final repositories = [
        SearchResultModel(
          fullName: 'flutter/flutter',
          ownerAvatarUrl:
              'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
          description: 'Flutter framework',
          language: 'Dart',
          stargazersCount: 1000,
          watchersCount: 100,
          forksCount: 500,
          openIssuesCount: 50,
          createdAt: '2023-03-15T00:00:00Z',
          updatedAt: '2024-01-28T00:00:00Z',
        ),
        SearchResultModel(
          fullName: 'dart-lang/dart-sdk',
          ownerAvatarUrl:
              'https://miro.medium.com/v2/resize:fit:1400/1*wqkdAO5lgsF9_ubaNbmttA.png',
          description: 'Dart SDK',
          language: 'Dart',
          stargazersCount: 800,
          watchersCount: 80,
          forksCount: 400,
          openIssuesCount: 40,
          createdAt: '2023-01-01T00:00:00Z',
          updatedAt: '2024-02-01T00:00:00Z',
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
          child: buildTestApp(
            const SearchResultList(),
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
