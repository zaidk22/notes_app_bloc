

import 'package:notes_app_bloc/Domain/core/failures.dart';

class NotAuthenticatedError extends Error{
  
}
class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;
  UnexpectedValueError(
  this.valueFailure,
  );
  

  @override
  String toString() => Error.safeToString('UnexpectedError(valueFailure: $valueFailure)');
}
