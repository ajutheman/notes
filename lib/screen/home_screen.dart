import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/screen/profile_screen.dart';

import '../../../logic/blocs/auth_bloc.dart';
import '../../../logic/blocs/notes_bloc/notes_bloc.dart';
import '../../../logic/blocs/notes_bloc/notes_event.dart';
import '../../../logic/blocs/notes_bloc/notes_state.dart';
import '../../widgets/loading_indicator.dart';
import 'home/note_editor_screen.dart';
import 'note_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final dateFormatter = DateFormat('MMM d, yyyy – hh:mm a');

  @override
  Widget build(BuildContext context) {
    final userId =
        context.read<AuthBloc>().authRepository.getCurrentUser()?.uid;
    context.read<NotesBloc>().add(LoadNotes(userId!));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notes, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "My Colorful Notes",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.person, color: Colors.deepPurpleAccent),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen()),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0F2F0), Color(0xFF000C40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return Center(child: LoadingIndicator());
              }

              if (state is NotesFailure) {
                return Center(
                  child: Text(
                    "🚫 ${state.error}",
                    style:
                        const TextStyle(color: Colors.redAccent, fontSize: 16),
                  ),
                );
              }

              if (state is NotesLoaded && state.notes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_add,
                          size: 100, color: Colors.deepPurple.shade200),
                      const SizedBox(height: 20),
                      const Text(
                        "No notes yet!\nTap ➕ to create one!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70),
                      ),
                    ],
                  ),
                );
              }

              if (state is NotesLoaded) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    final formattedDate = dateFormatter.format(note.timestamp);

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orangeAccent.shade100,
                            Colors.pinkAccent.shade200,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(4, 6),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        leading: const Icon(Icons.edit_note,
                            color: Colors.white, size: 32),
                        title: Text(
                          note.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          formattedDate,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right,
                            color: Colors.white70, size: 28),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NoteDetailsScreen(note: note),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        label: const Row(
          children: [
            Icon(Icons.add, size: 28),
            SizedBox(width: 6),
            Text("Add Note", style: TextStyle(fontSize: 16)),
          ],
        ),
        elevation: 10,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NoteEditorScreen()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
