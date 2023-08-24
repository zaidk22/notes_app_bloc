import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app_bloc/Domain/notes/i_note_repository.dart';
import 'package:notes_app_bloc/Domain/notes/note_failure.dart';

import '../../../Domain/notes/note.dart';

part 'note_actor_event.dart';
part 'note_actor_state.dart';
part 'note_actor_bloc.freezed.dart';

@injectable
class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  final INoteRepository _noteRepository;
  NoteActorBloc(this._noteRepository) : super(const NoteActorState.initial()) {
    on< _Deleted>((event, emit) async{
      final possibleFailure = await _noteRepository.delete(event.note);
      possibleFailure.fold((l) => emit(NoteActorState.deleteFailure(l)),
       (r) => emit(const NoteActorState.deleteSuccess()),);
    });
  }
}
