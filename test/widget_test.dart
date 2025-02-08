import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/main.dart';
import 'package:flutter_engineer_codecheck/presenter/search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    // FlutterConfigの初期化
    FlutterConfig.loadValueForTesting({
      'GITHUB_API_TOKEN': 'test_token',
    });
  });

  group('GitHub Repository Search App Tests', () {
    testWidgets('First Screen Rendering Test', (tester) async {
      // MaterialAppでラップされたウィジェットをテストします
      await tester
          .pumpWidget(const ProviderScope(child: RepositorySearchApp()));
      await tester.pumpAndSettle();

      // SearchScreenが表示されていることを確認します
      expect(find.byType(SearchScreen), findsOneWidget);
    });
  });
}
