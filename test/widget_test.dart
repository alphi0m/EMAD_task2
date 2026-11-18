import 'package:flutter_test/flutter_test.dart';
import 'package:emad_task2/main.dart';

void main() {
  testWidgets('Test avvio app e stato iniziale vuoto', (WidgetTester tester) async {
    // Avvia l'applicazione
    await tester.pumpWidget(const TodoApp());

    // Verifica la presenza dell'AppBar con il titolo
    expect(find.text('To-Do List'), findsOneWidget);

    // Verifica il contatore iniziale (0 su 0 completate)
    expect(find.text('0 su 0 completate'), findsOneWidget);

    // Verifica lo stato vuoto (Scenario S2 - Variante nessuna attività)
    expect(find.text('Nessuna attività presente'), findsOneWidget);
  });
}
