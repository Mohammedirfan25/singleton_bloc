import '../singleton_bloc.dart';

/// Represents the base class for all events in the SingletonBloc.
sealed class SingletonEvent {}

/// Event to request a new state in the SingletonBloc.
final class SingletonGetNewStateEvent extends SingletonEvent {}

/// Event indicating the start of a loading process.
final class SingletonLoadingEvent extends SingletonEvent {
  /* The loading status message that is required */
  String loadingStatus;

  double progress;

  SingletonLoadingEvent({required this.loadingStatus, this.progress = 0.0});
}

/// Event indicating that the loading process has completed.
final class SingletonLoadedEvent extends SingletonEvent {}

/// Event indicating the submission of data to the SingletonBloc.
final class SingletonSubmitEvent extends SingletonEvent {
  String submittingMessage;

  double progress;

  SingletonSubmitEvent({required this.submittingMessage, this.progress = 0.0});
}

/// Event indicating a successful processing state with a generic success response.
final class SingletonSuccessEvent<Success> extends SingletonEvent {
  Success? successResponse;

  SingletonSuccessEvent(this.successResponse);
}

/// Event indicating a failure state with a validation failure message and optional field errors.
final class SingletonFailureEvent extends SingletonEvent {
  /// Validation failure message
  String failureMessage;

  /// Individual field errors.
  /// The individual blocs will have errorMessage which will be shown against them.
  /// This can be used to handle the errors in non-bloc fields.
  List<ValidationError>? errors;

  SingletonFailureEvent(this.failureMessage, {this.errors});
}
