part of 'auth_bloc_bloc.dart';

@freezed
abstract class AuthBlocEvent with _$AuthBlocEvent {
  const factory AuthBlocEvent.authCheckedRequested() = AuthCheckedRequested;
  const factory AuthBlocEvent.signedOut() = SignedOut;
}