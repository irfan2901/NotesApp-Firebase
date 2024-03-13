import 'package:firebase_notes/bloc/notes_bloc.dart';
import 'package:firebase_notes/model/notes_model.dart';
import 'package:firebase_notes/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddorUpdateNotes extends StatefulWidget {
  final NotesModel? notesModel;
  const AddorUpdateNotes({super.key, this.notesModel});

  @override
  State<AddorUpdateNotes> createState() => _AddorUpdateNotesState();
}

class _AddorUpdateNotesState extends State<AddorUpdateNotes> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.notesModel?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.notesModel?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _saveNote();
            },
            icon: const Icon(Icons.save),
          ),
          if (widget.notesModel != null)
            IconButton(
              onPressed: () async {
                _deleteNote();
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomWidgets.customTextField(titleController, 'Title'),
            CustomWidgets.customTextField(descriptionController, 'Description'),
          ],
        ),
      ),
    );
  }

  _saveNote() {
    if (widget.notesModel != null) {
      var updatedNote = NotesModel(
          id: widget.notesModel!.id,
          title: titleController.text,
          description: descriptionController.text);
      context.read<NotesBloc>().add(UpdateNotesEvent(updatedNote));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note Updated successfully!'),
        ),
      );
    } else {
      var newNote = NotesModel(
          title: titleController.text, description: descriptionController.text);
      context.read<NotesBloc>().add(AddNotesEvent(newNote));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note added successfully!'),
        ),
      );
    }
    Navigator.pop(context);
  }

  _deleteNote() {
    var id = widget.notesModel!.id;
    context.read<NotesBloc>().add(DeleteNotesEvent(id!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note deleted successfully!'),
      ),
    );
    Navigator.pop(context);
  }
}
