import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app_bloc/Domain/auth/value_objects.dart';


import '../../Domain/auth/user.dart' as user;

extension FirebaseDomainX on User{
 user.User toDomain(){
    return  user.User(
      id: UniqueId.fromUniqueString(uid)
    );
  }
}