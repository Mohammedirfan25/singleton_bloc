// Import necessary packages and files
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:singleton_bloc/singleton_bloc.dart';

// Import the classes you want to test

// Mocking the State classes for testing
class MockSingletonState extends Mock {}

void main() {
  group("SingletonCubit Test Cases", () {
    late SingletonCubit bloc;

    setUp(() => bloc = SingletonCubit(
        SingletonState<MockSingletonState>(MockSingletonState())));

    tearDown(() => bloc.close());

    test("emitLoadingState should change the state to SingletonLoadingState",
        () {
      bloc.emitLoadingState();

      expectLater(bloc.state, isA<SingletonLoadingState>());
    });

    test("emitLoadedState should change the state to SingletonLoadedState", () {
      bloc.emitLoadedState();

      expect(bloc.state, isA<SingletonLoadedState>());
    });

    test("emitSuccessState should change the state to SingletonSuccessState",
        () {
      bloc.emitSuccessState();

      expect(bloc.state, isA<SingletonSuccessState>());
    });

    test("emitFailureState should change the state to SingletonFailureState",
        () {
      bloc.emitFailureState("Error");

      expect(bloc.state, isA<SingletonFailureState>());
    });

    test("emitStateChanged should emit new state of the previous state ", () {
      bloc.emitLoadedState();

      expect(bloc.state, isA<SingletonLoadedState>());

      bloc.emitStateChanged();

      expect(bloc.state, isA<SingletonLoadedState>());
    });
  });

  group("SingletonBloc Test Cases", () {
    late SingletonBloc bloc;

    setUp(() => bloc = SingletonBloc(
        SingletonState<MockSingletonState>(MockSingletonState())));

    tearDown(() => bloc.close());

    test("emitLoadingState should change the state to SingletonLoadingState",
        () {
      bloc.emitLoadingState();

      expectLater(bloc.stream, emits(isA<SingletonLoadingState>()));
    });

    test("emitLoadedState should change the state to SingletonLoadedState", () {
      bloc.emitLoadedState();

      expectLater(bloc.stream, emits(isA<SingletonLoadedState>()));
    });

    test("emitSuccessState should change the state to SingletonSuccessState",
        () {
      bloc.emitSuccessState();

      expectLater(bloc.stream, emits(isA<SingletonSuccessState>()));
    });

    test("emitFailureState should change the state to SingletonFailureState",
        () {
      bloc.emitFailureState("Error");

      expectLater(bloc.stream, emits(isA<SingletonFailureState>()));
    });

    test("emitStateChanged should emit new state of the previous state ", () {
      bloc.emitLoadedState();

      expectLater(bloc.stream, emits(isA<SingletonLoadedState>()));

      bloc.emitStateChanged();

      expectLater(bloc.stream, emits(isA<SingletonLoadedState>()));
    });
  });
}
