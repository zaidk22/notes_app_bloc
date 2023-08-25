import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:notes_app_bloc/Domain/notes/value_objects.dart';
import 'package:notes_app_bloc/Presentation/pages/notes/note_form/misc/todo_item_presentation_classes.dart';

import '../../../Domain/notes/i_note_repository.dart';
import '../../../Domain/notes/note.dart';
import '../../../Domain/notes/note_failure.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository _noteRepository;
  NoteFormBloc(this._noteRepository) : super(NoteFormState.initial()) {
    on<_Initialized>((event, emit) {
      emit.call(state.copyWith(
        isEditing: true,
        isSaving: false,
       
      ));
      
    });
       on<_BodyChanged>((event, emit) {
      emit.call(state.copyWith(
        note:  state.note.copyWith(body: NoteBody(event.bodyStr)),
        saveFailureOrSuccessOption: none()
       
      ));
      
    });
        on<_ColorChanged>((event, emit) {
      emit.call(state.copyWith(
       note: state.note.copyWith(color: NoteColor(event.color)),
        saveFailureOrSuccessOption: none()
       
      ));
      
    });
   on<_Saved>((event, emit) async {
      Either<NoteFailure, Unit>? failureOrSuccess;

      emit(
        state.copyWith(
          isSaving: true,
          saveFailureOrSuccessOption: none(),
        ),
      );

      if (state.note.failureOption.isNone()) {
        failureOrSuccess = state.isEditing
            ? await _noteRepository.update(state.note)
            : await _noteRepository.create(state.note);
      }

      emit(
        state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          saveFailureOrSuccessOption: optionOf(failureOrSuccess),
        ),
      );
    });
  }
}
