import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app_bloc/Domain/auth/auth_failure.dart';
import 'package:notes_app_bloc/Domain/auth/i_auth_facade.dart';
import 'package:notes_app_bloc/Domain/auth/value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';


@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
            emailAddress: EmailAddress(e.emailStr),
            authFailureOrSuccessOption: none());
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
            password: Password(e.passStr), authFailureOrSuccessOption: none());
      },
      registerWithEmailAndPassword: (e) async* {
        yield* _performAction(
          _authFacade.registerWithEmailAndPassword
        );
      },

      signInWithEmailAndPassword: (e) async* {
         yield* _performAction(
          _authFacade.signInWithEmailAndPassword
        );
      },
      signInWithGooglePressesd: (e) async* {
       yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none()
       );
       final failureOrSuccess = await  _authFacade.signInWithGoogle();
        yield state.copyWith(
        isSubmitting:false,
        authFailureOrSuccessOption: some(failureOrSuccess)
       );
      },
    );
  }

Stream <SignInFormState> _performAction(
Future <Either<AuthFailure,Unit>> Function({
required EmailAddress emailAddress,
required Password password
}) 

forwardedCall,

) async*{


        Either<AuthFailure,Unit> failureOrSuccess;

       if(state.emailAddress.isValid()&&state.password.isValid()){
         yield state.copyWith(
          isSubmitting: true,
             authFailureOrSuccessOption: none());
                failureOrSuccess = await  forwardedCall(emailAddress: state.emailAddress,
                password: state.password);
                  yield state.copyWith(
        isSubmitting:false,
        authFailureOrSuccessOption: some(failureOrSuccess)
       );
       }
        else {
    failureOrSuccess = left(const AuthFailure.invalidEmailAndPasswordCombination());
  }

         yield state.copyWith(
       showErrorMessage: true,
       isSubmitting: false,
       authFailureOrSuccessOption: optionOf(failureOrSuccess)
       );

}

}
