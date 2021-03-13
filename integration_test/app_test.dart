import 'package:VUTTR/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('VUTTR app', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('searches for nodejs and finds fastify tool card',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final inputFormField = find.byKey(const Key('SearchInputKey'));
      await tester.enterText(inputFormField, 'nodejs');
      await tester.pumpAndSettle();
      expect(find.text('fastify'), findsOneWidget);
    });

    testWidgets('searches only tags with nodejs', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final checkbox = find.byKey(const Key('Checkbox'));
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      final inputFormField = find.byKey(const Key('SearchInputKey'));
      await tester.enterText(inputFormField, 'nodejs');
      await tester.pumpAndSettle();
      expect(find.text('fastify'), findsNothing);
    });

    testWidgets('deletes tool successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final deleteButton = find.byKey(const Key('DeleteCardIcon')).first;
      await tester.tap(deleteButton);
      await tester.pumpAndSettle();
      final confirmDeleteButton = find.byKey(const Key('ConfirmDeleteButton'));
      await tester.tap(confirmDeleteButton);
      await tester.pumpAndSettle();
      expect(find.text('fastify'), findsOneWidget);
    });
  });
}
