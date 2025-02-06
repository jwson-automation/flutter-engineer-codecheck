import 'package:flutter_engineer_codecheck/main.dart';
import 'package:flutter_engineer_codecheck/presenter/search_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GitHub Repository Search App Tests', () {
    testWidgets('First Screen Rendering Test', (tester) async {
      // MaterialAppにラップされたウィジェットをテストします。
      await tester.pumpWidget(const RepositorySearchApp());

      // Verify that the SearchScreen is displayed
      expect(find.byType(SearchScreen), findsOneWidget);
    });
  });
}
