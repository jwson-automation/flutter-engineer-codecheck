import 'package:flutter_engineer_codecheck/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GitHub Repository Search App Tests', () {
    testWidgets('First Screen Rendering Test', (tester) async {
      // MaterialAppにラップされたウィジェットをテストします。
      await tester.pumpWidget(const RepositorySearchApp());
    });
  });
}
