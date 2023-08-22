part of 'sign_in_form_bloc.dart';

@freezed
abstract class SignInFormState with _$SignInFormState {
  const factory SignInFormState(
    {
      required EmailAddress emailAddress,
      required Password password,
      required bool isSubmitting,
      required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
      required bool showErrorMessage

    }
  ) = _SignInFormState;
  factory  SignInFormState.initial()=> SignInFormState(
    emailAddress: EmailAddress(""),
    password: Password(""),
    showErrorMessage: false,
    authFailureOrSuccessOption: none(),
    isSubmitting: false

  );
}
