import 'form_field_base.dart';

/// State of a Text Field
class TextInputFieldState extends SingletonFormFieldState<String?> {
  bool obSecure = false;

  TextInputFieldState({String? value, String? error, required String fieldName})
      : super(value: value, error: error, fieldName: fieldName);
}

/// Bloc for handling a text field
class TextInputFieldBloc
    extends SingletonFormFieldBase<String?, TextInputFieldState> {
  TextInputFieldBloc(TextInputFieldState state,
      {ValueChangedHandler<String?>? onValueChanged,
      List<InputFieldValidator<String?>> validators = const []})
      : super(state, validators: validators, onValueChanged: onValueChanged);

  void setPasswordVisibility(bool visibility) {
    currentState.obSecure = visibility;
    emitStateChanged();
  }
}
