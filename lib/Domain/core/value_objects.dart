


// ignore_for_file: avoid_renaming_method_parameters

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:notes_app_bloc/Domain/core/failures.dart';

import 'errors.dart';


@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;
  T getOrCrash(){
     return value.fold((l) => throw UnexpectedValueError(l), (r) => r);
  }
  bool isValid() => value.isRight();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}


