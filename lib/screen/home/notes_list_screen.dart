import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../data/models/note_model.dart';
// import '../../../logic/blocs/auth_bloc/auth_bloc.dart';
// import '../../../logic/blocs/auth_bloc/auth_event.dart';
import '../../../logic/blocs/notes_bloc/notes_bloc.dart';
import '../../../logic/blocs/notes_bloc/notes_event.dart';
import '../../../logic/blocs/notes_bloc/notes_state.dart';
import '../../logic/blocs/auth_bloc.dart';
import '../../logic/blocs/auth_event.dart';
import '../../widgets/loading_indicator.dart';
// import '../profile/profile_screen.dart';
import '../profile_screen.dart';
import 'note_details_screen.dart';
import 'note_editor_screen.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId =
        context.read<AuthBloc>().authRepository.getCurrentUser()?.uid;
    context.read<NotesBloc>().add(LoadNotes(userId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ProfileScreen()))),
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => context.read<AuthBloc>().add(LoggedOut())),
        ],
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) return LoadingIndicator();
          if (state is NotesFailure) return Center(child: Text(state.error));
          if (state is NotesLoaded && state.notes.isEmpty)
            return const Center(child: Text("No notes yet."));

          if (state is NotesLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.timestamp.toLocal().toString()),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NoteDetailsScreen(note))),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => NoteEditorScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
