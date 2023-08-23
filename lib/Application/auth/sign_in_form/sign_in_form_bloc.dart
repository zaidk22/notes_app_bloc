import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';

import '../../../../Domain/auth/auth_failure.dart';
import '../../../../Domain/auth/i_auth_facade.dart';
import '../../../../Domain/auth/value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<_$EmailChanged>((event, emit) async {
      emit.call(state.copyWith(
          emailAddress: EmailAddress(event.emailStr),
          authFailureOrSuccessOption: none()));
    });
    on<_$PasswordChanged>((event, emit) async {
      emit.call(state.copyWith(
          password: Password(event.passStr),
          authFailureOrSuccessOption: none()));
    });

    on<_$RegisterWithEmailAndPassword>((event, emit) async {
      emit.call(state.copyWith(
          isSubmitting: true, authFailureOrSuccessOption: none()));

      final failureOrSuccess = await _authFacade.registerWithEmailAndPassword(
          emailAddress: state.emailAddress, password: state.password);
      emit.call(
        failureOrSuccess.fold(
          (l) => state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(left(l)),
          ),
          (r) => state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(right(unit)),
          ),
        ),
      );
      emit.call(
        state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: none(),
        ),
      );
    });

 on<_$SignInWithEmailAndPassword>((event, emit) async {
      emit.call(state.copyWith(
          isSubmitting: true, authFailureOrSuccessOption: none()));

      final failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
          emailAddress: state.emailAddress, password: state.password);
      emit.call(
        failureOrSuccess.fold(
          (l) => state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(left(l)),
          ),
          (r) => state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(right(unit)),
          ),
        ),
      );
      emit.call(
        state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: none(),
        ),
      );
    });

    on<_$SignInWithGooglePressesd>(
      (event, emit) async {
        emit.call(
          state.copyWith(
              isSubmitting: true, authFailureOrSuccessOption: none()),
        );
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        emit.call(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess)));
      },
    );
  }
}
