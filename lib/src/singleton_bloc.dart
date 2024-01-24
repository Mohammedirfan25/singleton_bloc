import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:singleton_bloc/singleton_bloc.dart';
import 'package:singleton_bloc/src/singleton_events.dart';

/// Base class for all bloc items within the SingletonBloc architecture.
class SingletonBloc<T> extends Bloc<SingletonEvent, SingletonState<T>> {
  SingletonBloc(SingletonState<T> initialState) : super(initialState) {
    // Event handlers for various SingletonEvents
    on<SingletonGetNewStateEvent>((event, emit) => emit(_getNewState()));

    on<SingletonLoadingEvent>(
        (SingletonLoadingEvent event, emit) => emit(_loadingState(event)));

    on<SingletonLoadedEvent>((event, emit) => emit(_loadedState()));

    on<SingletonSuccessEvent>(
        (SingletonSuccessEvent event, emit) => emit(_successState(event)));

    on<SingletonFailureEvent>(
        (SingletonFailureEvent event, emit) => emit(_failureState(event)));
  }

  // Clean up and dispose of resources when the bloc is no longer needed.
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

  /// Emits a state change event based on the current state for UI refresh.
  void emitStateChanged() {
    add(SingletonGetNewStateEvent());
  }

  /// Emits a success state change, typically after a successful submit().
  void emitSuccessState<S>({S? response}) {
    add(SingletonSuccessEvent<S>(response));
  }

  /// Emits a failure state with errors, such as validation errors.
  void emitFailureState(String failureMessage,
      {List<ValidationError>? errors}) {
    add(SingletonFailureEvent(failureMessage, errors: errors));
  }

  /// Emits a loading state, indicating ongoing progress with optional progress and message.
  void emitLoadingState({double progress = 0.0, String message = "Loading"}) {
    add(SingletonLoadingEvent(loadingStatus: message, progress: progress));
  }

  /// Emits a completed/loaded state.
  void emitLoadedState() {
    add(SingletonLoadedEvent());
  }

  // Event handler functions

  SingletonState<T> _loadingState(SingletonLoadingEvent event) {
    return state.toLoadingState(
        loadingStatus: event.loadingStatus, progress: event.progress);
  }

  SingletonState<T> _loadedState() {
    return state.toLoadedState();
  }

  SingletonState<T> _successState(SingletonSuccessEvent event) {
    return state.toSuccessState(event.successResponse);
  }

  SingletonState<T> _failureState(SingletonFailureEvent event) {
    return state.toFailureState(event.failureMessage, event.errors);
  }
}
