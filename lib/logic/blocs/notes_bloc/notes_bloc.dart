import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../data/repositories/notes_repository.dart';
import '../../data/repositories/notes_repository.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository notesRepository;

  NotesBloc({required this.notesRepository}) : super(NotesInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NotesLoading());
      try {
        final notes = await notesRepository.getNotes(event.userId);
        emit(NotesLoaded(notes));
      } catch (e) {
        emit(NotesFailure(e.toString()));
      }
    });

    on<AddNote>((event, emit) async {
      emit(NotesLoading());
      try {
        await notesRepository.addNote(event.note);
        final notes = await notesRepository.getNotes(event.note.userId);
        emit(NotesLoaded(notes));
      } catch (e) {
        emit(NotesFailure(e.toString()));
      }
    });

    on<UpdateNote>((event, emit) async {
      emit(NotesLoading());
      try {
        await notesRepository.updateNote(event.note);
        final notes = await notesRepository.getNotes(event.note.userId);
        emit(NotesLoaded(notes));
      } catch (e) {
        emit(NotesFailure(e.toString()));
      }
    });

    on<DeleteNote>((event, emit) async {
      emit(NotesLoading());
      try {
        await notesRepository.deleteNote(event.noteId);
        final currentState = state;
        if (currentState is NotesLoaded) {
          final notes = currentState.notes
              .where((note) => note!.id != event.noteId)
              .toList();
          emit(NotesLoaded(notes));
        }
      } catch (e) {
        emit(NotesFailure(e.toString()));
      }
    });
  }
}
