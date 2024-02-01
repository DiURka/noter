import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noter/providers/note_provider.dart';
import 'package:noter/models/note.dart';
import 'package:noter/screens/edit_note_screen.dart';
import 'package:noter/screens/note_detail_screen.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final int order;

  const NoteCard({super.key, required this.note, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // Show options for editing and deleting
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit'),
                  onTap: () {
                    Navigator.pop(context); // Close the bottom sheet
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditNoteScreen(note: note)),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Delete'),
                  onTap: () {
                    Navigator.pop(context); // Close the bottom sheet
                    // Implement delete logic and show a confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Note'),
                          content: const Text('Are you sure you want to delete this note?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Implement delete logic and then close the dialog
                                Provider.of<NoteProvider>(context, listen: false).deleteNote(note.id);
                                Navigator.pop(context);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        );
      },

      child: Container(
        constraints: const BoxConstraints(maxHeight: 200),
        child: Card(
        margin: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetailScreen(note: note, order: order),
              ),
            );
          },
          child: ListTile(
            title: Text(note.title),
            subtitle: OverflowBox(
              maxHeight: double.infinity,
              alignment: Alignment.topCenter,
              child: Text(
                note.content,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditNoteScreen(note: note)));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Implement your delete functionality here
                    // For example, show a confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Note'),
                          content: const Text('Are you sure you want to delete this note?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Implement delete logic and then close the dialog
                                Provider.of<NoteProvider>(context, listen: false).deleteNote(note.id);
                                Navigator.pop(context);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        ),
      )

    );
  }
}