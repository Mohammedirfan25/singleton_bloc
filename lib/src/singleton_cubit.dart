import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../singleton_bloc.dart';

/// Base class for all cubit items
/// All the classes will inherit from this
class SingletonCubit<T> extends Cubit<SingletonState<T>> {
  SingletonCubit(SingletonState<T> initialState) : super(initialState);

  //Handle all the cleaning/disposing functionalities
  @mustCallSuper
  void dispose() {
    close();
  }

  T get currentState => state.current;

  /// Gets a new state based on the current state
  /// When we emit() state, it will not trigger emit() if the object is same
  /// So wrap the object into singleton state object and crete a new object
  /// of the state everytime so that it gets emitted
  @protected
  SingletonState<T> _getNewState() {
    //Gets a new state

    if (state is SingletonLoadingState) {
      return SingletonLoadingState(currentState,
          loadingStatus: (state as SingletonLoadingState).loadingStatus);
    } else if (state is SingletonLoadedState) {
      return SingletonLoadedState(currentState);
    } else if (state is SingletonFailureState) {
      var errState = state as SingletonFailureState;
      return SingletonFailureState(currentState, errState.failureMessage,
          errors: errState.errors);
    } else {
      //Normal State
      return SingletonState(currentState);
    }
  }

  /// Emits a state change event based on the current state for the UI to refresh
  void emitStateChanged() {
    emit(_getNewState());
  }

  /// Emits a success state change. Typically this is a succes state on submit()
  void emitSuccessState<S>({S? response}) {
    emit(state.toSuccessState(response));
  }

  /// Emits a failure state with errors. For ex:- Validation error
  void emitFailureState(String failureMessage,
      {List<ValidationError>? errors}) {
    emit(state.toFailureState(failureMessage, errors));
  }

  /// Indicates a Loading state. Use this to show progress if any
  void emitLoadingState({double progress = 0.0, String message = "Loading"}) {
    emit(state.toLoadingState(loadingStatus: message, progress: progress));
  }

  /// Emits a completed/loaded state
  void emitLoadedState() {
    emit(state.toLoadedState());
  }
}
