import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:notes_app_bloc/Domain/auth/auth_failure.dart';
import 'package:notes_app_bloc/Domain/auth/user.dart';

import './value_objects.dart';


abstract class IAuthFacade {

Option<User> getSignedInUser();

  Future<Either<AuthFailure,Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password
  });


  Future<Either<AuthFailure,Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password
  });


  Future<Either<AuthFailure,Unit>> signInWithGoogle();

Future<void> signOut();

}