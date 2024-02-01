import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noter/models/note.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _notesCollection = FirebaseFirestore.instance.collection('notes');

  Future<Map<String, dynamic>?> getUserData(String? userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _db.collection('users').doc(userId).get();

      if (userDoc.exists) {
        return userDoc.data();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Stream<List<Note>> getNotes(String? userId) {
    return _notesCollection
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Note(
            id: doc.id,
            title: doc['title'],
            content: doc['content'],
            userId: doc['userId'],
          );
        }).toList();
    });
  }

  Future<void> addNote(Note note) async {
    await _notesCollection.add({
      'userId': note.userId,
      'title': note.title,
      'content': note.content,
    });
  }

  Future<void> updateNote(Note note) async {
    await _notesCollection.doc(note.id).update({
      'title': note.title,
      'content': note.content,
    });
  }

  Future<void> deleteNote(String noteId) async {
    await _notesCollection.doc(noteId).delete();
  }
}