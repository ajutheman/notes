import 'package:equatable/equatable.dart';

import '../../data/models/models/note_model.dart';

// import '../../../data/models/note_model.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotes extends NotesEvent {
  final String userId;

  const LoadNotes(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddNote extends NotesEvent {
  final NoteModel note;

  const AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateNote extends NotesEvent {
  final NoteModel note;

  const UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NotesEvent {
  final String noteId;

  const DeleteNote(this.noteId);

  @override
  List<Object?> get props => [noteId];
}
