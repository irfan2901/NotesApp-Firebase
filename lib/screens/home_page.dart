import 'package:firebase_notes/bloc/notes_bloc.dart';
import 'package:firebase_notes/cubit/theme_cubit.dart';
import 'package:firebase_notes/model/notes_model.dart';
import 'package:firebase_notes/screens/add_or_update_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(FetchNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          Switch(
            value: context.watch<ThemeCubit>().state.isDark,
            onChanged: (value) {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NotesLoadedState) {
            return StreamBuilder<List<NotesModel>>(
              stream: state.notesModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading notes'),
                  );
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notes available',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  );
                } else {
                  final notesList = snapshot.data!;
                  return AlignedGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      final note = notesList[index];
                      return Card(
                        color: Colors.amberAccent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              note.title!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              note.description!,
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () async {
                              NotesModel? updatedNote = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddorUpdateNotes(
                                    notesModel: note,
                                  ),
                                ),
                              );
                              if (updatedNote != null) {
                                context
                                    .read<NotesBloc>()
                                    .add(UpdateNotesEvent(updatedNote));
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
          if (state is NotesErrorState) {
            return const Center(
              child: Text('Error loading notes'),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddorUpdateNotes(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
