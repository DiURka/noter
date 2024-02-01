import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noter/providers/note_provider.dart';
import 'package:noter/services/auth_service.dart';
import 'package:noter/models/note.dart';
import 'package:noter/widgets/note_card.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Your Notes'),
        ),
        body: buildNoteStream(),
      );

  }

  StreamBuilder<List<Note>> buildNoteStream() {
    return StreamBuilder<List<Note>>(
      stream: Provider.of<NoteProvider>(context).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Note> notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return Center(child: Text('No notes available.'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteCard(note: notes[index], order: index + 1);
            },
          );
        }
      },
    );
  }
}