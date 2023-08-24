import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../Domain/auth/i_auth_facade.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';
part 'auth_bloc_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
   final IAuthFacade _authFacade;
  AuthBloc(this._authFacade) : super( const AuthBlocState.initial()) {
    on<_$AuthCheckedRequested>((event, emit) {
          final userOption =_authFacade.getSignedInUser();
          userOption.fold(() => emit(const AuthBlocState.unauthenticated()), (_) => emit(const  AuthBlocState.authenticated() ),);
          
    });
      on<_$SignedOut>((event, emit) {
          _authFacade.signOut();
       
        emit( const AuthBlocState.unauthenticated());
        
          
    });
  }
}
