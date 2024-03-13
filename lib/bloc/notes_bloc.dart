// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:firebase_notes/database/database_helper.dart';
import 'package:firebase_notes/model/notes_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<FetchNotesEvent>((event, emit) async {
      emit(NotesLoadingState());
      var notes = DatabaseHelper.showAllNotes();
      emit(NotesLoadedState(notesModel: notes));
    });

    on<AddNotesEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        await DatabaseHelper.addNotes(event.notesModel);
        var notes = DatabaseHelper.showAllNotes();
        emit(NotesLoadedState(notesModel: notes));
      },
    );

    on<UpdateNotesEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        await DatabaseHelper.updateNote(event.notesModel);
        var notes = DatabaseHelper.showAllNotes();
        emit(NotesLoadedState(notesModel: notes));
      },
    );

    on<DeleteNotesEvent>(
      (event, emit) async {
        emit(NotesLoadingState());
        await DatabaseHelper.deleteNote(event.id);
        var notes = DatabaseHelper.showAllNotes();
        emit(NotesLoadedState(notesModel: notes));
      },
    );
  }
}
