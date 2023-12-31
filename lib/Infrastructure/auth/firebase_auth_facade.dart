import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:notes_app_bloc/Domain/auth/auth_failure.dart';
import 'package:notes_app_bloc/Domain/auth/i_auth_facade.dart';
import 'package:notes_app_bloc/Domain/auth/user.dart' as user;
import 'package:notes_app_bloc/Domain/auth/value_objects.dart';
import './firebase_user_mapper.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);
  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passStr = password.getOrCrash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddressStr, password: passStr);
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError("Something went wrong"));
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required EmailAddress emailAddress, required Password password}) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddressStr, password: passStr);
      return right(unit);
    } on FirebaseAuthException catch (e) {
    
      if (e.message == 'The password is invalid or the user does not have a password.' ) {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError("Something went wrong"));
     }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    // add try catch later
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuthCredential = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuthCredential.accessToken,
          idToken: googleAuthCredential.idToken);
      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then((value) => right(unit));
    } on PlatformException catch (e) {
      return left(const AuthFailure.serverError("Something went wrong"));
    }
  }



  @override
  Future<void> signOut() {
    return Future.wait([_googleSignIn.signOut(), _firebaseAuth.signOut()]);
  }

  @override
  Option<user.User> getSignedInUser() => optionOf(_firebaseAuth?.currentUser?.toDomain());
}
