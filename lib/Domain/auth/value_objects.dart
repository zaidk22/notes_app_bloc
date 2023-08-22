
// ignore_for_file: unnecessary_null_comparison

import 'package:dartz/dartz.dart';
import 'package:notes_app_bloc/Domain/core/value_objects.dart';

import '../core/failures.dart';
import '../core/value_validators.dart';



class EmailAddress extends ValueObject {
  @override
  final Either<ValueFailure<String>,String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);

}

class Password extends ValueObject {
  @override
  final Either<ValueFailure<String>,String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);

}




