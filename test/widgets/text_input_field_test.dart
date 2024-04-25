import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singleton_bloc/src/form/input_field_validators.dart';
import 'package:singleton_bloc/src/widgets/text_input_field.dart';
import 'package:singleton_bloc/src/form/text_input_field_bloc.dart';

void main() {
  group('TextInputField Widget', () {
    testWidgets('Initial state should be correct', (WidgetTester tester) async {
      TextInputFieldBloc bloc = TextInputFieldBloc(
          TextInputFieldState(value: 'initialValue', fieldName: 'field'));

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextInputField(bloc: bloc),
        ),
      ));

      expect(find.text('initialValue'), findsOneWidget);
      expect(find.text('Error message'), findsNothing);
    });

    testWidgets('Validation error should be displayed correctly',
        (WidgetTester tester) async {
      TextInputFieldBloc bloc = TextInputFieldBloc(
          TextInputFieldState(value: '', fieldName: 'field'),
          validators: [
            InputFieldValidators.required("This field is required")
          ]);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextInputField(bloc: bloc),
        ),
      ));

      await tester.enterText(find.byType(TextFormField), '');

      bloc.validate();

      await tester.pump();

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('Toggling obscure text should work correctly',
        (WidgetTester tester) async {
      TextInputFieldBloc bloc = TextInputFieldBloc(
          TextInputFieldState(value: 'password', fieldName: 'password'));

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextInputField(bloc: bloc, obscureText: true),
        ),
      ));

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      IconButton button = find
          .widgetWithIcon(IconButton, Icons.visibility_off)
          .evaluate()
          .first
          .widget as IconButton;
      button.onPressed!();
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('Entering text should update bloc value',
        (WidgetTester tester) async {
      TextInputFieldBloc bloc = TextInputFieldBloc(
          TextInputFieldState(value: '', fieldName: 'field'));

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextInputField(bloc: bloc),
        ),
      ));

      await tester.enterText(find.byType(TextFormField), 'test');

      expect(bloc.currentState.value, 'test');
    });
  });
}
