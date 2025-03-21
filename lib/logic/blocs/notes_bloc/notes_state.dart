import 'package:equatable/equatable.dart';

import '../../data/models/models/note_model.dart';

// import '../../../data/models/note_model.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NoteModel> notes;

  const NotesLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NotesFailure extends NotesState {
  final String error;

  const NotesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
