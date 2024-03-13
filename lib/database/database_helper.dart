import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notes/model/notes_model.dart';

class DatabaseHelper {
  // static addNotes(NotesModel notesmodel) async {
  //   final notesCollection = FirebaseFirestore.instance.collection('Notes');
  //   String id = notesCollection.doc().id;

  //   final newNote = NotesModel(
  //           id: id,
  //           title: notesmodel.title,
  //           description: notesmodel.description)
  //       .toMap();

  //   await notesCollection.doc(id).set(newNote);
  // }

  static addNotes(NotesModel notesmodel) async {
    try {
      final notesCollection = FirebaseFirestore.instance.collection('Notes');
      String id = notesCollection.doc().id;

      final newNote = NotesModel(
        id: id,
        title: notesmodel.title,
        description: notesmodel.description,
      ).toMap();

      await notesCollection.doc(id).set(newNote);
      log('Note added successfully to Firestore with id: $id');
    } catch (e) {
      log('Error adding note to Firestore: $e');
    }
  }

  static Stream<List<NotesModel>> showAllNotes() {
    final notesCollection = FirebaseFirestore.instance.collection('Notes');
    return notesCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((note) => NotesModel.fromSnapshot(note)).toList());
  }

  static updateNote(NotesModel notesModel) {
    final notesCollection = FirebaseFirestore.instance.collection('Notes');
    final updatedNote = NotesModel(
            id: notesModel.id,
            title: notesModel.title,
            description: notesModel.description)
        .toMap();
    notesCollection.doc(notesModel.id).update(updatedNote);
  }

  static deleteNote(String id) {
    final notesCollection = FirebaseFirestore.instance.collection('Notes');
    notesCollection.doc(id).delete();
  }
}
