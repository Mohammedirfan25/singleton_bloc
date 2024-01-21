// singleton_state.dart
import 'singleton_states.dart';
import 'validation_error.dart';

/// Represents the base state for the SingletonBloc.
class SingletonState<T> {
  late T current;
  late bool isSubmitting;
  late bool isLoading;
  late bool isFailure;
  late bool isSuccess;

  SingletonState(this.current,
      {this.isSubmitting = false,
      this.isLoading = false,
      this.isFailure = false,
      this.isSuccess = false});

  // Convert the current state to a LoadingState with optional progress and loading status.
  SingletonLoadingState<T> toLoadingState(
      {double progress = 0.0, required String loadingStatus}) {
    return SingletonLoadingState<T>(current,
        loadingStatus: loadingStatus, progress: progress);
  }

  // Convert the current state to a LoadedState.
  SingletonLoadedState<T> toLoadedState() {
    return SingletonLoadedState<T>(current);
  }

  // Convert the current state to a SuccessState with the given success response.
  SingletonSuccessState<T, SuccessResponse> toSuccessState<SuccessResponse>(
      SuccessResponse response) {
    return SingletonSuccessState<T, SuccessResponse>(current, response);
  }

  // Convert the current state to a FailureState with a failure message and optional validation errors.
  SingletonFailureState<T> toFailureState(
      String failureMessage, List<ValidationError>? errors) {
    return SingletonFailureState<T>(current, failureMessage, errors: errors);
  }
}
