import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:noter/providers/note_provider.dart';
import 'package:noter/models/note.dart';
import 'package:noter/screens/create_note_screen.dart';
import 'home_screen.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;
  const EditNoteScreen({super.key, required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  late String userIdentifier; // Declare userIdentifier as a late variable

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
    _loadUserIdentifier(); // Call this function in initState
  }

  void _loadUserIdentifier() async {
    userIdentifier = (await getUserId()) ?? ''; // Use the null-aware operator to handle null case
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                counterText: '',
              ),
              maxLines: null,
              maxLength: 65,
              maxLengthEnforcement: MaxLengthEnforcement.enforced
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                counterText: '',
              ),
              maxLines: null,
              maxLength: 800, // Set your desired character limit
              maxLengthEnforcement: MaxLengthEnforcement.enforced
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // // Update note in the provider and Firestore
                // Provider.of<NoteProvider>(context, listen: false).updateNote(
                //   Note(
                //     id: '', // replace with the actual value
                //     title: _titleController.text, // replace with the actual value
                //     content: _contentController.text, // replace with the actual value
                //     userId: userIdentifier, // replace with the actual value
                //   ),
                // );

                // Update note in the provider and Firestore
                Note updatedNote = Note(
                  id: widget.note.id, // Use the id from the original note
                  title: _titleController.text,
                  content: _contentController.text,
                  userId: userIdentifier,
                );

                await Provider.of<NoteProvider>(context, listen: false).updateNote(updatedNote);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}