import 'package:flutter_test/flutter_test.dart';
import 'package:emad_task2/main.dart';

void main() {
  testWidgets('Test avvio app e stato iniziale', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('To-Do List'), findsOneWidget);
    expect(find.text('Attività completate: 0 su 0'), findsOneWidget);
    expect(find.text('Nessuna attività presente'), findsOneWidget);
  });
}
