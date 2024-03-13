part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  final Stream<List<NotesModel>>? notesModel;
  final String? id;

  NotesLoadedState({this.notesModel, this.id});
}

class NotesErrorState extends NotesState {
  final String error;

  NotesErrorState(this.error);
}
