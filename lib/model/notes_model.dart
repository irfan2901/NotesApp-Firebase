import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String? id;
  final String? title;
  final String? description;

  NotesModel({
    this.id,
    this.title,
    this.description,
  });

  NotesModel copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return NotesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  static NotesModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return NotesModel(
      id: snapshot['id'],
      title: snapshot['title'],
      description: snapshot['description'],
    );
  }
}
