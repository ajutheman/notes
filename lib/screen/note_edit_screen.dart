import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';

class NoteEditScreen extends StatefulWidget {
  final DocumentSnapshot? note;
  const NoteEditScreen({this.note});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!['title'] ?? '';
      _contentController.text = widget.note!['content'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.note != null ? "Edit Note" : "Add New Note"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _contentController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: "Write your note here...",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.note != null
                            ? Colors.blueAccent
                            : Colors.greenAccent.shade700,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        if (_titleController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Title cannot be empty'),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }

                        if (widget.note != null) {
                          await widget.note!.reference.update({
                            'title': _titleController.text.trim(),
                            'content': _contentController.text.trim(),
                            'timestamp': Timestamp.now(),
                          });
                        } else {
                          await FirebaseFirestore.instance
                              .collection('notes')
                              .add({
                            'title': _titleController.text.trim(),
                            'content': _contentController.text.trim(),
                            'userId': user!.uid,
                            'timestamp': Timestamp.now(),
                          });
                        }
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.save),
                      label: Text(
                        widget.note != null ? "Update Note" : "Add Note",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
