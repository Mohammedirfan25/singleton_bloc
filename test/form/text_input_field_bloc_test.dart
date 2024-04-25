import 'package:flutter_test/flutter_test.dart';
import 'package:singleton_bloc/src/form/input_field_validators.dart';
import 'package:singleton_bloc/src/form/text_input_field_bloc.dart';

void main() {
  group('TextInputFieldBloc', () {
    test('setPasswordVisibility should toggle obSecure correctly', () {
      TextInputFieldState initialState =
          TextInputFieldState(value: 'password', fieldName: 'password');
      TextInputFieldBloc bloc = TextInputFieldBloc(initialState);

      bloc.setPasswordVisibility(true);

      expect(bloc.currentState.obSecure, true);

      bloc.setPasswordVisibility(false);

      expect(bloc.currentState.obSecure, false);
    });

    test('onValueChanged callback should be called when value changes', () {
      String? newValue;
      TextInputFieldState initialState =
          TextInputFieldState(value: 'initialValue', fieldName: 'field');
      TextInputFieldBloc bloc = TextInputFieldBloc(
        initialState,
        onValueChanged: (value) {
          newValue = value;
        },
      );

      bloc.setValue('newValue');

      expect(newValue, 'newValue');
    });

    test('validators should validate the input correctly', () {
      List<InputFieldValidator> validators = [
        InputFieldValidators.required("This field is required")
      ];
      TextInputFieldState initialState =
          TextInputFieldState(value: null, fieldName: 'field');
      TextInputFieldBloc bloc =
          TextInputFieldBloc(initialState, validators: validators);

      bloc.setValue('');
      bloc.validate();

      expect(bloc.currentState.error, 'This field is required');
    });

    test('clearError should set error to null', () {
      TextInputFieldState initialState =
          TextInputFieldState(value: 'initialValue', fieldName: 'field');
      TextInputFieldBloc bloc = TextInputFieldBloc(initialState);

      bloc.clearError();

      expect(bloc.currentState.error, null);
    });
  });
}
