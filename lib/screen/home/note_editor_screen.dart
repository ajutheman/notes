import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../data/models/note_model.dart';
// import '../../../logic/blocs/auth_bloc/auth_bloc.dart';
import '../../../logic/blocs/notes_bloc/notes_bloc.dart';
import '../../../logic/blocs/notes_bloc/notes_event.dart';
import '../../../logic/blocs/notes_bloc/notes_state.dart';
import '../../logic/blocs/auth_bloc.dart';
import '../../logic/data/models/models/note_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loading_indicator.dart';

class NoteEditorScreen extends StatefulWidget {
  final NoteModel? note;

  const NoteEditorScreen({this.note});

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId =
        context.read<AuthBloc>().authRepository.getCurrentUser()?.uid;

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.note != null ? "Edit Note" : "Create Note")),
      body: BlocListener<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesLoaded) Navigator.pop(context);
          if (state is NotesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: titleController,
                  hintText: "Title",
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: contentController,
                  hintText: "Content",
                ),
                const SizedBox(height: 30),
                BlocBuilder<NotesBloc, NotesState>(
                  builder: (context, state) {
                    if (state is NotesLoading) {
                      return LoadingIndicator();
                    }
                    return CustomButton(
                      text: widget.note != null ? "Update Note" : "Add Note",
                      onPressed: () {
                        final note = NoteModel(
                          id: widget.note?.id ?? '',
                          userId: userId!,
                          title: titleController.text.trim(),
                          content: contentController.text.trim(),
                          timestamp: DateTime.now(),
                        );
                        if (widget.note != null) {
                          context.read<NotesBloc>().add(UpdateNote(note));
                        } else {
                          context.read<NotesBloc>().add(AddNote(note));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
