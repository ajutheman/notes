import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models/note_model.dart';

// import '../models/note_model.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NoteModel>> getNotes(String userId) async {
    final snapshot = await _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList();
  }

  Future<void> addNote(NoteModel note) async {
    await _firestore.collection('notes').add(note.toMap());
  }

  Future<void> updateNote(NoteModel note) async {
    await _firestore.collection('notes').doc(note.id).update(note.toMap());
  }

  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}
