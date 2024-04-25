import 'package:flutter/foundation.dart';
import 'package:singleton_bloc/singleton_bloc.dart';

/// Validator function. Takes an input and returns a String if that is invalid.
/// Returns NULL if no error.
typedef InputFieldValidator<T> = String? Function(T? value);

/// Value changed handler.
typedef ValueChangedHandler<T> = void Function(T? value);

/// Base class for all Input/Form field states.
class SingletonFormFieldState<T> {
  /// Value of the form field.
  T? value;

  /// Validation Error of the field. NULL indicates no validation error.
  /// Currently one validation error is supported for one field.
  /// This can be customized to an array in the future.
  String? error;

  String fieldName;

  SingletonFormFieldState({this.value, this.error, required this.fieldName});

  bool get isValid => (error == null);
}

/// Base Bloc class for a Form Field.
/// Since this is a Bloc class, this can be used to trigger emit when the value of the field changes.
/// All the form field classes will inherit from this.
/// valueType -> Type of the value that the field stores.
abstract class SingletonFormFieldBase<ValueType,
        StateType extends SingletonFormFieldState<ValueType>>
    extends SingletonCubit<StateType> {
  SingletonFormFieldBase(StateType initialState,
      {this.validators = const [], this.onValueChanged})
      : super(SingletonState(initialState));

  /// Sets a value for the field and emits() state.
  void setValue(ValueType? value, {bool emitStateChange = true}) {
    currentState.error = null;
    currentState.value = value;

    // Invoke the onValueChanged handler if provided.
    onValueChanged?.call(currentState.value);

    // Emit the state change if required.
    if (emitStateChange) {
      emitStateChanged();
    }
  }

  /// Emits the current state as a new object.
  @protected
  void emitCurrentState() {
    emit(SingletonState(currentState,
        isSubmitting: state.isSubmitting,
        isFailure: state.isFailure,
        isLoading: state.isLoading,
        isSuccess: state.isSuccess));
  }

  /// List of validators if any.
  List<InputFieldValidator<ValueType>> validators = [];

  /// Sets the error and emits the state for the UI to refresh.
  void setError(String error) {
    currentState.error = error;
    emitCurrentState();
  }

  /// Value Changed handler.
  ValueChangedHandler<ValueType>? onValueChanged;

  /// Clears the validation error.
  void clearError() {
    currentState.error = null;
    emitCurrentState();
  }

  /// Validates the Bloc by calling Validate() of each bloc inside this form.
  bool validate() {
    // Call each validator and set the validation errors.
    // Clear the error.
    currentState.error = null;

    for (var val in validators) {
      var error = val(currentState.value);

      if (error != null) {
        // There is a validation error.
        setError(error);
        return false;
      }
    }
    // No errors.
    return true;
  }
}
