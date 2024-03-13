part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

class FetchNotesEvent extends NotesEvent {
  // final List<NotesModel> notesModel;
  // FetchNotesEvent(this.notesModel);
}

class AddNotesEvent extends NotesEvent {
  final NotesModel notesModel;
  AddNotesEvent(this.notesModel);
}

class UpdateNotesEvent extends NotesEvent {
  final NotesModel notesModel;
  UpdateNotesEvent(this.notesModel);
}

class DeleteNotesEvent extends NotesEvent {
  final String id;
  DeleteNotesEvent(this.id);
}
