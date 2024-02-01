import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noter/services/firestore_service.dart';
import 'package:noter/services/auth_service.dart';
import 'package:noter/models/note.dart';

class NoteProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  List<Note> _notes = [];
  bool _isLoading = false;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'This email is already in use. Please use a different email.';
        case 'weak-password':
          return 'The password is too weak. Please choose a stronger password.';
        default:
          return 'Registration failed. Please try again.';
      }
    } else {
      return 'Registration failed. Please try again.';
    }
  }

  String getDisplayName(User? user, Map<String, dynamic>? userData) {
    if (userData != null &&
        userData.containsKey('name') &&
        userData['name'].isNotEmpty) {
      return userData['name'];
    } else if (user != null) {
      return user.email ?? '';
    } else {
      return '';
    }
  }

  Future<Map<String, dynamic>?> getUserData(User? user) async {
    // Fetch user data from FirestoreService
    return await _firestoreService.getUserData(user?.uid);
  }

  Stream<List<Note>> getNotes() {
    String? userId = _authService.currentUser?.uid;
    return _firestoreService.getNotes(userId);
  }

  Future<void> addNote(Note note) async {
    try {
      String? userId = _authService.currentUser?.uid;

      note = note.copyWith(userId: userId);
      await _firestoreService.addNote(note);
        } catch (error) {
      print('Add Note Error: $error');
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await _firestoreService.updateNote(note);
      notifyListeners();
    } catch (error) {
      print('Add Note Error: $error');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _firestoreService.deleteNote(noteId);
      notifyListeners();
    } catch (error) {
      print('Delete Note Error: $error');
    }
  }

  Future<void> register(String email, String password, {String? name}) async {
    setLoading(true);

    try {
      await _authService.register(email, password, name: name);

      setLoading(false);

      print('Registration successful. User: $email');
    } catch (error) {
      print('Registration error: $error');

      String errorMessage = _getErrorMessage(error);
      throw errorMessage;

      setLoading(false);
    }
  }

  Future<bool> login(String email, String password) async {
    setLoading(true);

    try {
      User? user = await _authService.login(email, password);
      setLoading(false);

      if (user != null) {
        print('Login successful. User: ${user.uid}');
        return true;
      } else {
        print('Authentication failed');
        return false;
      }
    } catch (error) {
      print('Login error: $error');
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}