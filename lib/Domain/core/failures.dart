import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength(
      {required T failedValue, required int max}) = ExceedingLength<T>;

  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;

   const factory ValueFailure.multiline({
required T failedValue,

  }) = Multiline<T>;

   const factory ValueFailure.listTooLong({
required T failedValue,
required int max

  }) = ListTooLong<T>;
  const factory ValueFailure.invalidEmail({required String failedValue}) =
      InvalidEmail<T>;
  const factory ValueFailure.shortPassword({required String failedValue}) =
      ShortPassword<T>;
}

// @freezed
// abstract class ValueFailure<T> With _$ValueFailure<T> {
//   const factory ValueFailure.auth(AuthValueFailure<T> f) =_Auth<T>;
//   const factory ValueFailure.notes(NotesValueFailure<T> f) =_Notes<T>;
// }

// @freezed
// abstract class AuthValueFailure<T> with _$AuthValueFailure<T>{
//   const factory AuthValueFailure.invalidEmail({
// required String failedValue
//   }) = InvalidEmail<T>;
//    const factory AuthValueFailure.shortPassword({
// required String failedValue
//   }) = ShortPassword<T>;
// }

// @freezed
// abstract class NotesValueFailure<T> with _$NotesValueFailure<T>{
//   const factory NotesValueFailure.exceedingLength({
// required String failedValue
//   }) = ExceedingLength<T>;

// }