import 'package:flutter_test/flutter_test.dart';
import 'package:app3/main.dart';

void main() {
  testWidgets('PracticalHubApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PracticalHubApp());
    expect(find.text('Flutter Practicals Collection'), findsOneWidget);
  });
}
