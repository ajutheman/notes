import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../data/models/note_model.dart';
import '../../../logic/blocs/notes_bloc/notes_bloc.dart';
import '../../../logic/blocs/notes_bloc/notes_event.dart';
import '../../logic/data/models/models/note_model.dart';
import 'note_editor_screen.dart';

class NoteDetailsScreen extends StatelessWidget {
  final NoteModel note;

  const NoteDetailsScreen(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note.title), actions: [
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<NotesBloc>().add(DeleteNote(note.id));
              Navigator.pop(context);
            }),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => NoteEditorScreen(note: note))),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(note.content, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Text('Created: ${note.timestamp.toLocal()}',
              style: const TextStyle(color: Colors.grey)),
        ]),
      ),
    );
  }
}
