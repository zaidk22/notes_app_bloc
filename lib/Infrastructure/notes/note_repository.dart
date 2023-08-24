
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

import 'package:notes_app_bloc/Domain/notes/i_note_repository.dart';
import 'package:notes_app_bloc/Domain/notes/note.dart';
import 'package:notes_app_bloc/Domain/notes/note_failure.dart';
import 'package:notes_app_bloc/Infrastructure/notes/notes_dtos.dart';
import '../core/firestore_helpers.dart';

@LazySingleton(as :INoteRepository)
class NoteRepository implements INoteRepository{
  final FirebaseFirestore _firestore;
  NoteRepository(this._firestore);


  
  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchAll() async* {
final userDoc = await _firestore.userDocument();
    yield* userDoc.noteCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => right<NoteFailure, KtList<Note>>(
            snapshot.docs
                .map((doc) => NoteDto.fromFirestore(doc).toDomain())
                .toImmutableList(),
          ),
        )
        .onErrorReturnWith((e) {
      if (e is FirebaseException && e.message.contains('PERMISSION_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        // log.error(e.toString());
        return left(const NoteFailure.unexpected());
      }
    });
  }

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted() {
   
  }
  
  @override
  Future<Either<NoteFailure, Unit>> create(Note note) async {
 try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDto.fromDomain(note);

      await userDoc.noteCollection.doc(noteDto.id).set(noteDto.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('PERMISSION_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        return left(const NoteFailure.unexpected());
      }
    }
  
  }

  @override
  Future<Either<NoteFailure, Unit>> delete(Note note) {

  }

  @override
  Future<Either<NoteFailure, Unit>> update(Note note) {
 
  }

  
}