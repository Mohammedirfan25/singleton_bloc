import 'package:singleton_bloc/singleton_bloc.dart';

import 'form_field_base.dart';

/// Base class for all Cubit items that has a form/submit method
class SingletonFormCubit<T> extends SingletonCubit<T> {
  SingletonFormCubit(SingletonState<T> initialState) : super(initialState);

  /// Individual blocs inside this form. Each bloc may represent/correspond to an individual UI elment
  List<SingletonFormFieldBase> blocs = [];

  /// Validates the bloc and returns the errors
  /// This can be customiezd by derived classes if required
  Future<List<ValidationError>> validate() async {
    List<ValidationError> errors = [];
    for (int i = 0; i < blocs.length; ++i) {
      var bloc = blocs[i];
      //Clear the validation error first
      bloc.clearError();
      //Validate each bloc..

      if (!bloc.validate()) {
        //There is a validation failure in one bloc..
        //so set the errir
        //Add the error to the errors list..

        errors.add(ValidationError(
            error: bloc.currentState.error as String,
            fieldName: bloc.currentState.fieldName));
      }
    }

    return errors;
  }

  @override
  void dispose() {
    for (SingletonFormFieldBase<dynamic, SingletonFormFieldState<dynamic>> b
        in blocs) {
      b.close();
    }
    super.dispose();
  }
}
