import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app_bloc/Domain/auth/i_auth_facade.dart';
import 'package:notes_app_bloc/Domain/core/errors.dart';
import 'package:notes_app_bloc/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {


   final userOption =  getIt<IAuthFacade>().getSignedInUser();
   final user = userOption.getOrElse(() => throw NotAuthenticatedError());
   return FirebaseFirestore.instance.collection("users").doc(user.id.getOrCrash())
   
   ;



  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}