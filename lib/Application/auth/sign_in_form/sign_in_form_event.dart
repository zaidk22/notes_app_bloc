part of 'sign_in_form_bloc.dart';

@freezed
abstract class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(String emailStr) = EmailChanged;
  const factory SignInFormEvent.passwordChanged(String passStr) = PasswordChanged;

  const factory SignInFormEvent.registerWithEmailAndPassword() = RegisterWithEmailAndPassword;
    const factory SignInFormEvent.signInWithEmailAndPassword() = SignInWithEmailAndPassword;
      const factory SignInFormEvent.signInWithGooglePressesd() = SignInWithGooglePressesd;
}