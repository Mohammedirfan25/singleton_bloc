import 'singleton_state.dart';
import 'validation_error.dart';

/// Represents a Loading state in progress.
class SingletonLoadingState<T> extends SingletonState<T> {
  late String loadingStatus;
  double progress;

  SingletonLoadingState(T current,
      {required this.loadingStatus, this.progress = 0.0})
      : super(current, isLoading: true);
}

/// Represents a Loaded state.
class SingletonLoadedState<T> extends SingletonState<T> {
  SingletonLoadedState(T current) : super(current);
}

/// Represents a Processing/Submitting state.
class SingletonSubmittingState<T> extends SingletonState<T> {
  String submittingMessage;
  double progress;

  SingletonSubmittingState(T current,
      {required this.submittingMessage, this.progress = 0.0})
      : super(current, isSubmitting: true);
}

/// Represents a Success Processing state.
class SingletonSuccessState<T, Success> extends SingletonState<T> {
  Success? successResponse;

  SingletonSuccessState(T current, this.successResponse)
      : super(current, isSuccess: true);
}

/// Represents a Failure state with validation errors.
class SingletonFailureState<T> extends SingletonState<T> {
  /// Validation failure message
  String failureMessage;

  /// Individual field errors.
  List<ValidationError>? errors;

  SingletonFailureState(T current, this.failureMessage, {this.errors})
      : super(current, isFailure: true);
}
