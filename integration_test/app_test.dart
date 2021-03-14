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

    testWidgets('add tool successfully', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final addToolButton = find.byKey(const Key('AddToolButton'));
      await tester.tap(addToolButton);
      await tester.pumpAndSettle();
      final nameField = find.byKey(const Key('NameField'));
      await tester.enterText(nameField, 'Tool Number X');
      await tester.pumpAndSettle();
      final linkField = find.byKey(const Key('LinkField'));
      await tester.enterText(linkField, 'http://www.toolx.com');
      await tester.pumpAndSettle();
      final descriptionField = find.byKey(const Key('DescriptionField'));
      await tester.enterText(
          descriptionField, 'Best X Tool of the market, does a lotta stuff');
      await tester.pumpAndSettle();
      final tagsField = find.byKey(const Key('TagsField'));
      await tester.enterText(tagsField, 'Tool Super Cool Fun Stuff');
      await tester.pumpAndSettle();
      final adAddToolConfirmButtonTool =
          find.byKey(const Key('AddToolConfirmButton'));
      await tester.tap(adAddToolConfirmButtonTool);
      await tester.pumpAndSettle();
      expect(find.text('Tool Number X'), findsOneWidget);
      expect(find.text('Best X Tool of the market, does a lotta stuff'),
          findsOneWidget);
    });
  });
}
