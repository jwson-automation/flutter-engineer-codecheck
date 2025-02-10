import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/presenter/widgets/custom_search_bar.dart';
import 'package:flutter_engineer_codecheck/shared/build_context_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import '../shared/test_widget.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'GITHUB_API_TOKEN': 'test_token',
  });

  group('CustomSearchBar Widget Tests', () {
    testWidgets('CustomSearchBar renders correctly', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const CustomSearchBar(),
        ),
      );

      // TextFieldが存在するか確認
      expect(find.byType(TextField), findsOneWidget);

      // 検索アイコンが存在するか確認
      expect(find.byIcon(Icons.search), findsOneWidget);

      // ヒントテキストが正しいか確認
      final context = tester.element(find.byType(CustomSearchBar));
      expect(find.text(context.localizations.searchBarHint), findsOneWidget);
    });

    testWidgets('Clear button appears when text is entered', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const CustomSearchBar(),
        ),
      );

      // 初期状態ではクリアボタンが表示されていないことを確認
      expect(find.byIcon(Icons.clear), findsNothing);

      // テキストを入力
      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.pump();

      // テキスト入力後、クリアボタンが表示されることを確認
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('Clear button clears text', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const CustomSearchBar(),
        ),
      );

      // テキストを入力
      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.pump();

      // クリアボタンをタップ
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      // TextFieldが空になっていることを確認
      expect(find.text('flutter'), findsNothing);
    });

    testWidgets('Search is triggered on submit', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const CustomSearchBar(),
        ),
      );

      // テキストを入力して送信
      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
    });
  });
}
